eval $(minikube docker-env)
kubectl delete -f ../yaml/grafana-deployment.yaml > /dev/null
docker stop ft_grafana
docker build -t "ft_grafana" .
kubectl apply -f ../yaml/grafana-deployment.yaml
echo "para ver pods: kubectl get pod"
echo "para entrar en el pod: kubectl exec -it <podname> ./bin/sh"
