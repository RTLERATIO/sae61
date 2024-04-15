<?php
// Récupérer le nom d'utilisateur à partir de la requête GET
$username = $_GET['username'];
$motdepasse = $_GET['motdepasse'];
$conn = mysqli_connect("localhost", "robot", "toto", "test_database");

// Vérifier la connexion
if (!$conn) {
    die("La connexion à la base de données a échoué : " . mysqli_connect_error());
}


// Exécuter une requête SQL pour rechercher l'utilisateur dans la base de données
// Attention : cette requête est vulnérable aux injections SQL
$query = "SELECT * FROM test_database.users WHERE username = '$username' AND motdepasse = '$motdepasse'";

// Exécuter la requête (c'est ici que la faille se produit)
// Notez que ce code est juste un exemple et ne doit pas être utilisé en production
$result = mysqli_query($conn, $query);

// Afficher les résultats de la requête
if ($result) {
    while ($row = mysqli_fetch_assoc($result)) {
        echo "Nom d'utilisateur: " . $row['username'] . "<br>";
        echo "Email: " . $row['email'] . "<br>";
        echo "Mot de passe actuel " . $row['motdepasse'] . "<br>";
    }
}else {
    echo "Aucun utilisateur trouvé.";
}
?>

