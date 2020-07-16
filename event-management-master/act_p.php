
<?php 

include "static/cssjs/css.php";



include "includes/footer.php";
?>
<html>
<head>

<link rel="icon" href="static/images/LOGO.jpg" type="image/gif" sizes="16x16">
</head>
<body onload = "popupfunction()">
<script>
function popupfunction() {
  alert("We've taken note of your query:)");
}
</script>
<?php
	if(isset($_POST['msg'])){
	$msg = $_POST['msg'];
	}
	
	$servername = "localhost";
	$username = "root";
	$password = "";
	$dbname = "satdb";
	
	$conn = mysqli_connect($servername,$username,$password,$dbname);

	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	
    
	$sql = "INSERT INTO `chatbox` (`message`) VALUES('$msg');";
  
	if ($conn->query($sql) === TRUE) {
		//echo "<b>New record created successfully</b>";
		//echo "<nbsp> <nbsp> <nbsp> <nsbsp> <h2>successful entry</h2>";
	} else {
		echo "Error: " . $sql . "<br>" . $con->error;
	}

   
   
	$conn->close();
	?>
 <?php
  include "static/cssjs/js.php";
  ?>