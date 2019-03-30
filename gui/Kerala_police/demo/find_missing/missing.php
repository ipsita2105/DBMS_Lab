<?php
$link = mysqli_connect("localhost", "root", "password", "project_global");
 
// Check connection
if($link === false){
    die("ERROR: Could not connect. " . mysqli_connect_error());
}

$complexion  = $_POST['comp'];
$height      = $_POST['height'];

if((!empty($_POST['comp']))||(!empty($_POST['height']))){
	
	$equery = "select * from Missing where Color = '$complexion' and Height >= $height-0.2 and Height <= $height+0.2 ";

$conditions = array();

$result = mysqli_query($link, $equery);
$all_property = array();

echo "<h3> Missing Data: </h3><br>";
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

