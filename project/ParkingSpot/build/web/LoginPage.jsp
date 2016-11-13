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
        session = request.getSession(false);
        session.setAttribute("error", "Your account or password is incorrect.");
        response.sendRedirect("index.jsp");
    }
%>