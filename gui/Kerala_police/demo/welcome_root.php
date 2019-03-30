<?php
   include('session.php');
?>
<html">
   
   <head>
      <title>Welcome Root </title>
   </head>
   
   <body background="https://image.freepik.com/free-photo/wooden-gavel-law-book-put-white-marble-table-top-counter_35675-428.jpg">
      <h1>Welcome <?php echo $login_session; ?></h1> 
      <h2><a href = "logout.php">Sign Out</a></h2>
   </body>
   
</html>
