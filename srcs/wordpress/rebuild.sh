eval $(minikube docker-env)
kubectl delete -f ../yaml/wordpress-deployment.yaml > /dev/null
docker stop ft_wordpress
docker build -t "ft_wordpress" .
kubectl apply -f ../yaml/wordpress-deployment.yaml
echo "para ver pods: kubectl get pod"
echo "para entrar en el pod: kubectl exec -it <podname> ./bin/sh"