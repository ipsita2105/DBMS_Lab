<?php
   include('session.php');
?>
<html>
   
   <head>
      <link rel="stylesheet" href="styles.css">
      <title>Welcome Head </title>
   </head>
   
   <body background="./images/head3.jpg">
        <h1><center> <font face="Times New Roman"> Director Homepage<?php echo $login_session; ?>
        </font></center></h1>
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

        <a href="http://localhost/graph/bargraph.html"><h2>Crime Vs Count Stats</h2></a><br>
        <a href="http://localhost/e_graph/bargraph.html"><h2>Officer Vs Case Stats</h2></a><br>

        <form action="head.php" method="post">

                <b><i><label for="ved"> Check Attendance  </label><br><br></b></i>
		<p>       
		<label for="police_id"> Enter Police ID: </label>
                <input type="text" name="pid" id="police_id"><br><br>	
		</p>
		
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
		<input type="submit" value="Submit">
        </form>
	

 	<h2><a href = "logout.php">Sign Out</a></h2>
   </body>
   
</html>
