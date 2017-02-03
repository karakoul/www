<%-- 
    Document   : ForgotPass
    Created on : Jan 5, 2016, 7:21:30 AM
    Author     : katerina
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="login_page.LoginPage" %>
<%@page import="maps.CreateSpot" %>
<%

    CreateSpot spot = new CreateSpot();
    String latlng = request.getParameter("place");
    latlng = latlng.replace("(", "");
    latlng = latlng.replace(")", "");
    List<String> lista = new ArrayList<String>(Arrays.asList(latlng.split(", ")));

    String recUser = spot.UserPayment(lista.get(0).toString(), lista.get(1).toString());
    String Username = request.getParameter("Username");
    if(!spot.Payment(Username, false)){
        session = request.getSession(false);
        session.setAttribute("error", "Your don't have enough coins for the transaction!");
        response.sendRedirect("PaySpot.jsp");
    }

    LoginPage user = new LoginPage();

    user.setUserName(recUser);
    String emailBody = "<i> Hi " + recUser + "</i><br>";
    emailBody += "<b>If you want to wait for " + Username + " and get your payment, press </b>";
    emailBody += "<font color=blue > <a href=\"http://83.212.99.202:8080/ParkingSpot/PaySpotFinal.jsp?Username=" + recUser+"&payName="+Username + "&who=1\">here</a> </font><br>";
    emailBody += "<b>else </b>";
    emailBody += "<font color=blue > <a href=\"http://83.212.99.202:8080/ParkingSpot/MainPage.jsp?Username=" + recUser+"&payName="+Username + "&who=0\">cancel</a> </font>";
    String subject = "ParkingSpot Payment";
    user.sendFixedEmail(user.getEmail(), emailBody, subject);
    spot.deleteSpot(lista.get(0).toString(), lista.get(1).toString());
    response.sendRedirect("MainPage.jsp?Username=" + Username);


%>