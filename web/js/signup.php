<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <?php
        $dbhost = "localhost";
        $dbuser = "root";
        $dbpass = "bhagya";
        $dbname = "projectssale";

        $sqlconnection = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);
        if (mysqli_connect_errno()) {
            die("DataBase Connection failed: " . "(" . mysqli_connect_errno() . ")");
        }

        $Query = "SELECT * FROM user";



        $Result = mysqli_query($sqlconnection, $Query);
        if (!$Result) {
            die("Database Query Failed. Contact Admin");
        }
        $val = mysqli_fetch_assoc($Result);
        echo print_r($val);
        
        mysqli_close($sqlconnection);
        
        ?>
    </body>
</html>
