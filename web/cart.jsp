<%-- 
    Document   : Add-Project
    Created on : Feb 9, 2015, 3:25:13 PM
    Author     : Bhagya
--%>
<%
    response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0);
    HttpSession htps = request.getSession();
    if (htps.getAttribute("user") != null) {
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <title>Your Cart</title>
        <link type="text/css" rel="stylesheet" href="tagmanager/tagmanager.css">
        <script type="text/javascript" src="tagmanager/jquery.min.js"></script>
        <script type="text/javascript" src="tagmanager/tagmanager.js"></script>
        <script>
            
            var xmlhttp;   
            if(window.ActiveXObject){                    
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");                  
            }else if(window.XMLHttpRequest){                    
                xmlhttp =new XMLHttpRequest();
            } 
            function ViewCart() {
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText;  
                        document.getElementById("tb").innerHTML = te;
                    }
                }
                xmlhttp.open("POST","ViewCart",true);
                xmlhttp.send();
            }
            function removecart(proid,cartid){ 
                xmlhttp.onreadystatechange = function(){                    
                    if(xmlhttp.readyState==4 && xmlhttp.status==200){ 
                        ViewCart();
                        
                    }
                };
                xmlhttp.open("POST","RemoveCartItem",true);
                xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xmlhttp.send("pid="+proid + "&cid="+cartid);  
            }
        </script>
    </head>
    <body onload="ViewCart()">
        <%@include file="nav.jsp" %>
    <center><div style="width: 80%; background-color: #f6f6f6;">
            <div style="height: 100px;"></div>

            <div class="container">
                <div class="row">
                    <div class="col-sm-12 col-md-10 col-md-offset-1">
                        <table class="table table-hover" id="tb">

                        </table>
                    </div>
                </div>
            </div>
            <%@include file="footer.jsp" %>

            <%} else {
                    response.sendRedirect("index.jsp");
                }%>