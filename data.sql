CREATE DATABASE IF NOT EXISTS test_database;

USE test_database;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    motdepasse VARCHAR(100) NOT NULL
);

INSERT INTO users (username, email, motdepasse) VALUES
('Jean', 'Jean@gmail.com','azerty'),
('Bob', 'Bob@orange.fr','aqwzsx'),
('Alice', 'Alice@yahoo.fr','1234'),
('admin', 'admin@yahoo.fr','toto'),
('username', 'username@toto.fr','username');
