##
# Fonction de création d'un compte de service
#
function create_service_account {
	echo "Ajout d'un compte de service pour $1"
	useradd --no-create-home --shell /bin/false $1
}

##
# Fonction chargée de la récupération, décompression et installation
# de l'exécutable permettant de récupérer les métriques souhaitées. 
#
function prepare_service {

	service=$1	
	version=$2
	tmpdir="/tmp/prometheus_exporters"
	installdir="/usr/local/bin"
	archname="$service-$version.linux-amd64"

	if [ ! -d "$tmpdir" ]; then
		echo "Le dossier $tmpdir n'existe pas, création de $tmpdir ..."
		mkdir $tmpdir
	fi

	echo "Téléchargement de $service..."
	wget "https://github.com/prometheus/$service/releases/download/v$version/$archname.tar.gz" -q -P $tmpdir

	echo "Décompression de l'archive..."
	tar -xvzf $tmpdir/$archname.tar.gz -C $tmpdir/

	echo "Copie du fichier exécutable..."
	cp $tmpdir/$archname/$service $installdir

	echo "Suppression du dossier temporaire..."
	rm -rf $tmpdir

	echo "Changement du propriétaire du fichier..."
	chown $service:$service $installdir/$service
}

##
# Fonction chargée de mettre en place la configuration du service ainsi que
# l'activation et le démarrage de celui-ci.
#
function create_service {

	service=$1
	servicedir="/lib/systemd/system"

	echo "Création du service pour $service"
	echo "Copie de la configuration..."
	cp ./config/services/$service.service $servicedir

	echo "Activation du service..."
	systemctl daemon-reload
	systemctl enable $service.service
	
	echo "Demarrage du service..."
	systemctl start $service
}