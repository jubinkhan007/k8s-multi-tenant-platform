# Tenant Onboarding Process

Welcome to the Multi-Tenant Kubernetes Platform. This document outlines the process for onboarding a new team/tenant.

## 🔷 Onboarding Steps

1. **Namespace Request**: Submit a request defining the team name and environment.
2. **Infrastructure Provisioning**:
    - Creation of a dedicated namespace: `bootstrap/namespaces/<team-name>.yaml`
    - Application of RBAC policies: `bootstrap/rbac/<team-name>-rbac.yaml`
    - Setting Resource Quotas: `bootstrap/quotas/<team-name>-quota.yaml`
3. **Connectivity Setup**:
    - Network policies are applied by default (Deny All).
    - Ingress routes defined in `networking/ingress/<team-name>-ingress.yaml`.
4. **Access Control**:
    - Developers are granted access via predefined Roles.
    - No `cluster-admin` access is provided to tenants.

## 🔷 Tenancy Model

We utilize **Namespace-based isolation**. Each tenant is restricted to their own namespace and cannot view or interact with resources in other namespaces.
