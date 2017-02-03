<%-- 
    Document   : ForgotPass
    Created on : Nov 13, 2016, 5:38:04 AM
    Author     : katerina
--%>

<%@page import="login_page.LoginPage" %>
<%
    String Username = request.getParameter("Username");
    
    LoginPage user = new LoginPage(); 
    
    user.setUserName(Username);
    
    user.getEmail();
    user.sendEmail(user.getEmail());
    response.sendRedirect("ForgotPassword.jsp");

%>