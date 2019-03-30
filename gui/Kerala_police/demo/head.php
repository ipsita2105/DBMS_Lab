<?php
$link = mysqli_connect("localhost", "root", "password", "project_global");
 
// Check connection
if($link === false){
    die("ERROR: Could not connect. " . mysqli_connect_error());
}

$police_ID = $_POST['pid'];
$emp_ID = $_POST['eid'];
$emp_name = $_POST['ename'];
$emp_rank = $_POST['erank'];

$branch_ID = $_POST['bid'];
$city_ID   = $_POST['city'];

if((!empty($emp_ID))||(!empty($emp_name))||(!empty($emp_rank))){

$equery = "select * from Police_Employee";
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

if(!empty($_POST['pid'])){

$result = mysqli_query($link, "SELECT * FROM Attendance where Police_ID = '$police_ID' and Date = curdate()");
$all_property = array();

echo "<h3> Attendance Data: </h3><br>";
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
