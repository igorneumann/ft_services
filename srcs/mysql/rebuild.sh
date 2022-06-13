eval $(minikube docker-env)
kubectl delete -f ../yaml/mysql-deployment.yaml > /dev/null
docker stop ft_mysql
docker build -t "ft_mysql" .
kubectl apply -f ../yaml/mysql-deployment.yaml
echo "para ver pods: kubectl get pod"
echo "para entrar en el pod: kubectl exec -it <podname> ./bin/sh"
