docker stop ft_phpmyadmin
docker build -t "ft_phpmyadmin" .
echo "para ver pods: kubectl get pod"
kubectl get pod
echo "para entrar en el pod: kubectl exec -it <podname> ./bin/sh"