#
# Builds, publishes and deploys all microservices to a production Kubernetes instance.
#
# Usage:
#
#   ./scripts/production-kub/deploy.sh
#

set -u # or set -o nounset
: "$CONTAINER_REGISTRY"

if ! command -v docker >/dev/null; then
  >&2 echo "Docker Desktop is either not running or not integrated with WSL"
  exit 1
fi
if ! command -v kubectl >/dev/null; then
  >&2 echo "Kubernetes is not available"
  exit 1
fi
if kubectl config get-contexts | grep 'flixtube'; then
  # Don't forget to change kubectl to your local Kubernetes instance, like this:
  kubectl config use-context flixtube
else
  echo "Kubernetes is not enabled for flixtube" >&2
  exit 1
fi
#
# Build Docker images.
#
docker build -t "${CONTAINER_REGISTRY}/metadata:1" --file ../../metadata/Dockerfile-prod ../../metadata
docker push "${CONTAINER_REGISTRY}/metadata:1"

docker build -t "${CONTAINER_REGISTRY}/history:1" --file ../../history/Dockerfile-prod ../../history
docker push "${CONTAINER_REGISTRY}/history:1"

docker build -t "${CONTAINER_REGISTRY}/mock-storage:1" --file ../../mock-storage/Dockerfile-prod ../../mock-storage
docker push "${CONTAINER_REGISTRY}/mock-storage:1"

docker build -t "${CONTAINER_REGISTRY}/video-streaming:1" --file ../../video-streaming/Dockerfile-prod ../../video-streaming
docker push "${CONTAINER_REGISTRY}/video-streaming:1"

docker build -t "${CONTAINER_REGISTRY}/video-upload:1" --file ../../video-upload/Dockerfile-prod ../../video-upload
docker push "${CONTAINER_REGISTRY}/video-upload:1"

docker build -t "${CONTAINER_REGISTRY}/gateway:1" --file ../../gateway/Dockerfile-prod ../../gateway
docker push "${CONTAINER_REGISTRY}/gateway:1"

#
# Deploy containers to Kubernetes.
#
# Don't forget to change kubectl to your production Kubernetes instance
#
az aks get-credentials -g flixtube -n flixtube --overwrite-existing
kubectl apply -f rabbit.yaml
kubectl apply -f mongodb.yaml
envsubst <metadata.yaml | kubectl apply -f -
envsubst <history.yaml | kubectl apply -f -
envsubst <mock-storage.yaml | kubectl apply -f -
envsubst <video-streaming.yaml | kubectl apply -f -
envsubst <video-upload.yaml | kubectl apply -f -
envsubst <gateway.yaml | kubectl apply -f -
