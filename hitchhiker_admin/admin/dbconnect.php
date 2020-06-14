<?php
$servername = "localhost";
$username 	= "pickupan_hitchhikeradmin";
$password 	= "porstuart1997";
$dbname 	= "pickupan_hitchhiker";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>