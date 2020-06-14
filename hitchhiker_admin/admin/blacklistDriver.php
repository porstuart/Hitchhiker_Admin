<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

$sql = "UPDATE driver SET blacklist = 'blacklisted' WHERE email = '$email'";
if ($conn->query($sql) === TRUE) {
    echo "success";
}else{
    echo "error";
}
$conn->close();
?>