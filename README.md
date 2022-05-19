### Usage
1. Create the cluster `minikube start --cpus=6 --memory=20019 --kubernetes-version=v1.21.0`
2. Deploy GitOps toolkit `kubectl apply -f ./flux-system/gotk-components.yaml`
3. Connect source controller to repo and kick back `kubectl apply -k ./flux-system/.`