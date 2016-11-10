<%-- 
    Document   : Registration
    Created on : Nov 10, 2016, 5:50:20 AM
    Author     : katerina
--%>

<%@page import="login_page.Register" %>
<%
    String Username = request.getParameter("Username");
    String Password = request.getParameter("Password");
    String PasswordCheck = request.getParameter("PasswordCheck");
    String email = request.getParameter("email");
    String Name = request.getParameter("Name");
    String Lastname = request.getParameter("Lastname");
    String Phone = request.getParameter("Phone");
    
    Register user = new Register(); 
    if(Password!=PasswordCheck){
        user.checkPassword();
        response.sendRedirect("Reg.jsp");
    }else{
        user.setUsername(Username);
        user.setPassword(Password);
        user.setEmail(email);
        user.setLastname(Lastname);
        user.setName(Name);
        user.setPhone(Phone);
        if(user.Registration()){
           response.sendRedirect("MainPage.jsp");
        } else{
           response.sendRedirect("Reg.jsp");
        }
    }
%>