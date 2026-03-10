#!/bin/bash

# Simple script to scaffold a new tenant in the multi-tenant platform.
# Usage: ./onboard-tenant.sh <team-name> <cpu-quota> <memory-quota>

TEAM_NAME=$1
CPU_QUOTA=$2
MEM_QUOTA=$3

if [ -z "$TEAM_NAME" ] || [ -z "$CPU_QUOTA" ] || [ -z "$MEM_QUOTA" ]; then
    echo "Usage: $0 <team-name> <cpu-quota> <memory-quota>"
    exit 1
fi

echo "Creating manifests for tenant: $TEAM_NAME"

# 1. Create Namespace
cat <<EOF > bootstrap/namespaces/${TEAM_NAME}.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: ${TEAM_NAME}
  labels:
    tenant: ${TEAM_NAME}
    platform: k8s-multi-tenant
EOF

# 2. Create ResourceQuota
cat <<EOF > bootstrap/quotas/${TEAM_NAME}-quota.yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: ${TEAM_NAME}-quota
  namespace: ${TEAM_NAME}
spec:
  hard:
    requests.cpu: "${CPU_QUOTA}"
    requests.memory: "${MEM_QUOTA}"
EOF

# 3. Create NetworkPolicy (Default Deny)
cat <<EOF > networking/network-policies/${TEAM_NAME}-deny.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
  namespace: ${TEAM_NAME}
spec:
  podSelector: {}
  policyTypes: ["Ingress", "Egress"]
EOF

echo "Manifests created in bootstrap/ and networking/ domains."
echo "Please review and commit to trigger GitOps deployment."
