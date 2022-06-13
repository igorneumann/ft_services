# ft_services
System Administration and Networking project with web services using Kubernettes

You will have to set up:
• An nginx server listening on ports 80 and 443. Port 80 will be in http and should be a systematic redirection of type 301 to 443, which will be in https. The page displayed does not matter.
• A FTPS server listening on port 21.
• A WordPress website listening on port 5050, which will work with a MySQL database. Both services have to run in separate containers. The WordPress website will have several users and an administrator.
• phpMyAdmin, listening on port 5000 and linked with the MySQL database.
• A Grafana platform, listening on port 3000, linked with an InfluxDB database. Grafana will be monitoring all your containers. You must create one dashboard per service. InfluxDB and grafana will be in two distincts containers.
• The Kubernetes web dashboard. This will help you manage your cluster.
• The Load Balancer which manages the external access of your services. It will be the only entry point to your cluster. You must keep the ports associated with the service (IP:3000 for Grafana etc).
• In case of a crash or stop of one of the two database containers, you will have to make shure the data persist.

Technologies used:

- Nginx
- MySQL (including database management with phpmyadmin)
- PHP
- FTP
- SSL
- Wordpress
- Grafana
