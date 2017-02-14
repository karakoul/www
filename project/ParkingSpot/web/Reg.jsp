<%-- 
    Document   : index
    Created on : Oct 20, 2016, 7:06:34 PM
    Author     : katerina
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="login_page.Register"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<html>
    <head>
        <link rel="stylesheet" href="Registration.css" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        
        <h1> Parking Spot</h1>
        <form method="post" action="signup" onsubmit="return check();">
            <div class="register">
                
                <h2>Sign up</h2>
<!--                <div class="image">
                    <img src="parking.jpeg" alt="Avatar" class="logo">
                </div>-->

                <h3>${sessionScope['error']}</h3>
                <%session.removeAttribute("error");%>
                <div class="form-group ">
                    <input type="text" class="form-control" placeholder="Username" name = "Username" required>
                    <i class="fa fa-user"></i>
                </div>
               
                <div class="form-group log-status">
                    <input type="text" class="form-control" placeholder="email" name = "email" required>
                    <i class="fa fa-lock"></i>
                </div>
                <div class="form-group ">
                    <input type="text" class="form-control" placeholder="Name(optional)" name = "Name" >
                    
                    <i class="fa fa-user"></i>
                </div>
                <div class="form-group ">
                    <input type="text" class="form-control" placeholder="Lastname(optional)" name = "Lastname" >
                    
                    <i class="fa fa-user"></i>
                </div>
                <div class="form-group ">
                    <input type="text" class="form-control" placeholder="Phone(optional)" name = "Phone" >
                    
                    <i class="fa fa-user"></i>
                </div>
                <div class="form-group ">
                    <input type="password" class="form-control" placeholder="Password" name = "Password" required>
                    
                    <i class="fa fa-user"></i>
                </div>
                <div class="form-group ">
                    <input type="password" class="form-control" placeholder="Please confirm your password" name = "PasswordCheck" required>
                    
                    <i class="fa fa-user"></i>
                </div>
                <button type="submit" class="log-btn" >Sign up</button>
                
            </div>
            <div id="error"></div>
        </form>
    </body>
</html>

