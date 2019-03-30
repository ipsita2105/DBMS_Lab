<?php

//set header to json
header('Content-Type: application/json');

//database
define('DB_HOST','localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', 'password');
define('DB_NAME','project_global');

//establish connection
$mysqli = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);

if(!$mysqli){
	die("Connection Failed:".$mysqli->error);
}

//query to get data from table
$query = sprintf("select Crime_Type, count(Crime_Type) as Crime_Count
		  from Crime
		  group by (Crime_Type)");

$result = $mysqli->query($query);

//loop through returned result
$data = array();
foreach($result as $row){
	$data[] = $row;
}

//free memory of the result
$result->close();

//close connection
$mysqli->close();

print json_encode($data);
?>
