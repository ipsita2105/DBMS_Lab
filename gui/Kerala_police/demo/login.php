<?php
   include("config.php");
   session_start();
   if($_SERVER["REQUEST_METHOD"] == "POST") {
      // username and password sent from form 
      $myusername = mysqli_real_escape_string($db,$_POST['username']);
      $mypassword = mysqli_real_escape_string($db,$_POST['password']); 
      $sql = "SELECT * FROM login WHERE username = '$myusername' and password = '$mypassword'";
      $result = mysqli_query($db,$sql);
      $row = mysqli_fetch_array($result,MYSQLI_ASSOC);
      $active = $row['active'];
      $count = mysqli_num_rows($result);
      // If result matched $myusername and $mypassword, table row must be 1 row
		
      if($count == 1) {
	      
	      $_SESSION['myusername']='username';
	      
         $_SESSION['login_user'] = $myusername;
        switch ($myusername) {
    case "root":
        header('location: welcome_root.php');
        break;
    case "clerk":
        header('location: welcome_clerk.php');
        break;
    case "constable":
        header('location: welcome_constable.php');
        break;
    case "superintendent":
        header('location: welcome_superintendent.php');
        break;        
    default:
        header('location: welcome_head.php');
	} 
      }
      else {
         $error = "Your Login Name or Password is invalid";
      }
   }
?>
