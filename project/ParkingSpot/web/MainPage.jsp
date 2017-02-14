<%-- 
    Document   : MainPage
    Created on : Nov 10, 2016, 5:40:27 AM
    Author     : katerina
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="MainPage.css" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Parking Spot</title>
    </head>
    <body>
        <h1>Parking Spot</h1>
        <form method="post" action="StartPage.jsp">
            <div class="search">
                <div class="form-group ">
                    <input id="autocomplete" type="text" onFocus="geolocate()" name="place" class="form-control" placeholder="                 Αναζητηση στους χαρτες Google" >
                    <input type="hidden" name="Username" value=<%=session.getAttribute("Username")%>>
                    <input type="hidden" name="payName" value=<%=request.getParameter("payName")%>>
                    
                    <i class="fa fa-user"></i>
                </div> 
            </div>
            <div class="spot-btn">
                <button type="submit" class="find-btn" >Google Maps</button>
                <!--<a type="submit" class="find-btn" href>Tag Spot</a>-->
                <!--<a type="submit" class="find-btn" href="index.jsp">Find Spot</a>-->
            </div>
            <div class="sign-btn">
                <a class="log-btn" href="login">Log in/Sing up</a>
            </div> 
<!--            <div class="about-btn">
                <a type="submit" class="ab-btn" href="index.jsp">About</a>
            </div> -->
            <div class="popup" onclick="myFunction()">About
                <span class="popuptext" id="myPopup">Type your region or address and then click "Google Maps" if you want to tag a free parking spot on the map, or  to find and empty parking spot</span>
            </div>
            <script>
            // When the user clicks on div, open the popup
                function myFunction() {
                    var popup = document.getElementById('myPopup');
                    popup.classList.toggle('show');
                }
            </script>
            <script>

      var placeSearch, autocomplete;
      
      function initAutocomplete() {
        // Create the autocomplete object, restricting the search to geographical
        // location types.
        autocomplete = new google.maps.places.Autocomplete(
            /** @type {!HTMLInputElement} */(document.getElementById('autocomplete')),
            {types: ['geocode']});

        // When the user selects an address from the dropdown, populate the address
        // fields in the form.
        autocomplete.addListener('place_changed', fillInAddress);
      }


      // Bias the autocomplete object to the user's geographical location,
      // as supplied by the browser's 'navigator.geolocation' object.
      function geolocate() {
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
            var geolocation = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };
            var circle = new google.maps.Circle({
              center: geolocation,
              radius: position.coords.accuracy
            });
            autocomplete.setBounds(circle.getBounds());
          });
        }
      }
      
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places&callback=initAutocomplete"
        async defer></script>
                
            </div>
        </form>
    </body>
</html>
