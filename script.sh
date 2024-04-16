echo "Debut de l'installation !"
vagrant up
echo "Fin de l'instalation !"
echo "Test de curl sans Firewall :"
sleep 5
echo "Commande envoyé : vagrant ssh client -c'curl 192.168.0.10'"
vagrant ssh client -c"curl 192.168.0.10"
sleep 5
echo "Ici on a bien retour de la page HTML"
sleep 5
echo "Test de nmap sans le Firewall :"
sleep 5
echo "Commande envoyé : vagrant ssh client -c'nmap 192.168.0.10'"
sleep 5
vagrant ssh client -c"nmap 192.168.0.10"
echo "Ici on voit que le port 80 est ouvert donc le curl est fonctionnel"
sleep 5
echo "Activons désormais le Firewall et retestons les étapes"
sleep 5
echo "Commande envoyé : vagrant ssh serveur -c'sudo ufw allow ssh | sudo ufw allow http | sudo ufw enable'"
sleep 5
vagrant ssh serveur -c "sudo ufw allow ssh && sudo ufw deny http && sudo ufw --force enable"
echo "Testons le curl"
vagrant ssh client -c"curl 192.168.0.10"
sleep 5
echo "Le curl n'a pas fonctionné, testons le nmap"
echo "Commande envoyé : vagrant ssh client -c'nmap 192.168.0.10'"
sleep 5
vagrant ssh client -c"nmap 192.168.0.10 -Pn"
echo "On remarque le le port http n'est plus ouvert d'ou l'echec du curl"
