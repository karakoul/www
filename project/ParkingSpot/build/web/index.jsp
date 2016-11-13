<%-- 
    Document   : index
    Created on : Oct 20, 2016, 7:06:34 PM
    Author     : katerina
--%>

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
        <title>Login Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        
        <h1> Parking Spot</h1>
        <form method="post" action="LoginPage.jsp">
            <div class="login">
                
                <h2>Login or <a class="linkRegister" <a href="Reg.jsp">Sign up</a></h2>
<!--                <div class="image">
                    <img src="parking.jpeg" alt="Avatar" class="logo">
                </div>-->
                <h3>${sessionScope['error']}</h3>
                <div class="form-group ">
                    <input type="text" class="form-control" placeholder="Username" name = "Username" required>
                    
                    <i class="fa fa-user"></i>
                </div>
               
                <div class="form-group log-status">
                    <input type="password" class="form-control" placeholder="Password" name = "Password" required>
                    <i class="fa fa-lock"></i>
                </div>
                <a class="link" href="ForgotPassword.jsp">Lost your password?</a>
                <button type="submit" class="log-btn" >Log in</button>
                
                
                <div>
                    <a href="#" class="btnFacebook">
                        <span>Facebook</span>
                    </a>
	        </div>
        	<div>
                    <a href="#" class="btnUth">
                        Uth
                    </a>
	        </div>	
        	<script src="https://apis.google.com/js/platform.js" async defer></script>
                <meta name="google-signin-client_id" content="102690056425-lpfnsfj5n08p1rn01ot688nk1s36258e.apps.googleusercontent.com ">
                <div class="g-signin2" data-onsuccess="onSignIn"></div>
            </div>
        </form>
    </body>
</html>

