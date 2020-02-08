curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash
k3d create --server-arg --no-deploy --server-arg traefik
export KUBECONFIG=$(k3d get-kubeconfig)

# Create a namespace for Istio
kubectl create namespace istio-system

#Install helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash -
kubectl create serviceaccount tiller --namespace=kube-system
kubectl create clusterrolebinding tiller-admin --serviceaccount=kube-system:tiller --clusterrole=cluster-admin
helm init --service-account=tiller
helm repo add istio.io https://storage.googleapis.com/istio-release/releases/1.4.3/charts/
helm repo update

curl https://storage.googleapis.com/istio-release/releases/1.4.2/istio-1.4.2-linux.tar.gz -O
tar -xzf istio-*.tar.gz
sudo mv -v istio-*/bin/istioctl /usr/local/bin/

# Install CRDs
helm template istio-1.4.2/install/kubernetes/helm/istio-init --name istio-init --namespace istio-system | kubectl apply -f -

# Wait for the generation of the CRDs
kubectl -n istio-system wait --for=condition=complete job --all

helm template istio-1.4.2/install/kubernetes/helm/istio --name istio --namespace istio-system | kubectl apply -f -

kubectl get svc,pod -n istio-system

#Install Kiali
KIALI_USERNAME=$(read -p 'Kiali Username: ' uval && echo -n $uval | base64)
KIALI_PASSPHRASE=$(read -sp 'Kiali Passphrase: ' pval && echo -n $pval | base64)
NAMESPACE=istio-system
kubectl create namespace $NAMESPACE
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: kiali
  namespace: $NAMESPACE
  labels:
    app: kiali
type: Opaque
data:
  username: $KIALI_USERNAME
  passphrase: $KIALI_PASSPHRASE
EOF

istioctl manifest apply --set values.kiali.enabled=true
kubectl -n istio-system get svc kiali
istioctl dashboard kiali

# Deploy book info app
kubectl label namespace default istio-injection=enabled

cd istio-1.4.2
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
kubectl get pods -w
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
