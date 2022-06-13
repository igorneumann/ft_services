eval $(minikube docker-env)
kubectl delete -f ../yaml/telegraf-deployment.yaml > /dev/null
docker stop ft_telegraf
docker build -t "ft_telegraf" .
kubectl apply -f ../yaml/telegraf-deployment.yaml
echo "para ver pods: kubectl get pod"
echo "para entrar en el pod: kubectl exec -it <podname> ./bin/sh"