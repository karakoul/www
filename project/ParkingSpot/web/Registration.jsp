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
    if(user.checkUsername(Username)){
        session = request.getSession(false);
        session.setAttribute("error", "This username already exists, please try again.");
        response.sendRedirect("Reg.jsp");
    }
    else if(!user.isEmail(email)){
        session = request.getSession(false);
        session.setAttribute("error", "This is not a valid email, please try again.");
        response.sendRedirect("Reg.jsp");
    }
    else if(!Password.equals(PasswordCheck)){
        session = request.getSession(false);
        session.setAttribute("error", "Wrong Password");
        response.sendRedirect("Reg.jsp");
    }
    else if(!user.checkPassword(Password)){
        session = request.getSession(false);
        session.setAttribute("error", "Password must contain minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character.");
        response.sendRedirect("Reg.jsp");
    }
    else{
        user.setUsername(Username);
        user.setPassword(Password);
        user.setEmail(email);
        user.setLastname(Lastname);
        user.setName(Name);
        user.setPhone(Phone);
        if(user.Registration()){
            response.sendRedirect("MainPage.jsp");
        } else{
            session = request.getSession(false);
            session.setAttribute("error", "An error occured. Please try again.");
            response.sendRedirect("Reg.jsp");
        }
    }
%>
