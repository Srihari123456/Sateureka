<html>
<head>

<link rel="icon" href="static/images/LOGO.jpg" type="image/gif" sizes="16x16">
</head>

<body style="background-image: url('https://i.ytimg.com/vi/-MKapbz0GIo/maxresdefault.jpg');">
<?php 
include "database/connect.php";
?>
<?php
if(isset($_POST['uname'])){ // Fetching variables of the form which travels in URL
$uname = $_POST['uname'];
}
if(isset($_POST['password'])){
$password = $_POST['password'];
}
if(isset($_POST['emp_id'])){
$emp_id = $_POST['emp_id'];
}


$sq1 = "SELECT * FROM `accounts` WHERE uname = '$uname' AND password = '$password'  AND emp_id = '$emp_id' "  ;
$result = mysqli_query($con,$sq1) or die(mysqli_error($con));
$num_rows = mysqli_num_rows($result);

if($num_rows > 0)
   {
    echo '<b>                       <h1 style="font-size:54px;color:yellow;margin-left:20%">ACCESS GRANTED TO LOG IN</h1>

			</b>';
   
	?>
	<a href="dashboard.php" style="text-decoration:none;color:tomato;" >
 <button align="center" style="margin-left:30%">PROCEED</button> </a>
   
 <?php
 }
   
else
   {
    echo '<b>    <br><br><br><br><br><br><br><h1>ACCESS DENIED TO LOG IN....INVALID USERNAME OR PASSWORD</h1><br><br><br></b>';
	   
	?>
	<a href="register.php" style="text-decoration:none;color:tomato;">
 <button align="center" >BACK</button> </a>
 <?php
	
   }

$con->close();
?>


</body>
</html>