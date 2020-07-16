
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
<?php 

include "static/cssjs/css.php";

include "includes/header.php";
?><a href="index.php" ><img src="static/images/LOGO.jpg" style="z-index: +2;position:absolute;width:150px;height:125px;margin-left:30px "></a>
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
          
          <li class="nav-item cta"><a href="register.php" class="nav-link"><span>Register</span></a></li>
        </ul>
      </div>
    </div>
  </nav>
	<div id="lockin"    align="center"	>

								<form action="kiran.php" id="login" class="login100-form ">
									<div class="">
                                    <div class="">
                                        <h2 class="" >Login Here</h2>
                                    </div>
                                   </div>
                                    
                                    <div >
                                       <label for="EntreeID" style="color:red">EntreeID&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                        <input class="input input-borders"  type="text" name="entreeid" placeholder="EntreeID" id="password" required>
                                    </div>
                                    <div >
                                       <label for="email" style="color:red">Email&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                        <input class="input input-borders"  type="email" name="email" placeholder="Email" id="password" required>
                                    </div>
                                    
                                    <div class="form-group">
                                       <label for="email" style="color:red">Password</label>
                                        <input class="input input-borders" type="password" name="password" placeholder="password" id="password" required>
                                    </div>
                                    
                                    <div class="text-pad" >
                                       <a href="#">
                                           forgot password ?
                                       </a>
                                        
                                    </div>
                                    
                                        <input  align="center" size=20  type="submit"  Value="Login">
                                        
                                    
                                    	
                                        
                                    

                                </div>
                                
								</form>
                           
						

			</div>

<?php
include "includes/footer.php";
  include "static/cssjs/js.php";
  ?>
  
  </body>  
</html>