Vagrant.configure("2") do |config|
  # Configuration pour le client
  config.vm.define "client" do |client|
    client.vm.box = "debian/bullseye64"
    client.vm.network "private_network", ip: "192.168.0.11"
    client.vm.provision "shell", inline: <<-SHELL
      # Mise à jour des packages et installation de curl
      apt-get update
      apt-get install -y curl

      # Installation de nmap
      apt-get install -y nmap
    SHELL
  end

  # Configuration pour le serveur
  config.vm.define "serveur" do |serveur|
    serveur.vm.box = "debian/bullseye64"
    serveur.vm.network "private_network", ip: "192.168.0.10"
    serveur.vm.provision "shell", inline: <<-SHELL
      # Mise à jour des packages et installation d'Apache2
      apt update && sudo apt upgrade
      apt-get install -y apache2
      apt install -y default-mysql-server php libapache2-mod-php php-mysqli

      # Installation de UFW et autorisation du trafic HTTP
      apt-get install -y ufw

      # Copie du fichier index.html
      cp /vagrant/index.html /var/www/html/

      # Copie du fichier search.php
      cp /vagrant/search.php /var/www/html/

      # Modification du fichier php.ini pour activer l'extension mysqli
      sed -i 's/;extension=mysqli/extension=mysqli/' /etc/php/7.4/apache2/php.ini

      # Importer la base de données et les tables depuis le fichier SQL
      mysql -u root -e "CREATE DATABASE IF NOT EXISTS test_database;"
      mysql -u root test_database < /vagrant/data.sql
      
      # Création d'un nouvel utilisateur MySQL
      mysql -u root -e "CREATE USER 'robot'@'localhost' IDENTIFIED BY 'toto';"
      mysql -u root -e "GRANT ALL PRIVILEGES ON test_database.* TO 'robot'@'localhost';"
      mysql -u root -e "FLUSH PRIVILEGES;"
    SHELL

    # Définition du chemin vers les fichiers locaux à copier dans la VM
    serveur.vm.synced_folder ".", "/vagrant", type: "nfs"
  end
end
