#
# Builds and deploys all microservices to a local Kubernetes instance.
#
# Usage:
#
#   ./scripts/local-kub/deploy.sh
#
if ! command -v docker >/dev/null; then
  >&2 echo "Docker Desktop is either not running or not integrated with WSL"
  exit 1
fi
if ! command -v kubectl >/dev/null; then
  >&2 echo "Kubernetes is not available"
  exit 1
fi
if kubectl config get-contexts | grep 'docker-desktop'; then
  # Don't forget to change kubectl to your local Kubernetes instance, like this:
  kubectl config use-context docker-desktop
else
  echo "Kubernetes is not enabled in Docker Desktop" >&2
  exit 1
fi
#
# Build Docker images.
#
docker build -t metadata:1 --file ../../metadata/Dockerfile-prod ../../metadata
docker build -t history:1 --file ../../history/Dockerfile-prod ../../history
docker build -t mock-storage:1 --file ../../mock-storage/Dockerfile-prod ../../mock-storage
docker build -t video-streaming:1 --file ../../video-streaming/Dockerfile-prod ../../video-streaming
docker build -t video-upload:1 --file ../../video-upload/Dockerfile-prod ../../video-upload
docker build -t gateway:1 --file ../../gateway/Dockerfile-prod ../../gateway

#
# Deploy containers to Kubernetes.
#
kubectl apply -f rabbit.yaml
kubectl apply -f mongodb.yaml
kubectl apply -f metadata.yaml
kubectl apply -f history.yaml
kubectl apply -f mock-storage.yaml
kubectl apply -f video-streaming.yaml
kubectl apply -f video-upload.yaml
kubectl apply -f gateway.yaml

echo
echo "KUBERNETES PODS:"
echo
kubectl get pods
echo
echo "KUBERNETES DEPLOYMENTS:"
echo
kubectl get deploy
echo
echo "KUBERNETES SERVICES:"
echo
kubectl get services
