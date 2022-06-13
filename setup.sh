# Reset
NC='\033[0m'       # Text Reset

# Regular Colors
black='\033[0;30m'        # Black
red='\033[0;31m'          # Red
green='\033[0;32m'        # Green
yellow='\033[0;33m'       # yellow
blue='\033[0;34m'         # Blue
purple='\033[0;35m'       # Purple
cyan='\033[0;36m'         # Cyan
white='\033[0;37m'        # White

source $HOME/.zshrc

if [[ $1 == "help" ]] || [[ $2 != "" ]] || ([[ $1 != "nuke" ]] && [[ $1 != "influxdb" ]] && [[ $1 != "grafana" ]] && [[ $1 != "nginx" ]] && [[ $1 != "mysql" ]] && [[ $1 != "wordpress" ]] && [[ $1 != "phpmyadmin" ]] && [[ $1 != "ftps" ]] && [[ $1 != "telegraf" ]] && [[ $1 != "" ]])
	then
	echo "\n\n${purple}Ok  Titio ayuda...\n"
	echo "${cyan}setup.sh${NC} para configurar, instalar o reinstalar"
	echo "${cyan}setup.sh help${NC} para ayuda ${yellow}(esa ventana)"
	echo "${cyan}setup.sh nuke${NC} para ${yellow}borrar TODO${NC} y reiniciar la instalacion desde el 0"
	echo "\n"
	echo "Para recargar ${yellow}UN${NC} contenedor ${yellow}(sin borrar volumenes)${NC} contestar ${cyan}\"Y\"${NC} cuando pregunte o usar:\n"
	echo "${cyan}setup.sh influxdb${NC} para recargar ${yellow}InfluxDB"
	echo "${cyan}setup.sh grafana${NC} para recargar ${yellow}Grafana"
	echo "${cyan}setup.sh nginx${NC} para recargar ${yellow}NGINX"
	echo "${cyan}setup.sh mysql${NC} para recargar ${yellow}MySQL"
	echo "${cyan}setup.sh wordpress${NC} para recargar ${yellow}Wordpress"
	echo "${cyan}setup.sh phpmyadmin${NC} para recargar ${yellow}PHPMyAdmin"
	echo "${cyan}setup.sh ftps${NC} para recargar ${yellow}FTPS"
	echo "${cyan}setup.sh telegraf${NC} para recargar ${yellow}telegraf\n"
	echo "${yellow}Solamente esta permitido un argumento!\n"
	exit 0
fi

if [[ $srcs == "" ]];
then
	#get current path
	CPATH=$PWD
	srcs=$PWD/srcs
fi

#INSTALL IF NECESARY
if [ ! -d "/Applications/Docker.app" ] && [ ! -d "~/Applications/Docker.app" ]; then
	./install.sh
fi
which -s virtualbox
if [[ $? != 0 ]]; then
	./install.sh
fi
which -s docker-machine
if [[ $? != 0 ]] ; then
	./install.sh
fi

#Prune Docker
if [[ $1 == "nuke" ]]
	then
	echo "${red}Nuke${NC} all this Shit? [${cyan}Y${NC}/${blue}n]"
	read -t 4 -p  input
	echo ""
	if [ -n "$input" ] && [ "$input" != "n" ];
		then
		cd $srcs/yaml/
		kubectl delete -f influxdb-deployment.yaml
		kubectl delete -f grafana-deployment.yaml
		enable -n echo
		echo ""
		echo -n "."
		kubectl delete -f nginx-deployment.yaml
		kubectl delete -f mysql-deployment.yaml
		echo -n "."
		kubectl delete -f mysql-deployment.yaml
		kubectl delete -f wordpress-deployment.yaml
		echo -n "."
		kubectl delete -f phpmyadmin-deployment.yaml
		kubectl delete -f ftps-deployment.yaml
		echo -n "."
		kubectl delete -f telegraf-deployment.yaml
		kubectl delete -f volumes.yaml
		echo -n "."
		kubectl delete -f metallb.yaml
		kubectl delete -f loadbalance.yaml
		echo -n "."
		eval $(minikube docker-env)
		docker stop $(docker ps -a -q)
		minikube stop
		echo -n "."
		yes | docker system prune -a
		echo -n "."
		sleep 0.1
		echo -n "."
		sleep 0.1
		echo -n "."
		sleep 0.1
		echo "*"
		sleep 0.1
		echo ""
		echo "BOOM, your shit is gone now!"
		echo ""
	fi
fi

#detect 1st run
FIRSTRUN=$(kubectl get secrets)

#start minikube if no images available
if [[ $FIRSTRUN == "" ]];
then
	minikube start --vm-driver virtualbox --extra-config=apiserver.service-node-port-range=1-35000
	kubectl proxy &
	cd $srcs/yaml/ && \ 
	kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.9.3/manifests/namespace.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
	minikube addons enable metrics-server && \
	minikube addons enable dashboard
fi

cd $srcs/yaml/ 
kubectl apply -f volumes.yaml 
kubectl apply -f metallb.yaml
kubectl apply -f loadbalance.yaml

#Cambiar entorno
eval $(minikube docker-env)

#set variables (not used)
SSH_USERNAME=admin
SSH_PASSWORD=admin
FTPS_USERNAME=admin
FTPS_PASSWORD=admin
DB_USER=newuser
DB_PASSWORD=password

if [[ $MINIKUBE_IP == "" ]];
then
	#Get IP
	minikube ip > /tmp/.minikube.ip
	MINIKUBE_IP=`cat /tmp/.minikube.ip`;
fi

#Check if images exist
eval $(minikube docker-env)
NGINX_IMAGE=$(docker images -q ft_nginx)
MYSQL_IMAGE=$(docker images -q ft_mysql)
WORDPRESS_IMAGE=$(docker images -q ft_wordpress)
PHPMYADMIN_IMAGE=$(docker images -q ft_phpmyadmin)
FTPS_IMAGE=$(docker images -q ft_ftps)
INFLUXDB_IMAGE=$(docker images -q ft_influxdb)
GRAFANA_IMAGE=$(docker images -q ft_grafana)
TELEGRAF_IMAGE=$(docker images -q ft_telegraf)

#Build containers

if [[ $INFLUXDB_IMAGE == "" ]];
	then
		cd $srcs/influxdb/ && ./build.sh
	else
		echo "\n\nReload ${yellow}InfluxDB${NC}? [${blue}y${NC}/${cyan}N${NC}]"
		read -t 3 -n1 -p "" input
		if [[ $1 == "influxdb" ]] || [[ $1 == "nuke" ]] || ([ -n "$input" ] && [ "$input" == "y" ]);
			then
			kubectl delete -f influxdb-deployment.yaml
			docker image rm -f ft_influxdb
			cd $srcs/influxdb/ && ./build.sh
		fi
fi
cd $srcs/yaml/ && kubectl apply -f influxdb-deployment.yaml

if [[ $GRAFANA_IMAGE == "" ]];
	then
		cd $srcs/grafana/ && ./build.sh
	else
		echo "\n\nReload ${yellow}Grafana${NC}? [${blue}y${NC}/${cyan}N${NC}]"
		read -t 3 -n1 -p "" input
		if [[ $1 == "grafana" ]] || [[ $1 == "nuke" ]] || ([ -n "$input" ] && [ "$input" != "n" ]);
			then
			cd $srcs/grafana/ && ./rebuild.sh
		fi
fi
cd $srcs/yaml/ && kubectl apply -f grafana-deployment.yaml

if [[ $NGINX_IMAGE == "" ]];
	then
		cd $srcs/nginx/ && ./build.sh
	else
		echo "\n\nReload ${yellow}NGINX${NC}? [${blue}y${NC}/${cyan}N${NC}]"
		read -t 3 -n1 -p "" input
		if [[ $1 == "nginx" ]] || [[ $1 == "nuke" ]] || ([ -n "$input" ] && [ "$input" == "y" ]);
			then
			cd $srcs/nginx/ && ./rebuild.sh
		fi
fi
cd $srcs/yaml/ && kubectl apply -f nginx-deployment.yaml

if [[ $MYSQL_IMAGE == "" ]];
	then
		cd $srcs/mysql/ && ./build.sh
	else
		echo "\n\nReload ${yellow}MySQL${NC}? [${blue}y${NC}/${cyan}N${NC}]"
		read -t 3 -n1 -p "" input
		if [[ $1 == "mysql" ]] || [[ $1 == "nuke" ]] || ([ -n "$input" ] && [ "$input" == "y" ]);
			then
			cd $srcs/mysql/ && ./rebuild.sh
		fi
fi
cd $srcs/yaml/ && kubectl apply -f mysql-deployment.yaml

if [[ $WORDPRESS_IMAGE == "" ]];
	then
		cd $srcs/wordpress/ && ./build.sh
	else
		echo "\n\nReload ${yellow}Wordpress${NC}? [${blue}y${NC}/${cyan}N${NC}]"
		read -t 3 -n1 -p "" input
		if [[ $1 == "wordpress" ]] || [[ $1 == "nuke" ]] || ([ -n "$input" ] && [ "$input" == "y" ]);
			then
			cd $srcs/wordpress/ && ./rebuild.sh
		fi
fi
cd $srcs/yaml/ && kubectl apply -f wordpress-deployment.yaml

if [[ $PHPMYADMIN_IMAGE == "" ]];
	then
		cd $srcs/phpmyadmin/ && ./build.sh
	else
		echo "\n\nReload ${yellow}PHPMyadmin${NC}? [${blue}y${NC}/${cyan}N${NC}]"
		read -t 3 -n1 -p "" input
		if [[ $1 == "phpmyadmin" ]] || [[ $1 == "nuke" ]] || ([ -n "$input" ] && [ "$input" == "y" ]);
			then
			cd $srcs/phpmyadmin/ && ./rebuild.sh
		fi
fi
cd $srcs/yaml/ && kubectl apply -f phpmyadmin-deployment.yaml

if [[ $FTPS_IMAGE == "" ]];
	then
		cd $srcs/ftps/ && ./build.sh
	else
		echo "\n\nReload ${yellow}FTPS${NC}? [${blue}y${NC}/${cyan}N${NC}]"
		read -t 3 -n1 -p "" input
		if [[ $1 == "ftps" ]] || [[ $1 == "nuke" ]] || ([ -n "$input" ] && [ "$input" == "y" ]);
			then
			cd $srcs/ftps/ && ./rebuild.sh
		fi
fi
cd $srcs/yaml/ && kubectl apply -f ftps-deployment.yaml

if [[ $FTPS_IMAGE == "" ]];
	then
		cd $srcs/telegraf/ && ./build.sh
	else
		echo "\n\nReload ${yellow}Telegraf${NC}? [${blue}y${NC}/${cyan}N${NC}]"
		read -t 3 -n1 -p "" input
		if [[ $1 == "telegraf" ]] || [[ $1 == "nuke" ]] || ([ -n "$input" ] && [ "$input" == "y" ]);
			then
			cd $srcs/telegraf/ && ./rebuild.sh
		fi
fi
cd $srcs/yaml/ && kubectl apply -f telegraf-deployment.yaml
echo "\n\n${cyan}Abrir la pagina de bienvenida de los servicios?${NC} (NGINX) [${cyan}Y${NC}/${blue}n${NC}]"
read -t 3 -n1 -p "" input
		if [ -n "$input" ] && [ "$input" == "n" ];
			then
			echo "\n\nPuedes abrir con el comando: ${yellow}open https://192.168.99.240${NC}'"
			else
			open https://192.168.99.240
		fi
echo "\n\nEjecutar '${yellow}minikube dashboard${NC}' para abrir el panel de Minikube? [${blue}y/${cyan}N${NC}]"
read -t 30 -n1 -p "" input
		if [ -n "$input" ] && [ "$input" == "y" ];
			then
			echo "\n\nEsperando ${yellow}1 minuto${NC} para dar tiempo a ese MacCaca cargar todo"
			sleep 10
			echo "\nCafe? Cigarrito? Addelante que es el momento, faltan ${yellow}50 segundos${NC}"
			sleep 10
			echo "\nA que es lento? aun faltan ${yellow}40 segudos${NC}"
			sleep 10
			echo "\nOle, ya llegamos a la mitad! ${yellow}30 segundos${NC}!"
			sleep 10
			echo "\nYa nos queda poco juntos, mande recuerdos a la familia, ${yellow}20 segundos${NC}."
			sleep 10
			echo "\nEn ${yellow}10 segundos${NC} me cambiaras por el panel de Minikube!"
			sleep 10
			echo "\n${red}Adios mundo cruel...${NC}"
			minikube dashboard &
			else
			echo "Puedes abrir el dashboard con el comando: ${yellow}minikube dashboard${NC} &"
		fi
echo "\n\nLa ${yellow}IP${NC} de minikube es ${yellow}$MINIKUBE_IP${NC}"
echo "\n\nPods en ejecución:"
kubectl get pod
echo "\n\nPara entrar en el pod: ${yellow}kubectl exec -it <podname> ./bin/sh${NC}"