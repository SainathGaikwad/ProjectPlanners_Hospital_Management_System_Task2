<?php

  session_start();
  $errorMessage="";
  if(isset($_POST['SUBMIT'])){
    if(empty($_POST['EMPID'])){
      $errorMessage ="EMPLOYEE ID MISSING!! TRY AGAIN!!";
    }else{
      $employeeid=trim($_POST['EMPID']);
      $employeeid = strip_tags($employeeid);
      $employeeid = htmlspecialchars($employeeid);
      
      $mysqli = mysqli_connect("localhost", "root", "", "hms");
      $search = "SELECT * FROM employee WHERE Employee_ID='$employeeid'";
      $result = $mysqli->query($search);
      $row = $result->fetch_assoc();
      if($result->num_rows==1){
        $_SESSION['user']= $employeeid;
        $type = $row['Employee_Type'];
        if ($type ==1){
          header("location: aboutme.php");
        }else if($type ==2){
          header("location: nurse.php");
        }else{
          header("location: receptionist.php");
        }
     
      }else{
        $errorMessage="EMPLOYEE ID INCORRECT!! TRY AGAIN!!";
      }
      mysqli_close($mysqli);

    }
}
