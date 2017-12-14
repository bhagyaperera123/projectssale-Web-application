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
        <title>New Password</title>
        <!--        <script>
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
                            }
                        }
                        var eml = document.getElementById("emailInput").value;
                        xmlhttp.open("POST","Forgot_Password?email="+eml,true);
                        xmlhttp.send();
                    }
                </script>-->
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
                                    <h2 class="text-center">Reset Your Password</h2>
                                    <p>You can reset your password here.</p>
                                    <form action="Reset_Password" method="post">
                                        <div class="panel-body">              
                                            <fieldset>
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <%
                                                            String reval = "";
                                                            if (request.getParameter("id") != null) {
                                                                int id = Model.Main.valid_url(request.getParameter("id").toString());
                                                                String val = request.getParameter("val");

                                                                if (0 < id) {
                                                                    reval += Security.Security.encrypt(id+"");
                                                                } else {
                                                                    response.sendRedirect("index.jsp");
                                                                }
                                                            } else {
                                                                response.sendRedirect("index.jsp");
                                                            }
                                                        %>
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock color-blue"></i></span>
                                                        <input id="" name="unm" placeholder="New user Name" class="form-control" type="text">
                                                        <input id="" name="pass" placeholder="New password" class="form-control" type="password">
                                                        <input type="hidden" value="<%=reval%>" name="uid">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <input onclick="recover()" class="btn btn-lg btn-primary btn-block" value="Save" type="submit">
                                                </div>
                                            </fieldset>                  
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
