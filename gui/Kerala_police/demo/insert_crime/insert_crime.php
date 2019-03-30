<?php
$servername = "localhost";
$username = "root";
$password = "password";
$dbname = "project_global";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$Case_ID = mysqli_real_escape_string($conn, $_REQUEST['Case_ID']);
$Crime_Type =mysqli_real_escape_string($conn, $_REQUEST['Crime_Type']);
$Police_ID = mysqli_real_escape_string($conn, $_REQUEST['Police_ID']);
$Date_Of_Reporting = mysqli_real_escape_string($conn, $_REQUEST['Date_Of_Reporting']);
$Date_Of_Crime = mysqli_real_escape_string($conn, $_REQUEST['Date_Of_Crime']);
$Time_Of_Reporting = mysqli_real_escape_string($conn, $_REQUEST['Time_Of_Reporting']);
$Time_Of_Crime = mysqli_real_escape_string($conn, $_REQUEST['Time_Of_Crime']);
$Filer_Name =mysqli_real_escape_string($conn, $_REQUEST['Filer_Name']);
$Crime_Location = mysqli_real_escape_string($conn, $_REQUEST['Crime_Location']);
$Filer_Relation_To_Victim =mysqli_real_escape_string($conn, $_REQUEST['Filer_Relation_To_Victim']);

#$sql = "INSERT INTO payments (date, charge, payment, client_no, client_name, check_no, check, cash, notes, staff_initials) VALUES ('$date', '$charge', '$payment', '$client_no', '$client_name', '$check_no', '$check', '$cash', '$notes', '$staff_initials')";


$sql = "INSERT INTO Crime (Case_ID,Crime_Type,Police_ID,Date_Of_Reporting,Date_Of_Crime,Time_Of_Reporting,Time_Of_Crime,Filer_Name,Crime_Location,Filer_Relation_To,Victim) VALUES ('$Case_ID', '$Crime_Type', '$Police_ID', '$Date_Of_Reporting', '$Date_Of_Crime', '$Time_Of_Reporting', '$Time_Of_Crime', '$Filer_Name', '$Crime_Location', '$Filer_Relation_To_Victim')";




#$sql = "INSERT INTO Crime (Case_ID,Crime_Type,Police_ID,Date_Of_Reporting,Date_Of_Crime,Time_Of_Reporting,Time_Of_Crime,Filer_Name,Crime_Location,Filer_Relation_To,Victim)
#VALUES ('$_POST[Case_ID]','$_POST[Crime_Type]','$_POST[Police_ID]','$_POST[Date_Of_Reporting]''$_POST[Date_Of_Crime]',
#'$_POST[Time_Of_Reporting]''$_POST[Time_Of_Crime]''$_POST[Filer_Name]''$_POST[Crime_Location]''$_POST[Filer_Relation_To_Victim]')\";
if(mysqli_query($conn, $sql)){
    echo "Records added successfully.";
} else{
    echo "ERROR: Could not able to execute $sql. " . mysqli_error($conn);
}


echo "1 record added\";

mysqli_close($conn);
"
?>

