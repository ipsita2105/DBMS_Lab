<?php
   include('session.php');
?>

<html>

   <head>
      <title>Welcome </title>
   </head>
   
   <body background="https://wallpapercave.com/wp/wp2709928.jpg">
      <h1>Welcome <?php echo $login_session; ?></h1> 
      <h2><a href = "logout.php">Sign Out</a></h2>
   </body>
   
</html>
