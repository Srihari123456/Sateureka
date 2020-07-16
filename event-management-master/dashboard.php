
<?php
session_start();
$ip_add = getenv("REMOTE_ADDR");
include "database/connect.php";
?>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" href="static/images/LOGO.jpg" type="image/gif" sizes="16x16">
</head>
<body>
<?php 

include "static/cssjs/css.php";
?>
<html>
<head>

<style>
table {  
    color: #333;
    font-family: Helvetica, Arial, sans-serif;
    width: 640px; 
    border-collapse: 
    collapse; border-spacing: 0; 
}

td, th {  
    border: 1px solid transparent; /* No more visible border */
    height: 30px; 
    transition: all 0.3s;  /* Simple transition for hover effect */
}

th {  
    background: #DFDFDF;  /* Darken header a bit */
    font-weight: bold;
    text-align: center;
}

td {  
    background: #FAFAFA;
    text-align: center;
}

/* Cells in even rows (2,4,6...) are one color */        
tr:nth-child(even) td { background: #F1F1F1; }   

/* Cells in odd rows (1,3,5...) are another (excludes header cells)  */        
tr:nth-child(odd) td { background: #FEFEFE; }  

tr td:hover { background: #666; color: #FFF; }  
/* Hover cell effect! */
</style>
</head>
<a href="index.php" ><img src="static/images/LOGO.jpg" style="z-index: +2;position:absolute;width:150px;height:125px;margin-left:30px "></a>
<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
    <div class="container">
      <a class="navbar-brand" href="index.php">SATEUREKA</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="oi oi-menu"></span> Menu
      </button>

      <div class="collapse navbar-collapse" id="ftco-nav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item active"><a href="index.php" class="nav-link">Home</a></li> 
          <li class="nav-item"><a href="#about" class="nav-link">about</a></li>
          
          <li class="nav-item cta"><a href="index.php" class="nav-link"><span>Log-out</span></a></li>
        </ul>
      </div>
    </div>
  </nav>
    <body >

                <div >
 
	<div class="hero-wrap js-fullheight" style="background-image: url('https://www.starletters.com/wp-content/uploads/2017/11/38056454431_706e1e5a68_k.jpg');"> 
	  <div class="hero-wrap js-fullheight" style=" margin-top: 0px;  margin-left: 100px;">
 <br><br><br>
    <!-- END nav -->
    <table  align="center" border="1px" style="width:640px;line-height:60px;border-collapse: collapse; 
    border-spacing: 0;">
	<tr>
	<th colspan="3" border=" 1px solid #CCC" >
	<h1 align="center">Welcome To Gyan Portal </h1>
	</th>
	</tr>
	
	
	
	<TR><td border=" 1px solid #CCC">
	Know  About The Budding Interns
		</td>
	
	<td border=" 1px solid #CCC">
	<a href="internsql.php" ><button class="browse d-md-flex col-md-12" >Details</button></a>
	
	<form action="proc1.php" method="POST"><input type="submit" class="browse d-md-flex col-md-12" value="Get SalaryDetails">
	
	</td>
	
	<td border=" 1px solid #CCC">
	<input type="text"  name="emp_id"   title="Enter the scientist id" placeholder="Enter the scientist id" required /><br>
	</form>
	</td></tr>
	
	
	<TR><td border=" 1px solid #CCC">
	Examine Mission Status
		</td>
		<form action="proc3.php" method = "POST">
	<td border=" 1px solid #CCC">
	<input type="submit" class="browse d-md-flex col-md-12" value="Get MissionStatus">
	</td>
	
	<td border=" 1px solid #CCC">
		<input type="text" name="emp_id"   title="Enter the mission id" placeholder="Enter the mission id" required /><br>
	</td></tr>
	</FORM>
	
	
	<TR><td border=" 1px solid #CCC">
	Find Astronaut Job
		</td>
		<form action="proc4.php" method = "POST">
	<td border=" 1px solid #CCC">
	<input type="submit" class="browse d-md-flex col-md-12" value="Get AstroRole">
	</td>
	
	<td border=" 1px solid #CCC">
		<input type="text" name="emp_id" title="Enter the astronaut name"  placeholder="Enter the astronaut name" required /><br>
	</td></tr>
	</FORM>
	
	
	<TR><td border=" 1px solid #CCC">
	Glance the Active Satellites
		</td>
	
	<td border=" 1px solid #CCC">
	<a href="0.php" ><button class="browse d-md-flex col-md-12">Details</button></a>
	</td>
	
	<td border=" 1px solid #CCC">
	<a href="mission_satellite_naturaljoin.php" ><button class="browse d-md-flex col-md-12" >Indepth View</button></a>
	</td></tr>
	<TR><td border=" 1px solid #CCC">
	Update Fuel Status
		</td>
	
	
	<td border=" 1px solid #CCC">
	
	
	
	<form action="fuel.php" method = "POST">
	<input type="submit" class="browse d-md-flex col-md-12" value="Update">
	
	
	</td>
	
	<td border=" 1px solid #CCC">
	<input type="text" name="sate_id" title="Enter the satellite id"  placeholder="Enter the satellite id" required /><br>
	<input type="number" name="fuelamt" title="Enter the new fuel amount"  placeholder="Enter the new fuel amount" required /><br>
	</form>
	
	</td></tr>
	<TR><td border=" 1px solid #CCC">
	Address Chat Queries
		</td>
	
	<td border=" 1px solid #CCC">
	<a href="chatboxqueries.php" ><button class="browse d-md-flex col-md-12">Details</button></a>
	</td>
	
	<td border=" 1px solid #CCC">
	
	<a href="deladdr.php" ><button class="browse d-md-flex col-md-12">Delete Addressed Queries</button></a>
	</td></tr>
	
	</table>
	
	</div>
	</div>
<pre id="about"></pre>
  <?php
  
include "includes/footer.php";
  include "static/cssjs/js.php";
  ?>
  </body>
  </html>