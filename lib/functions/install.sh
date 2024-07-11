##
# Fonction d'installation de service générique
#
function install_service {

	service=$1
	version=$2

	create_service_account $service
	prepare_service $service $version
	create_service $service
}

##
# Fonction d'installation de node_exporter
#
function install_node_exporter {
	
	version=$1

	install_service node_exporter $version
}

##
# Fonction d'installation de mysqld_exporter
#
function install_mysqld_exporter {

	version=$1

	# Création du fichier de config (user : pass) dans /etc/mysqld-exporter/.my.cnf
	# Création de l'utilisateur "mysqld-exporter" sur le serveur MySQL

	install_service mysqld_exporter $version
}

##
# Fonction d'installation d'apache_exporter
#
function install_apache_exporter {

	version=$1	

	install_service apache_exporter $version
}