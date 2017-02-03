<%-- 
    Document   : PaySpotFinal
    Created on : Feb 2, 2017, 7:48:40 PM
    Author     : katerina
--%>


<%@page import="maps.CreateSpot"%>
<%@page import="login_page.LoginPage"%>
<%
    String Username = request.getParameter("Username");
    LoginPage user = new LoginPage();

    user.setUserName(Username);
    if (request.getParameter("who").equals("0")) {
        //prepei na stalthei email
        CreateSpot spot = new CreateSpot();
        spot.Payment(Username, true);
        String emailBody = "<i> Hi " + Username + "</i><br>";
        emailBody += "<b>The other driver unfortunately will not waiting for you! Press  </b>";
        emailBody += "<font color=blue > <a href=\"http://http://83.212.99.202:8080/ParkingSpot/MainPage.jsp?Username=" + Username + "&who=2\">here</a> </font>";
        emailBody += "<b>to go back to main menu. </b><br>";
        String subject = "ParkingSpot Payment";
        user.sendFixedEmail(user.getEmail(), emailBody, subject);
        response.sendRedirect("MainPage.jsp?Username=" + request.getParameter("recUser"));

    } else if (request.getParameter("who").equals("1")) {
        String emailBody = "<i> Hi " + Username + "</i><br>";
        emailBody += "<b>The other driver will be waiting for you at the spot! When you see him press  </b>";
        emailBody += "<font color=blue > <a href=\"http://http://83.212.99.202:8080/ParkingSpot/PaySpotFinal.jsp?Username=" + Username + "&recUser=" + request.getParameter("recUser")+"&who=2\">here</a> </font><br>";
        String subject = "ParkingSpot Payment";
        user.sendFixedEmail(user.getEmail(), emailBody, subject);
        response.sendRedirect("MainPage.jsp?Username=" + request.getParameter("recUser"));
    } else {
        CreateSpot spot = new CreateSpot();
        spot.Payment(request.getParameter("recUser"), true);
        response.sendRedirect("MainPage.jsp?Username=" + Username);
    }
//        
//    } else {
    //the transaction went ok go to mainpage


%>