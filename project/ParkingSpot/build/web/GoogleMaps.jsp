<html>
    <head>
        <link rel="stylesheet" href="GoogleMaps.css" type="text/css"/>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <title>Google Maps JavaScript API v3 Example: Geocoding Simple</title>
        <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
        <script type="text/javascript">
            var geocoder;
            var map;
            var pameter = decodeURIComponent(getAllUrlParams().place);

            var address = pameter;
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
                    zoom: 8,
                    center: latlng,
                    mapTypeControl: true,
                    mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
                    navigationControl: true,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
                if (geocoder) {
                    geocoder.geocode({'address': address}, function (results, status) {
                        if (status === google.maps.GeocoderStatus.OK) {
                            if (status !== google.maps.GeocoderStatus.ZERO_RESULTS) {
                                map.setCenter(results[0].geometry.location);

                                var infowindow = new google.maps.InfoWindow(
                                        {content: '<b>' + address + '</b>',
                                            size: new google.maps.Size(150, 50)
                                        });

                                var marker = new google.maps.Marker({
                                    position: results[0].geometry.location,
                                    map: map,
                                    title: address
                                });
                                google.maps.event.addListener(marker, 'click', function () {
                                    infowindow.open(map, marker);
                                });

                            } else {
                                alert("No results found");
                            }
                        } else {
                            alert("Geocode was not successful for the following reason: " + status);
                        }
                    });
                }
            }
        </script>
        <script async defer
                src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap">
        </script>
    </head>
    <body style="margin:0px; padding:0px;" onload="initialize()">
        <div id="map_canvas" style="width:100%; height:100%"></div>
            <div id="mySidenav" class="sidenav">
                <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
                <a href="#">About</a>
                <a href="#">Services</a>
                <a href="#">Clients</a>
                <a href="#">Contact</a>
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