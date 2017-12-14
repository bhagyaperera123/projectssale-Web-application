<%-- 
    Document   : Forgot_Password
    Created on : Feb 26, 2015, 9:26:52 AM
    Author     : Bhagya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <title>Forgot Your Password</title>
        <script>
            function recover() {
                var xmlhttp ;
                if (window.XMLHttpRequest) {
                    xmlhttp=new XMLHttpRequest();
                } else {
                    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText;    
                        if(te == 1){
                           // window.location = ;
                        }else{
                            alert("Invalid Email");
                        }
                    }
                }
                var eml = document.getElementById("emailInput").value;
                xmlhttp.open("POST","Forgot_Password?email="+eml,true);
                xmlhttp.send();
            }
        </script>
    </head>
    <body>
        <hr>
        <div class="container">
            <div class="row">
                <div class="row">
                    <div class="col-md-4 col-md-offset-4">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="text-center">
                                    <h3><i class="fa fa-lock fa-4x"></i></h3>
                                    <h2 class="text-center">Forgot Password?</h2>
                                    <p>You can reset your password here.</p>
                                    <div class="panel-body">              
                                        <fieldset>
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-envelope color-blue"></i></span>
                                                    <input id="emailInput" name="email" placeholder="email address" class="form-control" type="email" oninvalid="setCustomValidity('Please enter a valid email address!')" onchange="try{setCustomValidity('')}catch(e){}" required="">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <input onclick="recover()" class="btn btn-lg btn-primary btn-block" value="Send My Password" type="submit">
                                            </div>
                                        </fieldset>                  
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
