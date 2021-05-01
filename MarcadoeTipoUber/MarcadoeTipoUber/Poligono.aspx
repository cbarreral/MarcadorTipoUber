<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Poligono.aspx.vb" Inherits="MarcadoeTipoUber.Poligono" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Poligonos</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <!-- jquery y js -->
    <!--Complementos de plugin -->
    <script src="js/jquery.gmap.js"></script>
    <script src="js/locationpicker.jquery.js"></script>

    <link href="css/style.css" rel="stylesheet" />
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <!-- API_KEY Google Maps -->
    <script type="text/javascript" src='https://maps.google.com/maps/api/js?key=AIzaSyBYlFOtKiNr6qhNwSIhAZj2KkXWDwdku5k&libraries=drawing,geometry'></script>

</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <br />
                <br />
                <div class="col-md-9">
                    <!-- MAPA -->
                    <div id="map"></div>
                </div>
                <div class="col-md-3">
                    <p>Elementos en la Tabla:</p>
                    <div id="adicionados"></div>

                    <table id="mytable" class="table table-bordered table-hover ">
                        <tr>
                            <th>Latitud</th>
                            <th>Longitud</th>

                        </tr>
                    </table>

                </div>
            </div>
        </div>
    </form>
    <script>

        window.onload = function () {
            //test();
            const map = new google.maps.Map(document.getElementById("map"), {
                center: { lat: -34.397, lng: 150.644 },
                zoom: 8,
            });
            const drawingManager = new google.maps.drawing.DrawingManager({
                drawingMode: google.maps.drawing.OverlayType.MARKER,
                drawingControl: true,
                drawingControlOptions: {
                    position: google.maps.ControlPosition.TOP_CENTER,
                    drawingModes: [
                        google.maps.drawing.OverlayType.MARKER,
                        google.maps.drawing.OverlayType.CIRCLE,
                        google.maps.drawing.OverlayType.POLYGON,
                        google.maps.drawing.OverlayType.POLYLINE,
                        google.maps.drawing.OverlayType.RECTANGLE,
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
            });
            drawingManager.setMap(map);
            var currEvent;
               var pol;
                var miPoligono;
                var coordinatesArray;
            google.maps.event.addListener(drawingManager, 'overlaycomplete', function (event) {
                currEvent = event.type;
                console.log(currEvent);
             

                //***********CIRCLE
                if (event.type == 'circle') {
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





                    //***********POLIGONO
                } else if (event.type == 'polygon') {
                   pol = event.overlay.getPath();
                     miPoligono = pol.getLength();

                    // dibuV(coordinatesArray);
                   /* var resultPath = google.maps.geometry.poly.containsLocation(
                        coordinatesArray,
                       console.log("reltPaht: " + resultPath);
                    
                    );*/


                    



                    //***********MARKER
                } else if (event.type == 'marker') {
                    var position = event.overlay.getPosition();
                    marker = {
                        center: {
                            lat: position.lat(),
                            lng: position.lng()
                        }
                    }


                 /*   var polygon = new google.maps.Polygon({ paths: polygonCoords });

                    const markersInsidePolygon = markerList
                        .filter(
                            marker => google.maps.geometry.polygon.containsLocation(marker.getPosition(), polygon)
                        );

                    console.log(markersInsidePolygon);*/

                    console.log("lados: " + miPoligono);
                    coordinatesArray = pol.getArray();

                    console.log("dimecion: " + coordinatesArray);
                   var res= isMarkerInsidePolygon(marker.center.lat, marker.center.lng, miPoligono, coordinatesArray); 
                   




                   
                  //*******************
                   console.log("inside:" + res);
                    // console.log("Marcador: \n lat: "+ marker.center.lat+"\n"+marker.center.lng);
                    var isIRadious = google.maps.geometry.spherical.computeDistanceBetween(
                        position, circle.overlay.getCenter()) <= circle.radius;

                    if (isIRadious == true) {
                        console.log("lat:" + position.lat());
                        console.log("lng:" + position.lng());
                        var i = 1; //contador para asignar id al boton que borrara la fila
                        var fila = '<tr id="row' + i + '"><td>' + position.lat() + '</td><td>' + position.lng() + '</td></tr>';
                        //<button type="button" name="remove" id="' + i + '" class="btn btn-danger btn_remove">Quitar</button></td></tr>'; //esto seria lo que contendria la fila

                        i++;

                        $('#mytable tr:first').after(fila);
                        $("#adicionados").text(""); //esta instruccion limpia el div adicioandos para que no se vayan acumulando
                        var nFilas = $("#mytable tr").length;
                        $("#adicionados").append(nFilas - 1);
                        //le resto 1 para no contar la fila del header
                        /*document.getElementById("apellido").value ="";
                        document.getElementById("cedula").value = "";
                        document.getElementById("nombre").value = "";
                        document.getElementById("nombre").focus();
                    
                    $(document).on('click', '.btn_remove', function() {
                        var button_id = $(this).attr("id");
                        //cuando da click obtenemos el id del boton
                        $('#row' + button_id + '').remove(); //borra la fila
                        //limpia el para que vuelva a contar las filas de la tabla
                        $("#adicionados").text("");
                        var nFilas = $("#mytable tr").length;
                        $("#adicionados").append(nFilas - 1);
                    });*/
                    } else {
                        console.log("fuera de alcance");
                    }
                } else {
                    console.log("ocurre algo raro!!");
                }/*
                      console.log('Geocerca: \n radius', circle.radius);
                      console.log('lat', circle.overlay.getCenter().lat());
                      console.log('lng', circle.overlay.getCenter().lng());
                      */
            });

        }


        




        function isMarkerInsidePolygon(lat, lng, lados, polyPoints) {

            if (lados < 3) {
                console.log("Marcador: \n lat: " + lat + "\n" + lng);
                conole.log("polyPoints : " + polyPoints);
                return false;
            } else {
                var x = lat, y = lng;

                var inside = false;
                for (var i = 0, j = polyPoints.length - 1; i < polyPoints.length; j = i++) {
                    var xi = polyPoints[i].lat, yi = polyPoints[i].lng;
                    var xj = polyPoints[j].lat, yj = polyPoints[j].lng;

                    var intersect = ((yi > y) != (yj > y))
                        && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
                    if (intersect) inside = !inside;
                }
                
                return inside;
            }

        };




        //**********************
        //Display Coordinates below map
        function getPolygonCoords() {
            var len = myPolygon.getPath().getLength();
            var htmlStr = "";
            for (var i = 0; i < len; i++) {
                htmlStr += "new google.maps.LatLng(" + myPolygon.getPath().getAt(i).toUrlValue(5) + "), ";
                //Use this one instead if you want to get rid of the wrap > new google.maps.LatLng(),
                //htmlStr += "" + myPolygon.getPath().getAt(i).toUrlValue(5);
            }
            console.log("Puntos del polygon: " + htmlStr);
        }

        function test() {
            var arr = new Array()
            arr.push('51.5001524,-0.1262362');
            arr.push('52.5001524,-1.1262362');
            arr.push('53.5001524,-2.1262362');
            arr.push('54.5001524,-3.1262362');
            dibuV(arr);
        }
        function dibuV(area) {
            var a = new Array();

            for (var i = 0; i < area.length; i++) {
                var uno = area[i].split(", ");
                a[i] = new google.maps.LatLng(uno[0], uno[1]);
            }

            poligon = new google.maps.Polygon({
                paths: a,
                strokeColor: "#22B14C",
                strokeOpacity: 0.8,
                strokeWeight: 2,
                fillColor: "#22B14C",
                fillOpacity: 0.35
            })

            poligon.setMap(map);//until here is ok 
            var z = new google.maps.geometry.spherical.computeArea(poligon.getPath());
            alert(z); //this is not working
        }
    </script>
</body>
</html>
