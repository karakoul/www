<%-- 
    Document   : PasswordReminder
    Created on : Nov 15, 2016, 11:39:58 AM
    Author     : katerina
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<html>
    <head>
        <link rel="stylesheet" href="LoginPage.css" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Password Reset</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        
        <h1> Parking Spot</h1>
        <form method="post" action="PassRem.jsp">
            <div class="login">
                
                <h2>Reset your Password here <%= request.getParameter("Username") %> </h2>
                
                <h3>${sessionScope['error']}</h3>
<!--                <div class="image">
                    <img src="parking.jpeg" alt="Avatar" class="logo">
                </div>-->
               <input type="hidden" id="thisField" name="Username" value=<%= request.getParameter("Username") %>>
                <div class="form-group log-status">
                    <input type="password" class="form-control" placeholder="Please type your new password" name = "Password" required>
                    <i class="fa fa-lock"></i>
                </div>
                <div class="form-group log-status">
                    <input type="password" class="form-control" placeholder="Please retype your new password" name = "PasswordCheck" required>
                    <i class="fa fa-lock"></i>
                </div>
                <button type="submit" class="log-btn" >Reset</button>
            </div>
        </form>
    </body>
</html>
