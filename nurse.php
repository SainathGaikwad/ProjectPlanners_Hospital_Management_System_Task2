<?php
include 'session.php';
$user = $_SESSION['user'];
$mysqli = mysqli_connect("localhost", "root", "", "hms");

 ?>

<html>

<head>
    <title>Nurse</title>
</head>

<body>
    <h1 class="title">Welcome <?php echo $user;?>!</h1>
    <div align="center">
        <?php
       $patients = "SELECT P.patient_ID, P.Fname, P.Lname, P.Minit, P.Weight, P.Height, P.blood_type FROM patient AS P, employee_has_patient AS EP
       where EP.patient_patient_ID = P.patient_ID AND EP.employee_Type = 2
       AND EP.employee_Employee_ID ='$user'";
       echo "<table><caption>MY PATIENTS</caption><col width='130'><col width='130'><col width='130'><col width='130'><col width='130'><col width='130'><col width='130'>";
       echo "<tr><th>Patient ID</th><th>First Name</th><th>Middle Initial</th><th>Last Name</th><th>Weight</th><th>Height</th><th>Blood Type</th></tr>";
       $res = $mysqli->query($patients);
       if($res->num_rows>0){
         while($row=$res->fetch_assoc()){
             echo  "<tr><td>" . $row['patient_ID'] . "</td><td> " .  $row['Fname'] . "</td><td> " . $row['Minit'] . "</td><td> " . $row['Lname'] . "</td><td>". $row['Weight']. "</td><td>" . $row['Height'] . "</td>";
             echo  "<td>" . $row['blood_type'] . "</td></tr> ";
         }
       }else{
           echo "<h2 style='text-align:center;color: #666;'>No patients.</h2>";
         }
         echo "</table";
        ?>
    </div>

    <a href="logout.php">Logout</a>
</body>
<style media="screen">
body {
    color: white;
    background: #B24592;
    background: -webkit-linear-gradient(to right, #F15F79, #B24592);
    background: linear-gradient(to right, #F15F79, #B24592);
    text-align: center;
}

table,
tr,
td {
    text-align: center;
    border: 1px solid black;
    font-size: 20px;
}

.title {
    color: white;
    text-align: center;
}
</style>

</html>