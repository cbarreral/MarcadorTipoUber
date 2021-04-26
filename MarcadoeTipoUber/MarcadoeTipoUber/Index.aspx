<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Index.aspx.vb" Inherits="MarcadoeTipoUber.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Marcador Tipo Uber</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <!-- jquery y js -->
    <link href="css/style.css" rel="stylesheet" />
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <!-- API_KEY Google Maps -->
    <script type="text/javascript" src='https://maps.google.com/maps/api/js?key=AIzaSyD_q6OLpZbcqQd_xo3rs9CW6ABxpLJOHrg&libraries=drawing,geometry'></script>


    <script>  



        let map;
        let marker;
        let id;
        let geoLoc
        window.onload = function () {
            const MyLatLon = { lat: -34.397, lng: 150.644 };
            map = new google.maps.Map(document.getElementById("map"), {
                center: MyLatLon,
                zoom: 18,

            });
            marker = new google.maps.Marker({
                position: MyLatLon,
                map: map,
                title: 'Marcador tipo uber',
                draggable: true,
                animation: google.maps.Animation.DROP,
                icon: {
                    url: 'img/carTopView.png',
                    // This marker is 20 pixels wide by 32 pixels high.
                    size: new google.maps.Size(50, 50),
                    // The origin for this image is (0, 0).
                    origin: new google.maps.Point(0, 0),
                    // The anchor for this image is the base of the flagpole at (0, 32).
                    anchor: new google.maps.Point(0, 0)
                }
            });
            // marker.setPosition(MyLatLon);
            //Optener la geoposición
            getPosition();
            marker.addListener("click", toggleBounce);

        }

        function toggleBounce() {
            if (marker.getAnimation() !== null) {
                marker.setAnimation(null);
            } else {
                marker.setAnimation(google.maps.Animation.BOUNCE);
            }
        }

        function getPosition() {
            if (navigator.geolocation) {
                var options = { timeout: 60000 };
                geoLoc = navigator.geolocation;
                id = geoLoc.watchPosition(showLocationOnMap, errorHandler, options);

            } else {
                alert("Ocurrio un error con el explorador");
            }
        }

        function showLocationOnMap(position) {
            var latitud = position.coords.latitude;
            var longitud = position.coords.longitude;
            console.log("lat: " + latitud + "  lon: " + longitud);

            const myLatLon = { lat: latitud, lng: longitud };
            marker.setPosition(myLatLon);
            map.setCenter(myLatLon)
        }

        function errorHandler(err) {
            if (err.code == 1) {
                alert("Error, acceso denegado");
            } else if (err.code == 2) {
                alert("Error No se encuentra la posicion")
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="">
                <p>Marker Tipo Uber</p>
                <div id="map"></div>

            </div>
        </div>
    </form>


</body>
</html>
