<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

$sql = "UPDATE passenger SET status = 'Approved' WHERE email = '$email'";
if ($conn->query($sql) === TRUE) {
    echo "success";
}else{
    echo "error";
}
$conn->close();
?>