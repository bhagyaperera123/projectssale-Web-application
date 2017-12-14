<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<style>
    body {
        font-family: 'Open Sans', 'sans-serif';
        background:#f0f0f0;
    }
    .navbar-nav>li>.dropdown-menu {
        margin-top:20px;
        border-top-left-radius:4px;
        border-top-right-radius:4px;
    }
    .navbar-default .navbar-nav>li>a {
        width:200px;
        font-weight:bold;
    }
    .mega-dropdown {
        position: static !important;
        width:100%;
    }
    .mega-dropdown-menu {
        padding: 20px 0px;
        width: 100%;
        box-shadow: none;
        -webkit-box-shadow: none;
    }
    .mega-dropdown-menu:before {
        content: "";
        border-bottom: 15px solid #fff;
        border-right: 17px solid transparent;
        border-left: 17px solid transparent;
        position: absolute;
        top: -15px;
        left: 285px;
        z-index: 10;
    }
    .mega-dropdown-menu:after {
        content: "";
        border-bottom: 17px solid #ccc;
        border-right: 19px solid transparent;
        border-left: 19px solid transparent;
        position: absolute;
        top: -17px;
        left: 283px;
        z-index: 8;
    }
    .mega-dropdown-menu > li > ul {
        padding: 0;
        margin: 0;
    }
    .mega-dropdown-menu > li > ul > li {
        list-style: none;
    }
    .mega-dropdown-menu > li > ul > li > a {
        display: block;
        padding: 3px 20px;
        clear: both;
        font-weight: normal;
        line-height: 1.428571429;
        color: #999;
        white-space: normal;
    }
    .mega-dropdown-menu > li ul > li > a:hover,
    .mega-dropdown-menu > li ul > li > a:focus {
        text-decoration: none;
        color: #444;
        background-color: #f5f5f5;
    }
    .mega-dropdown-menu .dropdown-header {
        color: #428bca;
        font-size: 18px;
        font-weight:bold;
    }
    .mega-dropdown-menu form {
        margin:3px 20px;
    }
    .mega-dropdown-menu .form-group {
        margin-bottom: 3px;
    }
</style>
<%
    HttpSession ss = request.getSession();
    int type_id = Integer.parseInt(ss.getAttribute("type").toString());
%>
<div class="container" style="position: absolute; z-index: 5; width: 100%;">
    <nav class="navbar navbar-inverse">
        <div class="navbar-header">
            <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".js-navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"></a>
        </div>


        <div class="collapse navbar-collapse js-navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="dropdown mega-dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><samp>Projects <span class="glyphicon glyphicon-chevron-down"></span></samp></a>
                    <ul class="dropdown-menu mega-dropdown-menu row">
                        <li class="col-sm-3">
                            <ul>
                                <li class="dropdown-header">Web Application</li>
                                <li><a href="Recommend List.jsp?id=7">Ecommerce</a></li>
                                <li><a href="Recommend List.jsp?id=10">Social</a></li>
                                <li><a href="Recommend List.jsp?id=11">Shopping cart</a></li>
                                <li><a href="Recommend List.jsp?id=8">Cloud Application</a></li>
                                <li class="divider"></li>
                                <li class="dropdown-header">Other Web Application</li>
                                <li><a href="Recommend List.jsp?id=9">One Page web Site</a></li>
                                <li><a href="#">Web Page</a></li>
                            </ul>
                        </li>
                        <li class="col-sm-3">
                            <ul>
                                <li class="dropdown-header">Swing Application</li>
                                <li><a href="#">Inventory</a></li>
                                <li><a href="#">POS System</a></li>
                                <li><a href="#">Pharmacy System</a></li>
                                <li><a href="#">Bulk System</a></li>
                                <li><a href="#">Others</a></li>
                                <li class="divider"></li>
                                <li class="dropdown-header">Swing Application</li>
                                <li><a href="#">Other</a></li>
                            </ul>
                        </li>
                        <li class="col-sm-3">
                            <ul>
                                <li class="dropdown-header">Android Application</li>
                                <li><a href="#">Games</a></li>
                                <li><a href="#">Inventory System</a></li>
                                <li><a href="#">POS System</a></li>
                                <li class="divider"></li>
                                <li class="dropdown-header">Windows Mobile</li>
                                <li><a href="#">Coloured Headers</a></li>
                                <li><a href="#">Primary Buttons & Default</a></li>
                                <li><a href="#">Calls to action</a></li>
                            </ul>
                        </li>
                        <li class="col-sm-3">
                            <ul>
                                <li class="dropdown-header">Apple Application</li>
                                <li><a href="#">Unique Features</a></li>
                                <li><a href="#">Image Responsive</a></li>
                                <li><a href="#">Auto Carousel</a></li>
                                <li><a href="#">Newsletter Form</a></li>
                                <li><a href="#">Four columns</a></li>
                                <li class="divider"></li>
                                <li class="dropdown-header">Tops</li>
                                <li><a href="#">Good Typography</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <%
                        if (type_id == 2) {
                    %>
                    <a href="#" title="Message"  class="dropdown-toggle" data-toggle="dropdown"><samp class="glyphicon glyphicon-envelope"></samp> <b class=""></b></a>
                    <ul  style="width: 250px; margin-top: -1px;" class="dropdown-menu dropdown-alerts">
                        <li>
                            <a href="#">
                                <div>
                                    <i class="icon-upload"></i> Ishan
                                    <span class="pull-right text-muted small"> 2 Hour ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                    </ul>
                </li>
                <li><a href="#"><span style="" class="glyphicon glyphicon-flash" data-toggle="tooltip" data-placement="bottom" title="Notifycation"></span></a></li>
                <li><a href="cart.jsp"><span style="" class="glyphicon glyphicon-shopping-cart" title="Your Cart"></span></a></li>
                <%}%>
                <li><a href="Home.jsp"><span class="glyphicon glyphicon-home" title="Home"></span></a></li>
                <%  if (type_id == 2) {%>
                <%
                    HttpSession ss1 = request.getSession();
                    int uid = Integer.parseInt(ss1.getAttribute("user").toString());
                    Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                    Criteria cr = ses.createCriteria(DB.User.class);
                    cr.add(Restrictions.eq("iduser", uid));
                    DB.User u = (DB.User)cr.uniqueResult();
                    if(u != null){
                %>
                <li><a href="Add_Project.jsp"><span class="glyphicon glyphicon-plus" title="Add New Projects"><samp style="font-size: 16px;"></samp></span></a></li>
                <li><a href="User_Profile.jsp"><span class="x"><samp style=""><img src="user.png" width="20" height="20"> <%= u.getFname()+" "+u.getLname()%> </samp></span></a></li><%}%>
                                <%}%>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><samp class="glyphicon glyphicon-cog"></samp> <b class="caret"></b></a>
                    <ul class="dropdown-menu" style="margin-top:-1px;">
                        <%
                            if (type_id != 2) {
                        %>
                        <li><a href="Admin_Console.jsp">Admin Console</a></li>
                        <%}
                            if (type_id == 2) {
                        %>
                        <li><a href="Add_Job.jsp">Add Job</a></li>
                        <li><a href="My_Sales.jsp">My Sale</a></li>
                        <li><a href="My_Form.jsp">My Form</a></li>
                        <li><a href="Send_Order.jsp">purchase History</a></li>
                        <li><a href="My_History.jsp">My History</a></li>
                        <%}%>
                        <li class="divider"></li>
                        <li><a href="logout">Logout <span class="glyphicon glyphicon-log-out"></span></a></li>
                    </ul>
                </li>
            </ul>

        </div><!-- /.nav-collapse -->
    </nav>
</div>