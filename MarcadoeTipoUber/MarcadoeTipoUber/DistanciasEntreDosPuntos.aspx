<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DistanciasEntreDosPuntos.aspx.vb" Inherits="MarcadoeTipoUber.DistanciasEntreDosPuntos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <title>Distancias entre dos puntos</title>
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
    <script type="text/javascript" src='https://maps.google.com/maps/api/js?key=AIzaSyD_q6OLpZbcqQd_xo3rs9CW6ABxpLJOHrg&libraries=drawing,geometry'></script>

</head>
<body>
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
                        <asp:TextBox ID="txtLatitudA" CssClass="form-control" Text="19.4199042" runat="server"></asp:TextBox>
                        <label for="lon">Lon:</label>
                        <asp:TextBox ID="txtLongitudA" CssClass="form-control" Text="-99.169275" runat="server"></asp:TextBox>

                    </div>
                    
                </div>
                <div class="col-md-4">
                    <p>Cordenadas del marker B</p>
                      <!--Ubicacion -->
                
                    <br />
                    <div class="form-group">
                        <br />
                       <label for="lat">Lat:</label>
                        <asp:TextBox ID="txtLatitudB" CssClass="form-control" Text="19.4199500" runat="server"></asp:TextBox>
                        <label for="lon">Lon:</label>
                        <asp:TextBox ID="txtLongitudB" CssClass="form-control" Text="-99.169375" runat="server"></asp:TextBox>

                    </div>
                    
                </div>
                
            </div>
        </div>
         <script>
             $('#map').locationpicker({
                 radius: 20,
                 location: {
                     latitude: 19.4199500,
                     longitude: -99.169375
                 },
                 enableAutocomplete: true,
                inputBinding: {
                    latitudeInput: $('#<%=txtLatitudA.ClientID%>'),
                    longitudeInput: $('#<%=txtLongitudA.ClientID%>')
                }
                
            });


            

         </script>
    </form>
    <script>

    </script>
</body>
</html>
