# 🏗️ k8s-multi-tenant-platform

[![Kubernetes](https://img.shields.io/badge/kubernetes-v1.30+-blue.svg)](https://kubernetes.io)
[![Istio](https://img.shields.io/badge/istio-v1.22+-blue.svg)](https://istio.io)
[![Argo Rollouts](https://img.shields.io/badge/argo--rollouts-v1.7+-orange.svg)](https://argoproj.github.io/argo-rollouts/)
[![OPA Gatekeeper](https://img.shields.io/badge/opa--gatekeeper-v3.16+-green.svg)](https://open-policy-agent.github.io/gatekeeper/website/)

An enterprise-grade, production-ready Multi-Tenant Kubernetes Platform architecture. This project implements advanced Platform Engineering concepts including strict logical isolation, zero-trust networking, progressive delivery, and automated governance.

## 🔷 Project Overview

This platform is designed for organizations building an Internal Developer Platform (IDP) or PaaS where multiple engineering teams share a single cluster safely and efficiently. It follows the **Soft Multi-tenancy** model with hardened security boundaries.

## 🔷 Key Pillars

### 1. Multi-Team Isolation (Phase 1-3)
- **Namespace Segmentation**: Each tenant is encapsulated within a dedicated namespace.
- **Hierarchical RBAC**: Least-privileged roles preventing cross-namespace access or cluster-level interference.
- **Resource Governance**: Strict `ResourceQuotas` and `LimitRanges` to eliminate the 'noisy neighbor' problem and control costs.

### 2. Zero-Trust Networking (Phase 4-5)
- **Default Deny Posture**: All ingress and egress traffic is blocked by default using Kubernetes `NetworkPolicies`.
- **Identity-Aware Ingress**: Centralized Istio Ingress Gateway with host-based routing per tenant (`team-a.company.com`).
- **Encrypted Communication**: Mandatory mTLS across the cluster via Istio `PeerAuthentication`.

### 3. Progressive Delivery & Reliability (Phase 6-8)
- **Canary Deployments**: Automated traffic shifting using **Argo Rollouts** integrated with the Istio Service Mesh.
- **Automated Analysis**: `AnalysisTemplates` query Prometheus to validate success rates before promoting versions.
- **Zero-Downtime Strategy**: Enforced `PodDisruptionBudgets` (PDBs), standardized health probes, and graceful termination hooks.

### 4. Governance & Policy-as-Code (Phase 10)
- **OPA Gatekeeper**: Automated admission control enforcing:
    - Mandatory resource limits and requests.
    - Blocking privileged containers and hostPath volumes.
    - Enforcing enterprise labeling standards for billing/ownership.

## 🔷 Repository Structure

```text
k8s-multi-tenant-platform/
├── bootstrap/          # Core K8s resources
│   ├── namespaces/     # Tenant namespace definitions
│   ├── rbac/           # Team-specific roles and bindings
│   ├── quotas/         # Resource limits per tenant
│   └── reliability/    # PodDisruptionBudgets
├── networking/         # Connectivity layer
│   ├── network-policies/ # Zero-trust firewall rules
│   └── ingress/        # Shared Gateway & Gateway API configs
├── mesh/               # Istio Service Mesh
│   ├── istio/          # Global mesh settings (mTLS)
│   ├── virtual-services/ # Tenant-specific routing
│   └── destination-rules/# Traffic policies & load balancing
├── canary/             # Progressive Delivery
│   └── argo-rollouts/  # Rollouts & AnalysisTemplates
├── policies/           # Multi-tenant Governance
│   └── opa/            # Gatekeeper constraints & templates
├── observability/      # Monitoring & Logging
│   └── prometheus-monitors/# ServiceMonitors for tenant discovery
├── docs/               # Detailed Architecture Docs
└── diagrams/           # Visual representations
```

## 🔷 Tenant Onboarding

Automated provisioning is key to Platform Engineering. We provide a [scaffolding script](bootstrap/onboard-tenant.sh) to generate tenant manifests:

```bash
./bootstrap/onboard-tenant.sh "new-team" "4" "8Gi"
```

## 🔷 Documentation Index

- [Tenancy Model](docs/tenancy-model.md) — Structural overview.
- [Network Isolation](docs/network-isolation.md) — Security and traffic flow.
- [Security Model](docs/security-model.md) — Comprehensive security posture.
- [Deployment Strategy](docs/deployment-strategy.md) — Canary and Rollout details.
- [Governance](docs/governance.md) — OPA policy enforcement.
- [Onboarding Guide](docs/onboarding.md) — Step-by-step tenant creation.

## 🔷 Contribution

This project is maintained by the Platform Engineering team. To request a new cluster feature or tenant onboarding, please open a PR following the [Onboarding Guide](docs/onboarding.md).
