<%-- 
    Document   : index
    Created on : Oct 20, 2016, 7:06:34 PM
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
    <input name="check" type="hidden" value="0"/>
    <head>
        <link rel="stylesheet" href="LoginPage.css" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>

        <h1> Parking Spot</h1>
        <form method="post" action="login">
            <div class="login">

                <h2>Login or <a class="linkRegister" <a href="signup">Sign up</a></h2>

                <h3>${sessionScope['error']}</h3>
                <%session.removeAttribute("error");%>
                
                <div class="form-group ">
                    <input type="text" class="form-control" placeholder="Username" name = "Username" required>

                    <i class="fa fa-user"></i>
                </div>

                <div class="form-group log-status">
                    <input type="password" class="form-control" placeholder="Password" name = "Password" required>
                    <i class="fa fa-lock"></i>
                </div>
                <a class="link" href="forgotpassword">Lost your password?</a>
                <button type="submit" class="log-btn" >Log in</button>



                <div>
                    <a href="uth" class="btnUth"> 
                        <img src="./images/uth_logo.jpg" width = "40"/>
                    </a>
                </div>	


            </div>
        </form>
    </body>
</html>

