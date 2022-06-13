docker build -t "ft_nginx" .
echo "para ver pods: kubectl get pod"
kubectl get pod
echo "para entrar en el pod: kubectl exec -it <podname> ./bin/sh"
