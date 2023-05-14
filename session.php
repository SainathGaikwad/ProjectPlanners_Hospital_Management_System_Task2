<?php
  $mysqli=mysqli_connect("localhost", "root", "", "hms");
  if($mysqli-> connect_errno){
    printf("ERROR");
  }
  session_start();
  $employeecheck=$_SESSION['user'];
  $sess ="select employee_ID from employee where employee_ID='$employeecheck'";
  $result=$mysqli->query($sess);
  $row=$result->fetch_assoc();
  $login_session = $row['employee_ID'];
  if(!isset($login_session)){
    mysqli_close($mysqli); 
    header('Location: index.php'); 
  }
