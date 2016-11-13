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
    if(user.getEmail() == ""){
       response.sendRedirect("ForgotPassword.jsp");
    }
    else{
        session = request.getSession(false);
        session.setAttribute("error", "Your account or password is incorrect.");
        response.sendRedirect("index.jsp");
    }
%>