eval $(minikube docker-env)
kubectl delete -f ../yaml/influxdb-deployment.yaml
docker stop ft_influxdb
docker build -t "ft_influxdb" .
kubectl apply -f ../yaml/influxdb-deployment.yaml
echo "para ver pods: kubectl get pod"
echo "para entrar en el pod: kubectl exec -it <podname> ./bin/sh"
