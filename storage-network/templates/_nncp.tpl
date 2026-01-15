{{/*
Render a single NNCP for one hostname + one VLAN
*/}}
{{- define "storage-network.nncp" }}
apiVersion: nmstate.io/v1
kind: NodeNetworkConfigurationPolicy
metadata:
  name: {{ .hostname }}-{{ .vlan.id }}
spec:
  desiredState:
    interfaces:
      - name: bond.{{ .vlan.id }}
        type: vlan
        state: up
        vlan:
          base-iface: bond0
          id: {{ .vlan.id }}
        ipv4:
          enabled: true
          dhcp: false
          address:
            - ip: {{ index .vlan.ips .index }}
              prefix-length: {{ .prefixLength }}
  nodeSelector:
    kubernetes.io/hostname: {{ .hostname }}
{{- end }}
