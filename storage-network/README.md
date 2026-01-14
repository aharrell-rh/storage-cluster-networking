# storage-network Helm Chart

This Helm chart generates **NodeNetworkConfigurationPolicy (NNCP)** objects for nodes using NMState.  
It is designed to assign VLANs and static IPs to a set of hostnames.

---

## What it does

- For each hostname in `values.yaml`, it generates an NNCP per VLAN.  
- Each NNCP configures:
  - A VLAN interface (`bond.<vlan-id>`) on top of `bond0`
  - Static IPv4 addresses (from a pool defined per VLAN)
  - NodeSelector for the correct hostname
- IPs are assigned in order from the VLAN IP list (deterministic, repeatable)
- The NNCP name is formatted as: <hostname>-<vlan-id>


---

## Values

Example `values.yaml`:

```yaml
hostnames:
- node-01
- node-02

vlans:
- id: 100
  ips:
    - 192.168.100.10
    - 192.168.100.11

- id: 200
  ips:
    - 192.168.200.10
    - 192.168.200.11

prefixLength: 24
```

hostnames: list of nodes to generate NNCPs for

vlans: list of VLANs, each with an ID and IP pool

prefixLength: CIDR prefix length for the static IPs


Each NNCP configures:
- bond.<vlan-id> interface on bond0
- Static IP from the VLAN pool (assigned by index)
- NodeSelector = hostname

