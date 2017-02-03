<%@page import="java.util.Map"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="maps.CreateSpot" %>
<%
    
    String Username = request.getParameter("Username");
    String payName = request.getParameter("Username");
    if(payName!= null){
       CreateSpot spot = new CreateSpot();
       spot.Payment(payName, true);
    }

    String place = request.getParameter("place");
    if(!Username.equals("null")&& Username.length()>0){
        response.sendRedirect("test.jsp?place=" + place + "&Username=" + Username);
    }
    else {
        response.sendRedirect("test.jsp?place=" + place);
    }


%>
