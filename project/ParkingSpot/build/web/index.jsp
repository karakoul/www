<%-- 
    Document   : index
    Created on : Oct 20, 2016, 7:06:34 PM
    Author     : katerina
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="login_page.ActiveListener" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Parking Spot</title>
        <link rel="shortcut icon" href="maps_background.jpg">
        <link rel="stylesheet" href="style_welcome.css" type="text/css"/>
           
    </head>
    <body>
        <h1> Parking Spot</h1>
        <h2>Active Sessions = <%= ActiveListener.getTotalActiveSession() %>
    </body>
</html>
