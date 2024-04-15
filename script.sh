echo "Debut de l'installation !"
#vagrant up
echo "Fin de l'instalation !"
echo "Test de curl sans Firewall :"
sleep 2
echo "Commande envoyé : vagrant ssh client -c'curl 192.168.0.10'"
vagrant ssh client -c"curl 192.168.0.10"
sleep 3
echo "Ici on a bien retour de la page HTML"
sleep 1
echo "Test de nmap sans le Firewall :"
sleep 1
echo "Commande envoyé : vagrant ssh client -c'nmap 192.168.0.10'"
sleep 1
vagrant ssh client -c"nmap 192.168.0.10"
echo "Ici on voit que le port 80 est ouvert donc le curl est fonctionnel"
sleep 1
echo "Activons désormais le Firewall et retestons les étapes"
sleep 1
echo "Commande envoyé : vagrant ssh serveur -c'sudo ufw allow ssh | sudo ufw allow http | sudo ufw enable'"
sleep 1
vagrant ssh serveur -c "sudo ufw allow ssh && sudo ufw deny http && sudo ufw --force enable"
echo "Testons le curl"
sleep 1
vagrant ssh client -c"curl 192.168.0.10"
echo "Le curl n'a pas fonctionné, testons le nmap"
sleep 1
echo "Commande envoyé : vagrant ssh client -c'nmap 192.168.0.10'"
sleep 1
vagrant ssh client -c"nmap 192.168.0.10"
echo "On remarque le le port http n'est plus ouvert d'ou l'echec du curl"
