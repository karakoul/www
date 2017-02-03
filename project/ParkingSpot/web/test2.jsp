
<%-- 
    Document   : Registration
    Created on : Nov 10, 2016, 5:50:20 AM
    Author     : katerina
--%>

<%@page import="maps.CreateSpot" %>
<%

    String Username = request.getParameter("Username");
    
    String lat = request.getParameter("newlat");
    String lon = request.getParameter("newlon");
    String address = request.getParameter("address");
    String payment = request.getParameter("payment");
    boolean check = false;
    CreateSpot spot = new CreateSpot(); 
    System.out.println("!payment = " + payment + " Username = " + Username);
    
    if(Username.equals("null") || Username.length()==0) {
        if(spot.addSpot(lat,lon, address)){
            response.sendRedirect("MainPage.jsp");
        } 
        else{
            session = request.getSession(false);
            session.setAttribute("error", "An error occured. Please try again.");
            response.sendRedirect("test.jsp");
        }
    }
    else{
//        na prosthesw username sto link

        if(payment.equals("payment")){
            check = true;
        }
        if(spot.addSpotP(Username,lat,lon, address,check)){
            response.sendRedirect("MainPage.jsp?Username="+Username);
        } 
        else{
            session = request.getSession(false);
            session.setAttribute("error", "An error occured. Please try again.");
            response.sendRedirect("test.jsp?Username="+Username);
        }
    }    
%>
