<?php
$link = mysqli_connect("localhost", "root", "password", "project_global");
 
// Check connection
if($link === false){
    die("ERROR: Could not connect. " . mysqli_connect_error());
}
 
$crime_ID = $_POST['cid'];
$cdate_ID = $_POST['cdate'];
$ctype_ID = $_POST['ctype'];

$poi_ID = $_POST['poiid'];
$scrime_ID = $_POST['scid'];

$emp_ID = $_POST['eid'];
$emp_name = $_POST['ename'];
$emp_rank = $_POST['erank'];

$branch_ID = $_POST['bid'];
$city_ID   = $_POST['city'];

if((!empty($emp_ID))||(!empty($emp_name))||(!empty($emp_rank))){

$equery = "select * from employee_level1";
$conditions = array();

if(!empty($emp_ID)){
	$conditions[] = "Police_ID = '$emp_ID'";
}

if(!empty($emp_name)){
	$conditions[] = "Name = '$emp_name'";
}

if(!empty($emp_rank)){
	$conditions[] = "Rank = '$emp_rank'";
}

$sql = $equery;

if(count($conditions) > 0){
	$sql .= " where ".implode(' and ', $conditions);
}

$result = mysqli_query($link, $sql);
$all_property = array();

echo "<h3> Employee Data: </h3><br>";
echo '<table class = "data-table" border = 1>
	<tr class = "data-heading">';

while ($property = mysqli_fetch_field($result)) {
    echo '<td>' . $property->name . '</td>';  //get field name for header
    array_push($all_property, $property->name);  //save those to array
}
echo '</tr>'; //end tr tag

//showing all data
while ($row = mysqli_fetch_array($result)) {
    echo "<tr>";
    foreach ($all_property as $item) {
        echo '<td>' . $row[$item] . '</td>'; //get items using property value
    }
    echo '</tr>';
}
echo "</table><br>";
}


//for displaying Branch information
if((!empty($_POST['bid']))||(!empty($_POST['city']))){
	
$equery = "select * from Police_Station";
$conditions = array();

if(!empty($branch_ID)){
	$conditions[] = "Branch_ID = '$branch_ID'";
}

if(!empty($city_ID)){
	$conditions[] = "City = '$city_ID'";
}

$sql = $equery;

if(count($conditions) > 0){
	$sql .= " where ".implode(' and ', $conditions);
}

$result = mysqli_query($link, $sql);
$all_property = array();

echo "<h3> Branch Data: </h3><br>";
echo '<table class = "data-table" border = 1>
	<tr class = "data-heading">';

while ($property = mysqli_fetch_field($result)) {
    echo '<td>' . $property->name . '</td>';  //get field name for header
    array_push($all_property, $property->name);  //save those to array
}
echo '</tr>'; //end tr tag

//showing all data
while ($row = mysqli_fetch_array($result)) {
    echo "<tr>";
    foreach ($all_property as $item) {
        echo '<td>' . $row[$item] . '</td>'; //get items using property value
    }
    echo '</tr>';
}

echo "</table><br>";
}

//$crime_ID = $_POST['cid'];
//$cdate_ID = $_POST['cdate'];
//$ctype_ID = $_POST['ctype'];

if((!empty($crime_ID))||(!empty($cdate_ID))||(!empty($ctype_ID))){

$equery = "select * from Crime";
$conditions = array();

if(!empty($crime_ID)){
	$conditions[] = "Case_ID = '$crime_ID'";
}

if(!empty($cdate_ID)){
	$conditions[] = "Date_Of_Reporting = '$cdate_ID'";
}

if(!empty($ctype_ID)){
	$conditions[] = "Crime_Type = '$ctype_ID'";
}

$sql = $equery;

if(count($conditions) > 0){
	$sql .= " where ".implode(' and ', $conditions);
}

$result = mysqli_query($link, $sql);
$all_property = array();

echo "<h3> Crime Data: </h3><br>";
echo '<table class = "data-table" border = 1>
	<tr class = "data-heading">';

while ($property = mysqli_fetch_field($result)) {
    echo '<td>' . $property->name . '</td>';  //get field name for header
    array_push($all_property, $property->name);  //save those to array
}
echo '</tr>'; //end tr tag

//showing all data
while ($row = mysqli_fetch_array($result)) {
    echo "<tr>";
    foreach ($all_property as $item) {
        echo '<td>' . $row[$item] . '</td>'; //get items using property value
    }
    echo '</tr>';
}
echo "</table><br>";
}

//for displayig poi information
if(!empty($_POST['poiid'])){

$result = mysqli_query($link, "SELECT * FROM poi_level1 where Suspect_ID = '$poi_ID'");
$all_property = array();

echo "<h3> Suspect Data: </h3><br>";
echo '<table class = "data-table" border = 1>
	<tr class = "data-heading">';

while ($property = mysqli_fetch_field($result)) {
    echo '<td>' . $property->name . '</td>';  //get field name for header
    array_push($all_property, $property->name);  //save those to array
}
echo '</tr>'; //end tr tag

//showing all data
while ($row = mysqli_fetch_array($result)) {
    echo "<tr>";
    foreach ($all_property as $item) {
        echo '<td>' . $row[$item] . '</td>'; //get items using property value
    }
    echo '</tr>';
}
echo "</table><br>";

}

//for displaying Solved Crime information
if(!empty($_POST['scid'])){

$result = mysqli_query($link, "SELECT * FROM Solved_Cases where Case_ID = '$scrime_ID'");
$all_property = array();

echo "<h3> Solved Crime Data: </h3><br>";
echo '<table class = "data-table" border = 1>
	<tr class = "data-heading">';

while ($property = mysqli_fetch_field($result)) {
    echo '<td>' . $property->name . '</td>';  //get field name for header
    array_push($all_property, $property->name);  //save those to array
}
echo '</tr>'; //end tr tag

//showing all data
while ($row = mysqli_fetch_array($result)) {
    echo "<tr>";
    foreach ($all_property as $item) {
        echo '<td>' . $row[$item] . '</td>'; //get items using property value
    }
    echo '</tr>';
}
echo "</table><br>";

}

mysqli_close($link);
?>
