<%@page import="login_page.LoginPage" %>
<%
    String Username = request.getParameter("Username");
    String Password = request.getParameter("Password");
    
    LoginPage user = new LoginPage(); 
    
    user.setUserName(Username);
    user.setPassword(Password);
    if(user.checkUser()){
       response.sendRedirect("MainPage.jsp");
    }
    else{
        response.sendRedirect("index.jsp");
    }
%>