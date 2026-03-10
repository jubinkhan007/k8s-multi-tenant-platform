# Network Isolation & Security

This document describes the network architecture ensuring tenant isolation.

## 🔷 Zero-Trust Architecture
We implement a **deny-all-by-default** policy for both ingress and egress within every tenant namespace.

## 🔷 Traffic Flow

### North-South (External to Pod)
1. Request hits the `istio-ingressgateway` in `istio-system`.
2. Gateway routes traffic based on `VirtualService` hosts (e.g., `team-a.company.com`).
3. NetworkPolicies in the tenant namespace explicitly allow ingress FROM the `istio-system` namespace.

### East-West (Service to Service)
1. **Intra-Namespace**: Allowed via `intra-namespace` NetworkPolicy.
2. **Inter-Namespace**: BLOCKED by default. Must be explicitly allowed via matching `NetworkPolicy` and `ServiceEntry` (if external).
3. **mTLS**: Guaranteed by Istio `PeerAuthentication` (STRICT mode).

## 🔷 Implementation Details
- **Provider**: Standard K8s NetworkPolicies (Cilium recommended for advanced enforcement).
- **Scope**: Policies are generated during tenant onboarding.
