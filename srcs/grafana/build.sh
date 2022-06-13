docker build -t "ft_grafana" .
echo "para ver pods: kubectl get pod"
kubectl get pod
echo "para entrar en el pod: kubectl exec -it <podname> ./bin/sh"