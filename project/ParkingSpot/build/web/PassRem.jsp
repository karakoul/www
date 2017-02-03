<%-- 
    Document   : PassRem
    Created on : Nov 17, 2016, 10:47:03 PM
    Author     : katerina
--%>

<%@page import="login_page.LoginPage" %>
<%
    String Username = request.getParameter("Username");
    String Password = request.getParameter("Password");
    String PasswordCheck = request.getParameter("PasswordCheck");
    System.out.println(Username);
    
    LoginPage user = new LoginPage(); 
    
    if(!Password.equals(PasswordCheck)){
        session.setAttribute("error", "Please retype your Password");
        response.sendRedirect("ForgotPassword.jsp");
    }
    user.setUserName(Username);
    user.changePassword(Username,Password);
    session.setAttribute("error", "Your Password has reset succesfully!");
    response.sendRedirect("index.jsp");

%>