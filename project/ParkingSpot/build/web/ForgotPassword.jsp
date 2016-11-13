<%-- 
    Document   : ForgotPassword
    Created on : Nov 13, 2016, 5:28:46 AM
    Author     : katerina
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                
                <h2>Recover your account</h2>
                <h4>We can help you reset your password,please enter your username to send you a redirect link to your email account!</h4>
<!--                <div class="image">
                    <img src="parking.jpeg" alt="Avatar" class="logo">
                </div>-->
                <div class="form-group log-status">
                    <input type="text" class="form-control" placeholder="Username" name = "Username" required>
                    <i class="fa fa-lock"></i>
                </div>
                <button type="submit" class="log-btn" >Submit</button>
            </div>
        </form>
    </body>
</html>
