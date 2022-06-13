eval $(minikube docker-env)
kubectl delete -f ../yaml/nginx-deployment.yaml > /dev/null
docker stop ft_nginx
docker build -t "ft_nginx" .
kubectl apply -f ../yaml/nginx-deployment.yaml
echo "para ver pods: kubectl get pod"
echo "para entrar en el pod: kubectl exec -it <podname> ./bin/sh"
