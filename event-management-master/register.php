<?php

$ip_add = getenv("REMOTE_ADDR");
include "database/connect.php";
?>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" href="static/images/LOGO.jpg" type="image/gif" sizes="16x16">
</head>
  <body>
  <a href="index.php" ><img src="static/images/LOGO.jpg" style="z-index: +2;position:absolute;width:150px;height:125px;margin-left:30px "></a>
<?php 
include "static/cssjs/css.php";
include "includes/header.php";
  ?>

  <style>
  .field-border{
    border-radius:20px;
    
  }
  </style>
  

<section class="ftco-section contact-section ftco-degree-bg">
      <div class="container">
      <div class="col-md-8" id="signup_msg">
         <!--Alert from signup form-->
       </div>
        <div class="row block-9">
          <div class="col-md-6 pr-md-5">
            <form id="signup_form" action="dash.php" method="POST" class="was-validated">
              <div class="form-group" >
                <input type="text " name="uname" class="form-control field-border" placeholder="Your Name"  required>
              </div>
              <div class="form-group">
                <input type="password" name="password" class="form-control field-border" placeholder="Password" required>
              </div>
    
              <div class="form-group">
                <input type="text" class="form-control field-border" name="emp_id" placeholder="Employee id" required>
              </div>
              
               
              <div class="form-group">
                <input  value="Log-in" type="submit" name="signup_button" class="btn btn-primary py-3 px-5 " required>
              </div>
            </form>
          
          </div>

          <div class="col-md-6" id="map"></div>
        </div>
      </div>
 </section>





<?php
include "includes/footer.php";
?>
  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

  <?php
  include "static/cssjs/js.php";
  ?>
  </body>  
</html>