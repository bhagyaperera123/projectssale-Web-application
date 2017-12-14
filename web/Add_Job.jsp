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
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">

        <link type="text/css" rel="stylesheet" href="tagmanager/tagmanager.css">
        <script type="text/javascript" src="tagmanager/jquery.min.js"></script>
        <script type="text/javascript" src="tagmanager/tagmanager.js"></script>
    </head>
    <body>

        <%@include file="nav.jsp" %>
        <br/>
        <br/>
        <br/>
        <br/>
        <h1 style="padding-left: 100px;">Create a new Job</h1>
    <center><div style="width: 90%; background-color: #f6f6f6;">
            <div class="container">
                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-6">
                        <br/>
                        <br/>
                        <br/>
                        <form class="form-horizontal" action="add_job" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">Job Title</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="title" style="" placeholder="I will">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">Price</label>
                                <div class="col-sm-10">
                                    <%
                                        Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                    %>
                                    <select name="price" class="form-control">
                                        <%
                                            Criteria cr121 = ses.createCriteria(DB.JobPriceList.class);
                                            List<DB.JobPriceList> l121 = cr121.list();
                                            for (DB.JobPriceList job : l121) {
                                                //if (job.getStatus() == 1) {
                                        %>
                                        <option value="<%=job.getIdjobPriceList()%>"><%=job.getPrice()%></option>
                                        <%//}
                                            }%>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">Category</label>
                                <div class="col-sm-5">
                                    <select name="category" class="form-control">
                                        <%
                                            Criteria cr1 = ses.createCriteria(DB.JobCategory.class);
                                            List<DB.JobCategory> l1 = cr1.list();
                                            for (DB.JobCategory job : l1) {
                                                if (job.getStatus() == 1) {
                                        %>
                                        <option value="<%=job.getIdjobType()%>"><%=job.getCategoryName()%></option>
                                        <%}
                                            }%>
                                    </select>
                                </div>
                            </div>
                            <style>
                                .tagmanagerTag{
                                    height: 34px;
                                    border-color: #00cccc;
                                    background-color: #ccffff;
                                }
                            </style>
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">DESCRIPTION &nbsp;</label>
                                <div class="col-sm-10">
                                    <textarea name="description" class="form-control" style="height: 280px;"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">TAGS</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="tags"placeholder="Add Tags"  id="tagmanager">
                                    (Max 10)
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">Display Photo</label>
                                <div class="col-sm-10">
                                    <input class="form-control" type="file" name="dphoto">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">DURATION</label>
                                <div class="col-sm-3">
                                    <select name="dura" class="form-control">
                                        <%
                                            Criteria cr = ses.createCriteria(DB.JobDuration.class);
                                            List<DB.JobDuration> l = cr.list();
                                            for (DB.JobDuration du : l) {
                                        %>
                                        <option value="<%=du.getIdjobDuration()%>"><%=du.getTime()%></option>
                                        <%}%>
                                    </select>
                                    To deliver
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">INSTRUCTIONS FOR BUYER</label>
                                <div class="col-sm-8">
                                    <textarea name="INSTRUCTIONS_FOR_BUYER" class="form-control" style="height: 100px;" placeholder="Add a new requirement">

                                    </textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <button type="submit" class="btn btn-success">SAVE & CONTINUE</button>
                                </div>
                            </div>
                        </form>
                        <br/>
                        <br/>
                    </div>
                </div>
            </div>
            <script>
                $('#tagmanager').tagmanager({
                    strategy: 'array',
                    tagFieldName: 'tags[]',
                    ajaxCreate: 'http://localhost/tag/create',
                    ajaxRemove: 'http://localhost/tag/remove',
                    initialCap: true,
                    backspaceChars: [ 8 ],
                    delimiterChars: [ 13, 44, 188 ],
                    createHandler: function(tagManager, tag, isImport) {
                        return;
                    },
                    removeHandler: function(tagManager, tag, isEmpty) {
                        return true;
                    },
                    createElementHandler: function(tagManager, tagElement, isImport) {
                        tagManager.$element.before(tagElement);
                    },
                    validateHandler: function(tagManager, tag, isImport) {
                        return tag;
                    }
                });
            </script>
            <%@include file="footer.jsp" %>

            <%} else {
                    response.sendRedirect("index.jsp");
                }%>