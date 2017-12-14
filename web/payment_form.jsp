<%-- 
    Document   : payment_form
    Created on : Feb 27, 2015, 10:04:50 AM
    Author     : Bhagya
--%>

<%@page import="javax.ws.rs.core.Response"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Secure Payment Form</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0);

            if (request.getParameter("tot") != null & request.getParameter("qty") != null & request.getParameter("cart") != null) {

                String tot = request.getParameter("tot");
                String qty = Security.Security.decrypt(request.getParameter("qty"));
                String cart = request.getParameter("cart");
 
        %>
        <br/>
        <br/>
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <fieldset>
                        <legend>Payment Details</legend>

                        <!-- Card Holder Name -->
                        <div class="form-group">
                            <label class="col-sm-4 control-label"  for="textinput">Total Price</label>
                            <div class="col-sm-6">
                                <h5><%=tot%></h5>
                            </div>
                        </div>

                        <!-- Card Number -->
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="textinput">Quantity</label>
                            <div class="col-sm-6">
                                <h5><%=qty%></h5>
                            </div>
                        </div>
                    </fieldset>
                </div>
                <div class="col-md-4"></div>
            </div>
        </div>
        <form action="payment" method="POST" id="payment-form" class="form-horizontal">
            <div style="margin-top:  -170px; margin-left: 200px;" class="row row-centered">
                <div class="col-md-4 col-md-offset-4">
                    <div class="page-header">
                        <h2 class="gdfg">Secure Payment Form</h2>
                    </div>
                    <fieldset>
                        <legend>Card Details</legend>

                        <!-- Card Holder Name -->
                        <div class="form-group">
                            <label class="col-sm-4 control-label"  for="textinput">Card Holder's Name</label>
                            <div class="col-sm-6">
                                <input type="text" name="cardholdername" maxlength="70" placeholder="Card Holder Name" class="card-holder-name form-control">
                            </div>
                        </div>
                        <input type="hidden" name="cid" value="<%=cart%>">
                        <!-- Card Number -->
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="textinput">Card Number</label>
                            <div class="col-sm-6">
                                <input type="text" id="cardnumber" maxlength="19" placeholder="Card Number" class="card-number form-control">
                            </div>
                        </div>

                        <!-- Expiry-->
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="textinput">Card Expiry Date</label>
                            <div class="col-sm-6">
                                <div class="form-inline">
                                    <select name="select2" data-stripe="exp-month" class="card-expiry-month stripe-sensitive required form-control">
                                        <option value="01" selected="selected">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                    </select>
                                    <span> / </span>
                                    <select name="select2" data-stripe="exp-year" class="card-expiry-year stripe-sensitive required form-control">
                                        <option value="01" selected="selected">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- CVV -->
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="textinput">CVV/CVV2</label>
                            <div class="col-sm-3">
                                <input type="text" id="cvv" placeholder="CVV" maxlength="4" class="card-cvc form-control">
                            </div>
                        </div>

                        <!-- Important notice -->
                        <div class="form-group">
                            <!-- Submit -->
                            <div class="control-group">
                                <div class="controls">
                                    <center>
                                        <button class="btn btn-success" type="submit">Pay Now</button>
                                    </center>
                                </div>
                            </div>
                    </fieldset>
                </div>
            </div>

        </form>
        <%} else {
                response.sendRedirect("Home.jsp");
            }%>
    </body>
</html>