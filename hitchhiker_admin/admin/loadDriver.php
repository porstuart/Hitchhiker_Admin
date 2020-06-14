<?php
error_reporting(0);
include_once("dbconnect.php");

$sql = "SELECT * FROM driver WHERE status = 'Approved' AND blacklist = 'whitelisted'";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $response["driver"] = array();
    while ($row = $result ->fetch_assoc()){
        $driver = array();
        $driver[email] = $row["email"];
        $driver[fName] = $row["fName"];
        $driver[lName] = $row["lName"];
        $driver[gender] = $row["gender"];
        $driver[matric] = $row["matric"];
        $driver[phoneNum] = $row["phoneNum"];
        $driver[emergeNum] = $row["emergeNum"];
        $driver[residentialHall] = $row["residentialHall"];
        $driver[status] = $row["status"];
        $driver[driverImage] = $row["driverImage"];
        $driver[tripCount] = $row["tripCount"];
        array_push($response["driver"], $driver);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>