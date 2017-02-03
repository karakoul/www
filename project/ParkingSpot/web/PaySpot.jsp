<%-- 
    Document   : index
    Created on : Oct 20, 2016, 7:06:34 PM
    Author     : katerina
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<%@page import="maps.CreateSpot" %>
<html>
    <input name="check" type="hidden" value="0"/>
    <head>
        <link rel="stylesheet" href="PaySpot.css" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <form method="post" action="Payment.jsp">
            <%
                CreateSpot spot = new CreateSpot();
                String latlng = request.getParameter("place");
                latlng = latlng.replace("(", "");
                latlng = latlng.replace(")", "");
                List<String> lista = new ArrayList<String>(Arrays.asList(latlng.split(", ")));

                if (!spot.ifPayment(lista.get(0).toString(), lista.get(1).toString())) {
                    response.sendRedirect("MainPage.jsp?Username="+request.getParameter("USername"));
                }
            %>
            <script>
                var url = window.location.search.substring(1);
                var len = url.length;
                var n = url.indexOf("Username");
                var placePos = url.indexOf("place");
                var place;
                var Username;
                var place;
                if (n === -1) {
                    Username = null;
                    place = url.substring(placePos + "place=".length);
                } else {
                    Username = url.substring(n + "Username=".length);
                    place = url.substring(placePos + "place=".length,n);
                }
            </script>
            <div class="sub">
                <h1>Are you sure you want to reserve this spot for 3 coins?</h1>
                <h3>${sessionScope['error']}</h3>
                <%session.removeAttribute("error");%>
                <div class="form-group ">
                    <button type="submit" class="find-btn" >I want to continue with the payment</button>
                    <a href="MainPage.jsp" class="cancel-btn">Cancel</a>
                    <input type="hidden" name="Username" value="<%=request.getParameter("Username")%>">
                    <input type="hidden" name="place" value="<%=request.getParameter("place")%>">
                </div>
            </div>



        </form>>

    </body>
</html>

