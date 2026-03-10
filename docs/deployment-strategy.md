# Deployment & Rollout Strategy

Our platform prioritizes availability and risk mitigation during software updates.

## 🔷 Progressive Delivery (Canary)

We use **Argo Rollouts** integrated with **Istio** for canary deployments.

1. **Traffic Shifting**: Traffic is incrementally shifted to the new version (e.g., 10% → 50% → 100%).
2. **Automated Analysis**: `AnalysisTemplates` query Prometheus metrics (e.g., HTTP 5xx error rates).
3. **Auto-Rollback**: If error thresholds are exceeded during the canary phase, the rollout is automatically aborted and traffic is reverted to the stable version.

## 🔷 Zero-Downtime Reliability

To ensure zero-downtime during rolling updates or node maintenance:

1. **Health Probes**: All applications MUST define `readinessProbe` and `livenessProbe`.
2. **Graceful Termination**: A `preStop` hook is used to wait for connections to drain before the pod is killed.
3. **Pod Disruption Budgets (PDB)**: Tenants must define PDBs to ensure a minimum number of pods remain available during voluntary disruptions (like node drains).
