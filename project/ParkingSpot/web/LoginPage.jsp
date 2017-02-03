<%@page import="login_page.LoginPage" %>
<%
    String check = request.getParameter("login");
    if(check == null){
        String Username = request.getParameter("Username");
        String Password = request.getParameter("Password");

        LoginPage user = new LoginPage(); 

        user.setUserName(Username);
        user.setPassword(Password);
        if(user.checkUser()){
           response.sendRedirect("MainPage.jsp?Username="+Username);
        }
        else{
            session = request.getSession(false);
            session.setAttribute("error", "Your account or password is incorrect.");
            response.sendRedirect("index.jsp");
        }
    }
    
    
%>
