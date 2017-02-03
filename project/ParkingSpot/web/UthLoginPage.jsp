<%@page import="login_page.UthLogin" %>
<%
    String Username = request.getParameter("Username");
    String Password = request.getParameter("Password");

    UthLogin user = new UthLogin();

    if (user.setUser(Username, Password) != -1) {
        response.sendRedirect("MainPage.jsp?Username="+user.getUsername());
        session.removeAttribute("error");
    } else {
        session = request.getSession(false);
        session.setAttribute("error", "Your account or password is incorrect.");
        response.sendRedirect("index.jsp");

    }
%>