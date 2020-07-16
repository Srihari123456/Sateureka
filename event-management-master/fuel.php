<html>
<head>
<link rel="icon" href="static/images/LOGO.jpg" type="image/gif" sizes="16x16">
</head>
<body>
<?php 
include "database/connect.php";
?>
<?php
if(isset($_POST['sate_id'])){ // Fetching variables of the form which travels in URL
$sate_id = $_POST['sate_id'];
}
if(isset($_POST['fuelamt'])){
$fuelamt = $_POST['fuelamt'];
}
 

$sq1 = "UPDATE `payload` set fuel = '$fuelamt' where sat_id = '$sate_id'"  ;
$result = mysqli_query($con,$sq1) or die(mysqli_error($con));
 	?>
	<a href="dashboard.php" style="text-decoration:none;color:tomato;" >
 <button align="center" style="margin-left:30%">PROCEED</button> </a>
  <?php
$con->close();
?>


</body>
</html>