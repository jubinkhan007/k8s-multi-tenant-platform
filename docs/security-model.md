# Platform Security Model

The Multi-Tenant Kubernetes Platform implements a multi-layered security approach to ensure tenant isolation and cluster integrity.

## 🔷 Network Security (Zero Trust)

We enforce a **Default Deny** posture for all tenant namespaces using Kubernetes `NetworkPolicies`.

1. **Isolation**: Cross-namespace traffic is blocked by default.
2. **Ingress Control**: Tenants only receive traffic from the authorized Ingress Gateway (e.g., `istio-ingressgateway`).
3. **Internal Traffic**: Pods within the same namespace are allowed to communicate with each other.

## 🔷 Access Control (RBAC)

- **Namespace Scope**: All tenant roles are scoped to their respective namespaces.
- **Identity Integration**: We recommend using OIDC (like Okta or GitHub) for group-based access control.
- **Sensitive Operations**: Operations like modifying NetworkPolicies or Quotas are restricted to platform administrators.

## 🔷 Resource Governance

- **Quotas**: Prevent any single tenant from consuming more than their fair share of cluster resources (CPU/Memory/Storage).
- **LimitRanges**: Ensure all pods have reasonable default resource requests and limits.

## 🔷 Policy Enforcement

- **OPA Gatekeeper**: Used to enforce governance policies such as:
    - No privileged containers.
    - Required labels on all resources.
    - Blocking `latest` image tags in production.
