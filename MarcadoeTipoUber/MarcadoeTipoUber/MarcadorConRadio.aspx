<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MarcadorConRadio.aspx.vb" Inherits="MarcadoeTipoUber.MarcadorConRadio" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <title>Poligonos</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  


    <link href="css/style.css" rel="stylesheet" />
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <!-- API_KEY Google Maps -->
    <script type="text/javascript" src='https://maps.google.com/maps/api/js?key=AIzaSyBYlFOtKiNr6qhNwSIhAZj2KkXWDwdku5k&libraries=drawing,geometry'></script>

</head>
<body>
     <br />
                <div class="form-group">
                    <div class="col-md-3">
                        <asp:Label ID="Label1" runat="server" Text="Lat:"></asp:Label>
                        <input id="txtLat" type="text" value="19.4199042" class="form-control" onchange="setCordenadas();" />
                      
                    </div>
                    <div class="col-md-3">
                        <asp:Label ID="Label2" runat="server" Text="Lng:"></asp:Label>
                        <input id="txtLng" type="text" value="-99.169275" class="form-control" onchange="setCordenadas();" />
                        
                    </div>
                    <div class="col-md-3">
                        <asp:Label ID="Label3" runat="server" Text="Radio:"></asp:Label>
                         <input id="txtRadio" type="text" value="50" class="form-control" onchange="setCordenadas();" />
                    </div>

                    
                    
                </div>
    <form id="form1" runat="server">
        <div class="container">
         
                <br />
               
            <div class="row">
                <br />
                <p>...</p>
                <div id="map"></div>
            </div>
            </div>
           
        
    </form>
     <script>
         var latitud = 20.222701572504086;
         var longitud = -99.23668426573829;

        window.onload = function () {
            //test();
          
           
            const map = new google.maps.Map(document.getElementById("map"), {
                center: { lat: latitud, lng: longitud },
                zoom: 18,
            });
            // Create marker 
            var marker = new google.maps.Marker({
                map: map,
                position: new google.maps.LatLng(20.222701572504086, -99.23668426573829),
                title: 'Some location',
                draggable: true,
            });

            // Add circle overlay and bind to marker
            var circle = new google.maps.Circle({
                map: map,
                radius: 50,    // 10 miles in metres
                fillColor: '#AA0000'
            });
            circle.bindTo('center', marker, 'position');
            const drawingManager = new google.maps.drawing.DrawingManager({
                drawingMode: google.maps.drawing.OverlayType.MARKER,
                drawingControl: true,
                drawingControlOptions: {
                    position: google.maps.ControlPosition.TOP_CENTER,
                    drawingModes: [
                        google.maps.drawing.OverlayType.MARKER,
                       
                    ],
                },

                circleOptions: {
                    fillColor: "#ffff00",
                    fillOpacity: .3,
                    strokeWeight: 5,
                    clickable: false,
                    editable: true,
                    zIndex: 1,
                    draggable: true,
                },
                polygonOptions: {
                    fillColor: "#f92672",
                    fillOpacity: .3,
                    strokeWeight: 5,
                    clickable: false,
                    editable: true,
                    zIndex: 1,
                    draggable: true,
                },
                markerOptions: {
                    clickable: true,
                    editable: true,
                    draggable: true,
                    title: 'Soy un nuevo marcador',
                }
            });
            drawingManager.setMap(map);
            var currEvent;
            var position;
            google.maps.event.addListener(drawingManager, 'overlaycomplete', function (event) {
                currEvent = event.type;
                console.log(currEvent);


                //***********CIRCLE
                /* if (event.type == 'circle') {
                     var center = event.overlay.getCenter();
                     circle = {
                         radius: event.overlay.getRadius(),
                         center: {
                             lat: center.lat(),
                             lng: center.lng()
                         },
                         overlay: event.overlay
 
                     };
                     console.log("Radio: " + circle.radius);
                     console.log("Centro lat: " + circle.center.lat);
                     console.log("Centro lng: " + circle.center.lng);
                     
                     //***********MARKER
                 } else*/
                if (event.type == 'marker') {
                    position = event.overlay.getPosition();
                    marker = {
                        center: {
                            lat: position.lat(),
                            lng: position.lng()
                        }

                    }



                   
                   /* var isIRadious = google.maps.geometry.spherical.computeDistanceBetween(
                        position, circle.overlay.getCenter()) <= circle.radius;

                    if (isIRadious == true) {
                        console.log("lat:" + position.lat());
                        console.log("lng:" + position.lng());
                        var i = 1; //contador para asignar id al boton que borrara la fila
                        var fila = '<tr id="row' + i + '"><td>' + position.lat() + '</td><td>' + position.lng() + '</td></tr>';
                       
                       
                    } else {
                        console.log("fuera de alcance");
                    }*/
                } else {
                    console.log("ocurre algo raro!!");
                }/*
                      console.log('Geocerca: \n radius', circle.radius);
                      console.log('lat', circle.overlay.getCenter().lat());
                      console.log('lng', circle.overlay.getCenter().lng());
                      */
                console.log("Marcador: \n lat: " + marker.center.lat + "\n" + marker.center.lng);
                document.getElementById('txtLat').value = (marker.center.lat);
                document.getElementById('txtLng').value = (marker.center.lng);
                latitud = marker.center.lat;
                longitud = marker.center.lng;

            });

         }
         function setCordenadas() {
             var Lat = parseInt(document.getElementById('txtLat').value);
             var Lng = parseInt(document.getElementById('txtLng').value);
             var Radio = parseInt(document.getElementById('txtRadio').value);
             marker = {
                 center: {
                     lat: Lat,
                     lng: Lng
                 }
             },
                 circle = {
                 radius: Radio
                 }
         }

     </script>
</body>
</html>
