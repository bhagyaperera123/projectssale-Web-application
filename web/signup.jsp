<%-- 
    Document   : signup
    Created on : Feb 9, 2015, 8:23:50 AM
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
        <title>Signup</title>
    </head>
    <body style="background-image: url(intro-bg.jpg);">
        <div class="site-wrapper">
            <div class="site-wrapper-inner">
                <div class="cover-container">
                    <div class="masthead clearfix">
                        <div class="inner">
                            <h1 class="masthead-brand">Projectssale.com</h1>

                            <ul class="nav masthead-nav">

                                <li class="">
                                    <a href="">Recommend List</a>
                                </li>  
                                <li>
                                    <a href="index.jsp">Login</a>
                                </li>
                                <li class="active">
                                    <a href="signup.jsp">Sign up</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <style>
                    .container label{
                        color: white;
                    }</style>
                <div class="container">
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-5"></div>
                        <div class="col-md-5" style="">
                            <div class="panel-heading">
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-xs-8 col-sm-8 col-md-12">
                                        <form id="signupform" class="form-horizontal" role="form" action="signup" method="post">

                                            <div class="form-group">
                                                <samp for="" class="col-md-2">First&nbspName </samp>
                                                <div class="col-md-10">
                                                    <input type="text" style="margin-left: 5px;" class="form-control" id="fn" name="fn" placeholder="First Name">
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <samp for="" class="col-md-2 ">Last&nbspName </samp>
                                                <div class="col-md-10">
                                                    <input type="text" style="margin-left: 5px;" class="form-control" id="ln" name="ln" placeholder="Last Name">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <samp for="" class="col-md-2">Email &nbsp</samp>
                                                <div class="col-md-10">
                                                    <input type="email" onkeyup="validate()" onkeydown="validate()" id="email" style="margin-left: 5px;"class="form-control" name="email" placeholder="Email Address">
                                                </div>
                                            </div>
<!--                                            <div class="form-group">
                                                <samp for="" class="col-md-2">User Name &nbsp</samp>
                                                <div class="col-md-10">
                                                    <input type="email" onkeyup="validate()" onkeydown="validate()" id="email" style="margin-left: 5px;"class="form-control" name="email" placeholder="Email Address">
                                                </div>
                                            </div>-->
                                            <div class="form-group">
                                                <samp class="col-md-2">User&nbspName </samp>
                                                <div class="col-md-10">
                                                    <input type="text" style="margin-left: 5px;" class="form-control" id="un" name="un" placeholder="User name">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <samp  class="col-md-2 ">Password&nbsp </samp>
                                                <div class="col-md-10">
                                                    <input type="password" style="margin-left: 5px;" class="form-control" id="ps" name="ps" placeholder="Password">
                                                </div>
                                            </div>
                                            <input type="hidden" value="new" name="user">
                                            <div class="form-group">
                                                <samp  class="col-md-5 control-label"></samp>
                                                <div class="col-md-10">
                                                    <button type="submit" class="btn btn-info">Signup</button>
                                                    <button type="button" class="btn btn-default">Close</button>
                                                </div>
                                            </div>

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
</body>
<script src="Ajax/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
</html>

