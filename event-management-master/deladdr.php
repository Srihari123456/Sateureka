<html>
<head>
<link rel="icon" href="static/images/LOGO.jpg" type="image/gif" sizes="16x16">
</head>
<body>
<?php 
include "database/connect.php";
?>
<?php

 

$sq1 = "DELETE FROM `chatbox` where message = 'Addressed'"  ;
$result = mysqli_query($con,$sq1) or die(mysqli_error($con));
 	?>
	<a href="dashboard.php" style="text-decoration:none;color:tomato;" >
 <button align="center" style="margin-left:30%">PROCEED</button> </a>
  <?php
$con->close();
?>


</body>
</html>