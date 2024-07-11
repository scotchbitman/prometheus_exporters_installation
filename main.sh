#!/bin/bash

source ./lib/functions/system.sh
source ./lib/functions/install.sh

if [[ $EUID -ne 0 ]]; then
	echo "Ce script doit etre exécuté en tant que root."
	exit 1
fi

install_node_exporter 1.8.1