# Platform Tenancy Model

The k8s-multi-tenant-platform operates on a **Soft Multi-tenancy** model within a single cluster, reinforced by strong logical isolation.

## 🔷 Tenant Definition
A 'Tenant' is mapped to a Kubernetes **Namespace**. This is the primary boundary for:
- Resource ownership
- Access control (RBAC)
- Network visibility
- Administrative overhead

## 🔷 Isolation Strategy

| Layer | Implementation | Benefit |
|-------|----------------|---------|
| **Compute** | ResourceQuotas & LimitRanges | Prevent 'noisy neighbors' and resource starvation. |
| **Network** | CNI NetworkPolicies | Zero-trust isolation between tenants. |
| **Identity** | RBAC + OIDC Groups | Scoped access ensuring teams only see their own resources. |
| **Traffic** | Istio Service Mesh | Encrypted mTLS communication and fine-grained routing. |
| **Governance** | OPA Gatekeeper | Policy-as-Code to prevent insecure configurations. |

## 🔷 Workload Requirements
All tenant workloads must comply with the following:
1. Must have readiness and liveness probes.
2. Must not run as root.
3. Must include labels `app` and `tenant`.
4. Must define resource requests and limits.
