<h1>Привет, админ</h1>
<h4>Пробуем php и mysql...</h4>
<?php
$host = 'mysql';
$user = 'root';
$pass = 'Pizza2018';
$conn = new mysqli($host, $user, $pass);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
echo "OK!";

