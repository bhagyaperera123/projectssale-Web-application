<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<nav style="position: fixed; z-index: 20;" class="navbar navbar-inverse sidebar" role="navigation">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-sidebar-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <%
                HttpSession ss1 = request.getSession();
                int uid1 = Integer.parseInt(ss1.getAttribute("user").toString());
                Session ses11 = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Criteria cr11 = ses11.createCriteria(DB.User.class);
                cr11.add(Restrictions.eq("iduser", uid1));
                DB.User u1 = (DB.User) cr11.uniqueResult();
                if (u1 != null) {
            %>
            <img src="user.png" width="50" class="im" height="50"><a class="navbar-brand" href="#"><%= u1.getFname()+" "+u1.getLname() %></a>
            <%}%>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-sidebar-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="Admin_Console.jsp">Home<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-home"></span></a></li>
                <li ><a href="Admin_Profie.jsp">Profile<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-user"></span></a></li>
                <!--<li ><a href="#">Messages<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></span></a></li>-->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Manage Users <span class="caret"></span><span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-users"></span></a>
                    <ul class="dropdown-menu forAnimate" role="menu">
                        <li><a href="Create_Admin_Account.jsp">Create New Account</a></li>
                        <li><a href="view_users.jsp">View All User</a></li>
                        <li><a href="Add_User_Role.jsp">Manage User Role</a></li>
                        <li><a href="View_Login_History.jsp">User Login History</a></li>
                        <li><a href="Super_Admin.jsp">Super Admin</a></li>
                        <li><a href="View_Admin.jsp">View Admin</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Manage Projects <span class="caret"></span><span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-stats"></span></a>
                    <ul class="dropdown-menu forAnimate" role="menu">
                        <li><a href="Manage_Projects.jsp">Activate Project</a></li>
                        <li><a href="View_projects.jsp">View Projects</a></li>
                        <li><a href="Deleted_Projects.jsp">Deleted Item</a></li>
                        <li><a href="#"></a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Manage Job <span class="caret"></span><span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-stats"></span></a>
                    <ul class="dropdown-menu forAnimate" role="menu">
                        <li><a href="Manage_Job.jsp">Activate Job</a></li>
                        <li><a href="View_Jobs.jsp">View Jobs</a></li>
                        <li><a href="Deleted_Job.jsp">Deleted Item</a></li>
                        <li><a href="#"></a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Payment History <span class="caret"></span><span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-stats"></span></a>
                    <ul class="dropdown-menu forAnimate" role="menu">
                        <li><a href="View_History.jsp">View History</a></li>
                        <li><a href="View_profit.jsp">profit</a></li>
                        <li><a href="#"></a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Order <span class="caret"></span><span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-stats"></span></a>
                    <ul class="dropdown-menu forAnimate" role="menu">
                        <li><a href="Order_view_Admin.jsp">View Order</a></li>
                        <li><a href="View_profit.jsp"></a></li>
                        <li><a href="#"></a></li>
                    </ul>
                </li>
                <li class=""><a href="Other_Function.jsp">Other</a></li>
                <li class=""><a href="logout">Logout<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-log-out"></span></a></li>
            </ul>
        </div>
    </div>
</nav>