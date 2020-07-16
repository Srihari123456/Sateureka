  <?php
  include "database/connect.php";
  include "static/cssjs/css.php";
  
  if(isset($_POST['emp_id'])){
	$emp_id = $_POST['emp_id'];
  }
   $q0 = "SELECT `Salary(In lakhs)`('$emp_id') AS `Salary(In lakhs)`; ";
 $r = mysqli_query($con,$q0) or die(mysqli_error($con));;
  
  
  ?>
<html>
<head>
<link rel="icon" href="static/images/LOGO.jpg" type="image/gif" sizes="16x16">

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
<body>
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
  
  

	<div class="hero-wrap js-fullheight" style="background-image: url('https://www.starletters.com/wp-content/uploads/2017/11/38056454431_706e1e5a68_k.jpg');margin-top: 0px;">
    <div class="hero-wrap js-fullheight" style=" margin-top: 00px;margin-left: 50px;">
	<br><br><br><br><br><br><br><br>
    <!-- END nav -->
    <table  align="center" border="1px" style="width:640px;line-height:60px;border-collapse: collapse; 
    border-spacing: 0;">
	<tr>
	<th colspan="2" border=" 1px solid #CCC" >
	<h1 align="center">Scientist Salary Details</h1>
	</th>
	</tr>
	
	<TR>
		<TH border=" 1px solid #CCC">Employee ID</TH>
		<TH border=" 1px solid #CCC">Salary(In lakhs)</TH>
	</TR>
	
	<?php
		while($rows = mysqli_fetch_assoc($r)){ ?>	
	
	<TR>
	
	<td border=" 1px solid #CCC">
	<?php
	echo $emp_id; 	?>	</td>
	
	<td border=" 1px solid #CCC">
	<?php
	echo $rows['Salary(In lakhs)']; 	?>	</td>
	
<!--	<td border=" 1px solid #CCC">
	<?php
	echo $rows['de_sat']; 	?></td>
	
	<td border=" 1px solid #CCC">
	<?php
	echo $rows['de_m']; 	?>	</td>	-->
	</tr>
		<?php } ?>
	
	
	
	
	
	
	
	
	
	</table>
	
	
	
	
	
	</div>
	
</div>
 
    <section class=" ftco-destination">
    	<div class="container">
    		<div class="row justify-content-start mb-5 pb-3">
          <div class="col-md-7 heading-section ftco-animate">
        
            <h2 class="mb-4"><strong>Achievements</strong> Till Date</h2>
          </div>
        </div>
    		<div class="row">
    			<div class="col-md-12">
    				<div class="single-slider owl-carousel ftco-animate">
    					<div class="item">
		    				<div class="destination">
		    					<a href="#" class="img d-flex justify-content-center align-items-center" style="background-image: url(static/images/cs01.jpg);">
		    						
		    					</a>
		    					
		    				</div>
	    				</div>
	    				<div class="item">
		    				<div class="destination">
		    					<a href="#" class="img d-flex justify-content-center align-items-center" style="background-image: url(static/images/_02.jpg);">
		    						
		    					</a>
		    					
		    				</div>
	    				</div>
	    				<div class="item">
		    				<div class="destination">
		    					<a href="#" class="img d-flex justify-content-center align-items-center" style="background-image: url(static/images/cs03.jpg);">
		    						
		    					</a>
		    					
		    				</div>
	    				</div>
	    				<div class="item">
		    				<div class="destination">
		    					<a href="#" class="img d-flex justify-content-center align-items-center" style="background-image: url(static/images/sack.jpg);">
		    						
		    					</a>
		    					
		    				</div>
	    				</div>
	    				<div class="item">
		    				<div class="destination">
		    					<a href="#" class="img d-flex justify-content-center align-items-center" style="background-image: url(static/images/nasa02.jpg);">
		    						
		    					</a>
		    					
		    				</div>
	    				</div>
	    				<div class="item">
		    				<div class="destination">
		    					<a href="#" class="img d-flex justify-content-center align-items-center" style="background-image: url(static/images/cs04.jpg);">
		    						
		    					</a>
		    					
		    				</div>
	    				</div>
    				</div>
    			</div>
    		</div>
    	</div>
    </section>
    
    <section class=" bg-light" id="events">
    	<div class="container" id="0">
    		<div class="row justify-content-start mb-5 pb-3">
             <div class="col-md-7 heading-section ftco-animate">
      <!--    	<span class="subheading">events</span>
            <h2 class="mb-4"><strong>Book Your</strong>  Faviourate Event</h2>
          --></div>
        </div>  
    		<div class="row" id="technical" >
    			<div class="col-md-12 ftco-animate">
    				<div id="accordion">
    					<div class="row" >
                <div class="col-md-12">
                  <div id="get_events"></div>
                      
                  </div>           
    					</div>
				    </div>
    			</div>
    		</div>
    	</div>
    </section>
    
    

    

    <section class="ftco-section ftco-counter img" id="section-counter" style="background-image: url(static/images/bg_1.jpg);">
    	<div class="container">
    		<div class="row justify-content-center mb-5 pb-3">
          <div class="col-md-7 text-center heading-section heading-section-white ftco-animate">
            <h2 class="mb-4">Finger Facts</h2>
            <span class="subheading">More than 100,000 rockets hosted</span>
          </div>
        </div>
    		<div class="row justify-content-center">
    			<div class="col-md-10">
		    		<div class="row">
		          <div class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate">
		            <div class="block-18 text-center">
		              <div class="text">
		                <strong class="number" data-number="100000">0</strong>
		                <span>Satellite R and D</span>
		              </div>
		            </div>
		          </div>
		          <div class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate">
		            <div class="block-18 text-center">
		              <div class="text">
		                <strong class="number" data-number="40000">0</strong>
		                <span>Employees</span>
		              </div>
		            </div>
		          </div>
		          <div class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate">
		            <div class="block-18 text-center">
		              <div class="text">
		                <strong class="number" data-number="87000">0</strong>
		                <span>Average stipend</span>
		              </div>
		            </div>
		          </div>
		          <div class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate">
		            <div class="block-18 text-center">
		              <div class="text">
		                <strong class="number" data-number="5640000000000000">0</strong>
		                <span>Tweets till date</span>
		              </div>
		            </div>
		          </div>
		        </div>
	        </div>
        </div>
    	</div>
    </section>
<div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


  <?php
  include "static/cssjs/js.php";
  
include "includes/footer.php";
  ?>
  </body>  
</html>
    
		
		

    
  
                                    