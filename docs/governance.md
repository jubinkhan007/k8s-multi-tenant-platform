# Platform Governance & Compliance

Our platform uses **OPA Gatekeeper** to automate policy enforcement and ensure all tenants adhere to security and operational standards.

## 🔷 Policy Enforcement (OPA Gatekeeper)

We enforce the following policies at admission time:

1. **Mandatory Labeling**: All Namespaces MUST have a `tenant` label for billing and ownership tracking.
2. **Container Security**: 
    - No privileged containers allowed (except in system namespaces).
    - HostPath volumes are prohibited.
    - Containers must run as non-root users.
3. **Resource Efficiency**:
    - All Pods MUST define resource requests and limits.
    - Limits cannot exceed defined maximums per container.
4. **Image Governance**:
    - Images must be pulled from approved enterprise registries.
    - Use of the `latest` tag is blocked in production.

## 🔷 Compliance Monitoring

Violations are logged and can be viewed via Gatekeeper audit logs. Repeat violations trigger alerts to the platform team.
