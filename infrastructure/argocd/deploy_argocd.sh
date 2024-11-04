#!/bin/bash

# Apply in this order
kubectl apply -f 00-namespace.yaml
kubectl apply -f 01-crds.yaml

# Wait for CRDs to register
kubectl wait --for condition=established --timeout=60s crd/applications.argoproj.io
kubectl wait --for condition=established --timeout=60s crd/applicationsets.argoproj.io
kubectl wait --for condition=established --timeout=60s crd/appprojects.argoproj.io

kubectl apply -f 02-configmaps.yaml
kubectl apply -f 03-secrets.yaml
kubectl apply -f 04-serviceaccounts.yaml
kubectl apply -f 05-roles.yaml
kubectl apply -f 06-rolebindings.yaml
kubectl apply -f 07-services.yaml
kubectl apply -f 08-deployments.yaml

# Check the deployment
kubectl get pods -n argocd
