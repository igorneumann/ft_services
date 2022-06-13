eval $(minikube docker-env)
kubectl delete -f ../yaml/phpmyadmin-deployment.yaml > /dev/null
docker stop ft_phpmyadmin
docker build -t "ft_phpmyadmin" .
kubectl apply -f ../yaml/phpmyadmin-deployment.yaml
echo "para ver pods: kubectl get pod"
echo "para entrar en el pod: kubectl exec -it <podname> ./bin/sh"
