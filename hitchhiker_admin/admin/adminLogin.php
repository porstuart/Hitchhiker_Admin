<?php
error_reporting(0);
include_once("dbconnect.php");
$username = $_POST['username'];
$password = $_POST['password'];
$passwordsha = sha1($password);

$sql = "SELECT * FROM admin WHERE username = '$username' AND password = '$passwordsha'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        echo "success,".$row["username"];
    }
}else{
    echo "failed,null";
}