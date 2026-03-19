#!/bin/bash
CLUSTER="mypolicy-prod"
echo "Stopping all services to save credits..."

for SERVICE in insurer-dashboard frontend bff-service customer-service policy-service data-pipeline-service discovery-service config-service; do
  echo "Stopping $SERVICE..."
  aws ecs update-service --cluster $CLUSTER --service $SERVICE --desired-count 0
done

echo "✅ All 8 services stopped!"
echo "Credits saved ✅"