<?php
?>
<html>
   <head>
      <link rel="stylesheet" href="styles.css">
      <title>Welcome Constable </title>
   </head>
   
   <body background="./images/constable.jpg">
   <h1><center> <font face="Times New Roman"> Constable Homepage <?php echo $login_seesion; ?>
     </font> </center> </h1>
	<hr>

	<?php
                $link = mysqli_connect("localhost", "root", "password", "project_global");

                // Check connection
                if($link === false){
                    die("ERROR: Could not connect. " . mysqli_connect_error());
                }

                //this is the birthday finder
                $bquery = "select Name as Birthday_Today from Police_Employee  where day(DOB) = day(curdate()) and month(DOB)=month(curdate())";
        
                $result = mysqli_query($link, $bquery);
                $all_property = array();
                
                echo '<table align="right" class = "data-table" border = 1>
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
        ?>

        <form action="constable.php" method="post">
		
		<b><i><label for="ps"> Find Employee </label><br><br></b></i>
		<p>
                <label for="emp"> Enter Employee ID: </label>
                <input type="text" name="eid" id="emp_id"><br><br>
		</p>

		<p>
                <label for="emp"> Enter Name: </label>
                <input type="text" name="ename" id="emp_id"><br><br>
		</p>
		<p>
                <label for="emp"> Enter Rank: </label>
                <input type="text" name="erank" id="emp_id"><br><br>
		</p>

		<b><i><label for="ps"> See Police Station Details </label><br><br></b></i>
		<p>
		<label for="branch_id"> Enter Branch ID: </label>
                <input type="text" name="bid" id="branch_id"><br><br>
		</p>
		<p>
                <label for="city_name"> Enter City: </label>
                <input type="text" name="city" id="city_name"><br><br>
 		</p>

                <b><i><label for="ps"> See Crime Details </label><br><br></b></i>
		<p>
		<label for="crime_id"> Enter Crime ID: </label>
                <input type="text" name="cid" id="crime_id"><br><br>
		</p>

		<p>
		<label for="crime_id"> Date of Reporting: </label>
                <input type="text" name="cdate" id="crime_id"><br><br>
		</p>
		
		<label for="crime_id"> Crime Type </label><br>
		<p>
		<label for="some_lable">(Murder, Kidnapping, Robbery, Challan, Missing):</label>
                <input type="text" name="ctype" id="crime_id"><br><br>
		</p>

		<b><i><label for="ps"> See Person Of Interest Details </label><br><br></b></i>
		<p>
		<label for="poi_id"> Enter POI ID: </label>
                <input type="text" name="poiid" id="poi_id"><br><br>
		</p>

                <b><i><label for="ps"> Solved Case Details </label><br><br></b></i>
		<p>
		<label for="scrime_id"> Enter Solved Case ID: </label>
                <input type="text" name="scid" id="scrime_id"><br><br>
                </p>
                <input type="submit" value="Submit">
        </form>
	<a href="http://localhost/Kerala_police/demo/find_missing/missing.html"><h3>
	Identify Body</h3></a><br>
      <h2><a href = "logout.php">Sign Out</a></h2>
   </body>
   
</html>
