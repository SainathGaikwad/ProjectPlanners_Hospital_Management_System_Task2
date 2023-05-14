<?php

include 'login.php';
$user = $_SESSION['user'];
?>
<html>

<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="style.css">
    <title>Login</title>
</head>

<body>
    <div id="main" align="center">
        <h1>Hospital Management System</h1>
        <div id="login" align="center">

            <form action="" method="POST">
                <p>
                    <label for="employeeid">Name: </label><br>
                    <input id="employeeid" name="EMPID" placeholder="Employee ID" type="text"><br>
                </p>

                <p>
                    <input type="submit" name="SUBMIT" value="    LOGIN    ">
                </p>

                <span style="color:red;"><?php echo $errorMessage; ?></span>
            </form>
        </div>

</body>

<style>
body {
    color: white;
    background: #B24592;
    background: -webkit-linear-gradient(to right, #F15F79, #B24592);
    background: linear-gradient(to right, #F15F79, #B24592);

}

#main {
    text-align: center;
}

#login {
    background-color: pink;
    padding: 20px;
    border-radius: 8px;
    width: 50%;
    margin-left: 24%;
}

label {
    text-transform: uppercase;
    font-weight: bolder;
}

p {
    border-radius: 7px;
    padding: 10px;
}

input[type=text],
input[type=password] {
    text-align: center;
    padding: 5px;
    border-radius: 3px;
}
</style>

</html>