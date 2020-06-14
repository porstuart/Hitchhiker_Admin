<?php
error_reporting(0);
include_once("dbconnect.php");

$sql = "SELECT * FROM passenger WHERE status = 'Approved' AND blacklist = 'whitelisted'";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $response["passenger"] = array();
    while ($row = $result ->fetch_assoc()){
        $passenger = array();
        $passenger[email] = $row["email"];
        $passenger[fName] = $row["fName"];
        $passenger[lName] = $row["lName"];
        $passenger[gender] = $row["gender"];
        $passenger[matric] = $row["matric"];
        $passenger[phoneNum] = $row["phoneNum"];
        $passenger[emergeNum] = $row["emergeNum"];
        $passenger[residentialHall] = $row["residentialHall"];
        $passenger[status] = $row["status"];
        $passenger[passengerImage] = $row["passengerImage"];
        array_push($response["passenger"], $passenger);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>