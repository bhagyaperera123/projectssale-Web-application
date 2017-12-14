<%-- 
    Document   : index
    Created on : Feb 9, 2015, 8:14:08 AM
    Author     : Bhagya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="css/Style.css">
        <script>
            history.forward();
        </script>
    </head>
    <body style="    background-image: url(intro-bg.jpg);" onload="">
        <%
            HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {
                response.sendRedirect("Home.jsp");
            }

            String alert = request.getParameter("alert");
            if (alert != null) {
        %>
        <div><%=alert%></div>
        <%}%>
        <div class="site-wrapper">
            <div class="site-wrapper-inner">
                <div class="cover-container">
                    <div class="masthead clearfix">
                        <div class="inner">
                            <h1 class="masthead-brand">Projectssale.com</h1>

                            <ul class="nav masthead-nav">  
                                <!--                                <li class="">
                                                                    <a href="">Recommend List</a>
                                                                </li>  -->
                                <li class="active">
                                    <a href="index.jsp">Login</a>
                                </li>
                                <li>
                                    <a href="signup.jsp">Sign up</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-5"></div>
                        <div class="col-md-5" style="">
                            <div class="panel-heading">
                            </div>

                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-xs-8 col-sm-8 col-md-8 login-box">
                                        <form role="form" action="login" method="post" >
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                <input type="text" class="form-control" name="unm" placeholder="Username" required autofocus />
                                            </div>
                                            <br/>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                                                <input type="password" class="form-control" name="pas"  placeholder="Password" required />
                                            </div>
                                            <div class="input-group">
                                                <input type="checkbox" value=""/><samp> Remember me</samp>
                                            </div>
                                            <p><a href="Forgot_Password.jsp"><samp>Lost your password?</samp></a></p>
                                            <button class="btn btn-success" type="submit"> <span class="glyphicon glyphicon-log-in"> </span> Login</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="Ajax/jquery.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>

