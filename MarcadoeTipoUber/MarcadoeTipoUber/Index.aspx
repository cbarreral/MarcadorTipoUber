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



</head>
<body>  <input id="rotation_value" type="text"  onchange="setRotation();" />
    <form id="form1" runat="server">
        <div class="container">
          
            <div class="row">
                <br />
                <br />
                <div class="col-md-4">
                    <!-- MAPA -->
                    <div id="map"></div>
                </div>
                <div class="col-md-4">
                    <p>Cordenadas del marker A</p>
                      <!--Ubicacion -->
                
                    <br />
                    <div class="form-group">
                        <br />
                       <label for="lat">Lat:</label>
                        <asp:TextBox ID="txtLatitudA" CssClass="form-control" Text="" runat="server"></asp:TextBox>
                        <label for="lon">Lon:</label>
                        <asp:TextBox ID="txtLongitudA" CssClass="form-control" Text="" runat="server"></asp:TextBox>

                    </div>
                    
                </div>
                <div class="col-md-4">
                    <p>Cordenadas del marker B</p>
                      <!--Ubicacion -->
                
                    <br />
                    <div class="form-group">
                        <br />
                       <label for="lat">Lat:</label>
                        <asp:TextBox ID="txtLatitudB" CssClass="form-control" Text="" runat="server"></asp:TextBox>
                        <label for="lon">Lon:</label>
                        <asp:TextBox ID="txtLongitudB" CssClass="form-control" Text="" runat="server"></asp:TextBox>

                    </div>
                    
                </div>
                 <div class="col-md-4">
                    <p>Distancia del punto A al punto B</p>
                      <!--Ubicacion -->
                
                    <br />
                    <div class="form-group">
                        <br />
                       <label for="lat">Distancia:</label>
                        <asp:TextBox ID="txtDistancia" CssClass="form-control" Text="" runat="server"></asp:TextBox>
                       
                    </div>
                    
                </div>
            </div>
        </div>
    </form>
        <script>  



            let map;

            let marker;
            let watchId;
            let geoLoc
            window.onload = function () {
               
                const MyLatLon = { lat: -34.397, lng: 150.644 };//Posicion como ejemplo

                map = new google.maps.Map(document.getElementById("map"), {
                    center: MyLatLon,
                    zoom: 18,
                    mapTypeID: google.maps.MapTypeId.ROADMAP,
                  
                });
                //Propiedades al mapa
                var drawingManager = new google.maps.drawing.DrawingManager({
                    drawingControlOptions: {
                        drawingModes: ['marker']
                    },
                    drawingControl: true,
                    circleOptions: {
                        fillColor: '#ffff00',
                        fillOpacity: .3,
                        strokeWeight: 5,
                        clickable: false,
                        editable: true,
                        zIndex: 1
                    }, icon: {
                        url: 'img/carro.png',
                        // This marker is 20 pixels wide by 32 pixels high.
                        size: new google.maps.Size(38, 38),
                        // The origin for this image is (0, 0).
                        origin: new google.maps.Point(0, 0),
                        // The anchor for this image is the base of the flagpole at (0, 32).
                        anchor: new google.maps.Point(0, 0)
                    },
                });
                drawingManager.setMap(map);
                var currEvent;
                marker = new google.maps.Marker({
                    position: MyLatLon,
                    map: map,
                    draggable: true,
                    animation: google.maps.Animation.DROP,
                    crossOnDrag: true,
                    visible: true,
                    animation: 0,
                    title: 'Carrito!',
                    icon: carrito,
                    clickable: false,

                });
                // marker.setPosition(MyLatLon);
                //Optener la geoposición
                getPosition();
                marker.addListener("click", toggleBounce);

                //Crear un marcador con dar click en el mapa
                google.maps.event.addListener(drawingManager, 'overlaycomplete', function (event) {
                    currEvent = event.type;
                    console.log(currEvent);

                    if (event.type == 'marker') {
                        var position2 = event.overlay.getPosition();
                        marker = {
                            center: {
                                lat: position2.lat(),
                                lng: position2.lng()
                            }
                        }
                        document.getElementById('<%=txtLatitudB.ClientID%>').value = position2.lat();
                        document.getElementById('<%=txtLongitudB.ClientID%>').value = position2.lng();
                    } else {
                        console.log("ocurre algo raro!!");
                    }



                    

                    var d = calcularDistancia($('#<% =txtLatitudA.ClientID %>').val(), $('#<% =txtLongitudA.ClientID %>').val(), $('#<% =txtLatitudB.ClientID %>').val(), $('#<% =txtLongitudB.ClientID %>').val());
                    document.getElementById('<%=txtDistancia.ClientID%>').value = d+" metros";
                });    
            }
            //Personalizar icono
            var carrito = {/*
                url: 'img/carTopView.png',
                    // This marker is 20 pixels wide by 32 pixels high.
                    size: new google.maps.Size(50, 50),
                        // The origin for this image is (0, 0).
                origin: new google.maps.Point(0, 0),
                            // The anchor for this image is the base of the flagpole at (0, 32).
                anchor: new google.maps.Point(0, 0),*/
                path: 'M -1.1500216e-4,0 C 0.281648,0 0.547084,-0.13447 0.718801,-0.36481 l 17.093151,-22.89064 c 0.125766,-0.16746 0.188044,-0.36854 0.188044,-0.56899 0,-0.19797 -0.06107,-0.39532 -0.182601,-0.56215 -0.245484,-0.33555 -0.678404,-0.46068 -1.057513,-0.30629 l -11.318243,4.60303 0,-26.97635 C 5.441639,-47.58228 5.035926,-48 4.534681,-48 l -9.06959,0 c -0.501246,0 -0.906959,0.41772 -0.906959,0.9338 l 0,26.97635 -11.317637,-4.60303 c -0.379109,-0.15439 -0.812031,-0.0286 -1.057515,0.30629 -0.245483,0.33492 -0.244275,0.79809 0.0055,1.13114 L -0.718973,-0.36481 C -0.547255,-0.13509 -0.281818,0 -5.7002158e-5,0 Z',
                strokeColor: 'black',
                strokeOpacity: 1,
                strokeWeight: 1,
                fillColor: '#fefe99',
                fillOpacity: 1,
                rotation: 0,
                scale: 1.0
            }

            //Rotar Marcador
            function setRotation() {
                var heading = parseInt(document.getElementById('rotation_value').value);
                if (isNaN(heading)) heading = 0;
                if (heading < 0) heading = 359;
                if (heading > 359) heading = 0;
                carrito.rotation = heading;
                marker.setOptions({ icon: carrito });
                document.getElementById('rotation_value').value = heading;
                if (window.DeviceOrientationEvent) {
                    window.addEventListener('deviceorientation', deviceOrientationHandler, false);
                    document.getElementById("doeSupported").innerText = "Supported!";
                    alert("soportado");
                } else {
                    alert("no soportado");
                }
            }
            //Animar marcador
            function toggleBounce() {
                if (marker.getAnimation() !== null) {
                    marker.setAnimation(null);
                } else {
                    marker.setAnimation(google.maps.Animation.BOUNCE);
                }
            }
            //Obtener Ubicacion actual
            function getPosition() {
                if (navigator.geolocation) {
                    // var options = { enableHighAccuracy: true, timeout: 50000,  maximumAge: 0};
                    var options = { timeout: 60000 };

                    geoLoc = navigator.geolocation;
                    watchId = geoLoc.watchPosition(showLocationOnMap, errorHandler, options);

                } else {
                    alert("Ocurrio un error con el explorador");
                }

            }
            //Mostrar ubicacion actual
            function showLocationOnMap(position) {
                var latitud = position.coords.latitude;
                var longitud = position.coords.longitude;
                console.log("lat: " + latitud + "  lon: " + longitud);
                //enviar datos de Js a VB
                document.getElementById('<%=txtLatitudA.ClientID%>').value = latitud;
                document.getElementById('<%=txtLongitudA.ClientID%>').value = longitud;

                const MyLatLon = { lat: latitud, lng: longitud };
                marker.setPosition(MyLatLon);
                map.setCenter(MyLatLon)
            }

            function errorHandler(err) {
                if (err.code == 1) {
                    alert("Error, acceso denegado");
                } else if (err.code == 2) {
                    alert("Error No se encuentra la posicion")
                }
                console.warn('ERROR(' + err.code + '): ' + err.message);
            }

            //Calcular Distancia
            var calcularDistancia = function (lat1, lng1, lat2, lng2) {
                var R = 6371;
                var dLat = deg2rad(lat2 - lat1);
                var dLng = deg2rad(lng1 - lng2);

                var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.sin(dLng / 2) * Math.sin(dLng / 2);

                var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
                var d = R * c;

                var total = d * 1000;
                return total;
            }
            function deg2rad(n) { return n * (Math.PI / 180) }

        </script>
</body>
</html>
