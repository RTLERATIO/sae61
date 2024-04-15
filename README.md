SAE 61 :

- Mise en place d’un firewall.
- Mettre en évidence son efficacité avec des démonstrations de son fonctionnement.
- Aborder la sécurisation du serveur web Apache.

Les concepts suivants doivent être assimilés :

- HTTP/HTTPS, SSL/TLS, TCP/IP, ...
- Utilisation des ports IP
- Outils de test de pénétration

2 VM Debian Vagrant :

1 serveur : serveur web apache (qui servira une simple page statique) et le firewall ;

1 pour les tests, à la fois pour vérifier que l’accès aux pages web est possible, mais aussi pour vérifier que des attaques classiques sont contrées.

On va simuler des attaques avec et sans firewall pour voir les différences de protection.

docs pour le firewall : <https://doc.ubuntu-fr.org/ufw>

Traces des étapes :

- Lecture du sujet
- Compréhension du sujet
- Recherche sur les outils de pentesting (nmap)
- Mise en place de 2 VM Vagrant Debian 11
- Un message d'erreur empêchait le lancement des VM (via “vagrant up”). Pour cela il a fallu activer la virtualisation imbriquée dans VirtualBox
- Un second problème rencontré est le fait que la commande “vagrant ssh serveur” n’a rien lancée. Nous nous sommes finalement rendu compte qu’il fallait activer le ssh sur le firewall pour pouvoir s’y connecter.
- La seconde VM est accessible via vagrant ssh.
- Il faut maintenant que nous faisions des tests de vulnérabilité du serveur. De plus, en se connectant à l’ip du serveur nous accédons à la page web apache.
- Installation de nmap sur la VM 2.
- Sur plusieurs console : ”sudo hping3 -p 80 -S 192.168.10.3 --fast -d 1000 --rand-source”

Voici une explication du contenu des fichiers Vagrantfile que j'ai fournis :

1. **Vagrantfile pour le serveur (VM Debian avec nginx et firewall)** :
    - Vagrant.configure("2") do |config| : Cette ligne spécifie la version de la configuration de Vagrant utilisée, qui est "2" dans ce cas.
    - config.vm.define "serveur" do |serveur| : Cette ligne commence la configuration de la machine virtuelle nommée "serveur".
    - serveur.vm.box = "debian/buster64" : Cela spécifie l'image de la machine virtuelle à utiliser. Dans ce cas, nous utilisons une image Debian Buster 64 bits.
    - serveur.vm.hostname = "serveur" : Cela définit le nom d'hôte de la machine virtuelle.
    - serveur.vm.network "private_network", ip: "192.168.0.10" : Cette ligne configure une interface réseau privée pour la machine virtuelle avec une adresse IP statique de 192.168.0.10.
    - serveur.vm.provision "shell", inline: <<-SHELL ... : Cette section définit les instructions de provisionnement. Dans ce cas, nous utilisons un script shell en ligne pour installer nginx, configurer une page statique, installer et configurer un pare-feu (ufw) pour autoriser le trafic HTTP.
2. **Vagrantfile pour la machine de test** :
    - Vagrant.configure("2") do |config| : Comme précédemment, cette ligne spécifie la version de la configuration de Vagrant utilisée.
    - config.vm.define "test" do |test| : Cette ligne commence la configuration de la machine virtuelle nommée "test".
    - test.vm.box = "debian/buster64" : Comme pour le serveur, nous utilisons également une image Debian Buster 64 bits pour la machine de test.
    - test.vm.hostname = "test" : Cela définit le nom d'hôte de la machine virtuelle de test.
    - test.vm.network "private_network", ip: "192.168.0.11" : Cette ligne configure une interface réseau privée avec une adresse IP statique de 192.168.0.11 pour la machine de test.
    - test.vm.provision "shell", inline: <<-SHELL ... : Cette section peut être utilisée pour ajouter des instructions de provisionnement supplémentaires, telles que des tests pour vérifier l'accès aux pages web et pour tester des attaques classiques. Dans l'exemple fourni, cette section est laissée vide pour que vous puissiez ajouter vos propres tests selon vos besoins.
