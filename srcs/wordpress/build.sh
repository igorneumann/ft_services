docker build -t "ft_wordpress" .
echo "para ver pods: kubectl get pod"
echo "para entrar en el pod: kubectl exec -it <podname> ./bin/sh"