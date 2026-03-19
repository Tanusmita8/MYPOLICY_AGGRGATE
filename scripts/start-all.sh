#!/bin/bash
CLUSTER="mypolicy-prod"
echo "Starting all services in correct order..."

echo "Step 1: Starting infrastructure services..."
for SERVICE in config-service discovery-service; do
  echo "Starting $SERVICE..."
  aws ecs update-service --cluster $CLUSTER --service $SERVICE --desired-count 1
  echo "Waiting 30 seconds..."
  sleep 30
done

echo "Step 2: Starting business services..."
for SERVICE in customer-service policy-service data-pipeline-service bff-service frontend insurer-dashboard; do
  echo "Starting $SERVICE..."
  aws ecs update-service --cluster $CLUSTER --service $SERVICE --desired-count 1
done

echo "✅ All 8 services started!"
echo "Check AWS ECS console for status"