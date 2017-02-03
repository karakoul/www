
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="maps.CreateSpot" %>
<html>
    <head>
        <!--<form action="test2.jsp">-->

        <link rel="stylesheet" href="GoogleMaps.css" type="text/css"/>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <title>Google Maps </title>
        <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&h1=en"></script>

        <%
            CreateSpot spot = new CreateSpot();
            String results = spot.getSpots();
            List<String> lista = new ArrayList<String>(Arrays.asList(results.split("/")));

//            String Username = request.getParameter("Username");
//            session.setAttribute("Username",Username);
            

        %>

        
        <script language="JavaScript">
            var geocoder;
            var map;
            var pameter = decodeURIComponent(getAllUrlParams().place);
            var address = pameter;
            var Username;

            function setMarker() {
                var url = window.location.search.substring(1);
                var len = url.length;
                var n = url.indexOf("Username");
                if(n===-1){
                    Username = null;
                }
                else {
                    Username = url.substring(n+"Username=".length);
                }
                
                var jsArray = [<% for (int i = 0; i < lista.size(); i++) {%>"<%= lista.get(i)%>"<%= i + 1 < lista.size() ? "," : ""%><% }%>];

                var len = <%=lista.size()%>;
                var cur = 0;
                for (cur = 0; cur < len; cur + 1) {
                    var latlng = new google.maps.LatLng(jsArray[cur], jsArray[cur + 1]);
                    var addr = jsArray[cur + 2];

                    var marker = new google.maps.Marker({
                        position: latlng,
                        map: map,
                        title: address
                    });
                    
                    google.maps.event.addListener(marker, 'click', function () {
                        var latlng1 = new google.maps.LatLng(this.getPosition().lat(), this.getPosition().lng());
                        var username = Username;

                        var r = confirm("Do you want to pay for this spot?");
                        if (r === true) {
                            
                            if (username==null) {
                                alert("if you want this option you have to login first!");
                            } else {
                                window.location = "PaySpot.jsp?place=" + latlng1+"&Username="+Username;
                            }
                        }


//                        event.latLng
                    });
                    cur = cur + 2;
                }

            }

            function getAllUrlParams(url) {

                // get query string from url (optional) or window
                var queryString = url ? url.split('?')[1] : window.location.search.slice(1);
                // we'll store the parameters here
                var obj = {};
                // if query string exists
                if (queryString) {

                    // stuff after # is not part of query string, so get rid of it
                    queryString = queryString.split('#')[0];
                    // split our query string into its component parts
                    var arr = queryString.split('&');
                    for (var i = 0; i < arr.length; i++) {
                        // separate the keys and the values
                        var a = arr[i].split('=');
                        // in case params look like: list[]=thing1&list[]=thing2
                        var paramNum = undefined;
                        var paramName = a[0].replace(/\[\d*\]/, function (v) {
                            paramNum = v.slice(1, -1);
                            return '';
                        });
                        // set parameter value (use 'true' if empty)
                        var paramValue = typeof (a[1]) === 'undefined' ? true : a[1];
                        // (optional) keep case consistent
                        paramName = paramName.toLowerCase();
                        paramValue = paramValue.toLowerCase();
                        // if parameter name already exists
                        if (obj[paramName]) {
                            // convert value to array (if still string)
                            if (typeof obj[paramName] === 'string') {
                                obj[paramName] = [obj[paramName]];
                            }
                            // if no array index number specified...
                            if (typeof paramNum === 'undefined') {
                                // put the value on the end of the array
                                obj[paramName].push(paramValue);
                            }
                            // if array index number specified...
                            else {
                                // put the value at that index number
                                obj[paramName][paramNum] = paramValue;
                            }
                        }
                        // if param name doesn't exist yet, set it
                        else {
                            obj[paramName] = paramValue;
                        }
                    }
                }

                return obj;
            }

            function initialize() {

                geocoder = new google.maps.Geocoder();
                var latlng = new google.maps.LatLng(-34.397, 150.644);
                var myOptions = {
                    zoom: 20,
                    center: latlng,
                    disableDoubleClickZoom: true,
//                    mapTypeControl: true,
//                    mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
//                   
                    navigationControl: true,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };

                var latlngbounds = new google.maps.LatLngBounds();
                map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);


                map.fitBounds(latlngbounds);
                if (geocoder) {
                    geocoder.geocode({'address': address}, function (results, status) {
                        if (status === google.maps.GeocoderStatus.OK) {
                            if (status !== google.maps.GeocoderStatus.ZERO_RESULTS) {
                                map.setCenter(results[0].geometry.location);

                            } else {
                                alert("No results found");
                            }
                        } else {
                            alert("Geocode was not successful for the following reason: " + status);
                        }
                    });
                }

                setMarker();
                marker = new google.maps.Marker({draggable: true}),
                        infowindow = new google.maps.InfoWindow({disableAutoPan: true}),
                        form = '<div id="form_canvasform">' +
                        '<form method="POST" name="form_canvas" action="test2.jsp">' +
                        '<input id="address" name="address"  value=""><br/>' +
                        '<input type="hidden" name="newlat" value="">' +
                        '<input type="hidden" name="newlon" value="">' +
                        '<input type="hidden" name="Username" value="">' +
                        '<input type="checkbox" name="payment" value="payment" checked> Do you want to wait for 5 minutes and 3 coins<br>' +
                        '<input type="submit"  value="Set Spot!">' +
                        '</form>' +
                        '</div>';
                node = document.createElement('div'),
                        content;

                node.innerHTML = form;
                content = node.firstChild;
                infowindow.setContent(content);

                google.maps.event.addListener(map, 'dblclick', function (event) {
                    marker.setOptions({position: event.latLng, map: map});
                    infowindow.open(map, marker);
                });
                google.maps.event.addListener(marker, 'click', function (event) {
                    marker.setPosition(event.latLng);
                    infowindow.open(map, marker);
                });

                google.maps.event.addListener(marker, 'position_changed', function () {
                    getReverseGeocodingData(this.getPosition().lat(), this.getPosition().lng());
                    content.querySelector('input[name="newlat"]').value = this.getPosition().lat();
                    content.querySelector('input[name="newlon"]').value = this.getPosition().lng();
                    content.querySelector('input[name="Username"]').value = Username;
                    if (infowindow.getMap()) {
                        infowindow.open(map, marker);
                    }
                });
//                google.maps.event.addListener(map, 'click', function (event) {
//                    addMarker(event.latLng, map);
//                });
            }
            function placeMarker(location) {
                if (marker) {
                    marker.setPosition(location);
                } else {
                    var form = '<div id="form_canvasform">' +
                            '<form method="POST"  name="form_canvas">' +
                            '<div style="display:none;">' +
                            '<input id="csrf_token" name="csrf_token" type="hidden" value="foo">' +
                            '<input id="latitude" name="latitude" type="hidden" value="">' +
                            '<input id="longitude" name="longitude" type="hidden" value=""></div>' +
                            '<label for="link">link</label> <input id="link" name="link" type="text" value="">' +
                            '<input type="submit" value="Go!">' +
                            '</form>' +
                            '</div>';
                    infowindow = new google.maps.InfoWindow({
                        content: form
                    });
                    marker = new google.maps.Marker({
                        position: location,
                        map: map,
                        draggable: true
                    });
                    infowindow.open(map, marker);
                    marker.addListener('click', function () {
                        infowindow.open(map, marker);
                    });
                }
                console.log("Latitude: " + location.lat());
                console.log("Longitude: " + location.lng());
                console.log(form);
                document.getElementById('latitude').value = location.lat();
                document.getElementById('longitude').value = location.lng();
            }
            function getReverseGeocodingData(lat, lng) {

                var latlng = new google.maps.LatLng(lat, lng);
                // This is making the Geocode request
                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({'latLng': latlng}, function (results, status) {
                    if (status !== google.maps.GeocoderStatus.OK) {
                        alert(status);
                    }
                    // This is checking to see if the Geoeode Status is OK before proceeding
                    if (status === google.maps.GeocoderStatus.OK) {
                        console.log(results);
                        content.querySelector('input[name="address"]').value = (results[0].formatted_address);
                    }
                });
            }


        </script>
        <script  defer
                 src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap">
        </script>
        <!--</form>>-->
    </head>
    <body style="margin:0px; padding:0px;" onload="initialize()">
        <div id="map_canvas" style="width:95%; height:96%"></div>
        <div id="mySidenav" class="sidenav">
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
            <a href="index.jsp">LogIn</a>
            <a href="Reg.jsp">SignIn</a>
            <a href="MainPage.jsp">StartPage</a>
            <a href="https://parkingspotsite.wordpress.com/">About</a>
        </div>
        <span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; open</span>
        <script>
            function openNav() {
                document.getElementById("mySidenav").style.width = "250px";
            }

            function closeNav() {
                document.getElementById("mySidenav").style.width = "0";
            }
        </script>
    </body>
</html>