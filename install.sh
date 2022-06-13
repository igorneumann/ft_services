#set variables
srcs=./srcs
dir_goinfre=/goinfre/students/$USER
docker_destination=$dir_goinfre/docker
dir_minikube=$dir_goinfre/minikube
dir_archive=$dir_goinfre/images-archives

#get current path
CPATH=$PWD

#brew
source $HOME/.zshrc
which -s brew
if [[ $? != 0 ]] ; then
	rm -rf $HOME/.brew
	rm -rf $dir_goinfre/.brew
	git clone --depth=1 https://github.com/Homebrew/brew $dir_goinfre/.brew
	export PATH=/goinfre/students/$USER/.brew/bin:$PATH
	brew update
	echo 'export PATH=/goinfre/students/$USER/.brew/bin:$PATH' >> $HOME/.zshrc
fi
brew update
which -s kubectl
if [[ $? != 0 ]] ; then
	brew install kubectl
fi
which -s minikube
if [[ $? != 0 ]] ; then
		brew install minikube
		mkdir -p $dir_minikube
fi
	#Docker
brew uninstall -f docker docker-compose docker-machine
if [ ! -d "/Applications/Docker.app" ] && [ ! -d "~/Applications/Docker.app" ]; then
	echo "${blue}Please install ${cyan}Docker for Mac ${blue}from the MSC (Managed Software Center)${reset}"
	open -a "Managed Software Center"
	read -n1 -p "${blue}Press RETURN when you have successfully installed ${cyan}Docker for Mac${blue}...${reset}"
	echo ""
fi
pkill Docker
if [ -d "$docker_destination" ]; then
	read -n1 -p "${blue}Folder ${cyan}$docker_destination${blue} already exists, do you want to reset it? [y/${cyan}N${blue}]${reset} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		rm -rf "$docker_destination"/{com.docker.{docker,helper},.docker} &>/dev/null ;:
	fi
fi

unlink ~/Library/Containers/com.docker.docker &>/dev/null ;:
unlink ~/Library/Containers/com.docker.helper &>/dev/null ;:
unlink ~/.docker &>/dev/null ;:
rm -rf ~/Library/Containers/com.docker.{docker,helper} ~/.docker &>/dev/null ;:
mkdir -p "$docker_destination"/{com.docker.{docker,helper},.docker}

which -s virtualbox
if [[ $? != 0 ]] ; then
	echo "${blue}Please install ${cyan}Virtualbox for Mac ${blue}from the MSC (Managed Software Center)${reset}"
	open -a "Managed Software Center"
	read -n1 -p "${blue}Press RETURN when you have successfully installed ${cyan}Virtualbox for Mac${blue}...${reset}"
	echo ""
fi

which -s docker-machine
if [[ $? != 0 ]] ; then
	brew install docker-machine
fi

# Make symlinks
ln -sf "$docker_destination"/com.docker.docker ~/Library/Containers/com.docker.docker
ln -sf "$docker_destination"/com.docker.helper ~/Library/Containers/com.docker.helper
ln -sf "$docker_destination"/.docker ~/.docker
ln -sf "$dir_minikube" /Users/$USER/.minikube
open -g -a Docker