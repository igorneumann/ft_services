eval $(minikube docker-env)
kubectl delete -f ../yaml/ftps-deployment.yaml > /dev/null
docker stop ft_ftps
docker build -t "ft_ftps" .
kubectl apply -f ../yaml/ftps-deployment.yaml
echo "para ver pods: kubectl get pod"
kubectl get pod
echo "para entrar en el pod: kubectl exec -it <podname> ./bin/sh"