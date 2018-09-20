<%@include file="doctype.inc"%>
<%@page import="Modelo.Usuario"%>      
<%@page import="Controlador.Consultas"%>        
<div id="DIAnetContainerContentLeft">

	<div style="padding: 5px; border-bottom: 1px solid #fff;">
		<div class="dianet-div-align-left">
			<p style="font-size: 12px">
                            <%
                                Consultas co = new Consultas();
                                Usuario usu = (Usuario) session.getAttribute("usuario");

                                String usuario = usu.getNombre().toUpperCase();
                                String tipo_usuario = co.getUsuarioMenu(usuario);
                                
                            %>
                            <%= usuario%>
				
			</p>
		</div>

		<div class="dianet-div-align-right">
			<form action="" style="margin: 0px;">
				<input type="text"
					style="font-size: 12px; border: 0px; text-align: right; background-color: transparent"
					id="fechaActualId" />
			</form>
		</div>

		<div class="dianet-div-clear"></div>

		<div class="">
			<input id="Salir" class="boton" type="button" style="width: 190px;"
				onclick="location.href='cerrarSesion.do'" value="Logout"
				name="Logout">
		</div>
	</div>

	<div id="DIAnetLeftNavigation">
		<ul>
			
				<div id="menu_1">
					<li><a onclick="irMenuGestionOE();" href="#">Gesti&oacute;n de Ordenes de Entrada</a></li>
				</div>
			

			
				<div id="menu_2">
                                    <!--irMenuGestionEntregas();-->
					<li><a onclick="irMenuGestionEntregas();" href="#">Gesti&oacute;n de Pedidos</a></li>
				</div>
			

			
				<div id="menu_3">
                                    <!--irMenuGestionStock();-->
					<li><a onclick="irMenuGestionStock();" href="#">Gesti&oacute;n de Stock</a></li>
				</div>
			
			
			<div id="menu_5">
				<li><a onclick="irMenuChgPwd();" href="#">Cambiar contrase&ntilde;a</a></li>
			</div>
                        <%
                        if (tipo_usuario.equals("1")) {
                        %>
			<div id="menu_4">
				<li><a onclick="irMenuGestionUsuario();" href="#">Gesti&oacute;n de Usuario</a></li>
			</div>
			<%
                        }
                        %>
		</ul>
	</div>
</div>

<script languaje="JavaScript">
	
	// Function de hora y fecha
       function gDispDate()
       {
         var myDate = new Date();
         var myYear   = myDate.getFullYear();
         var myMonth  = (myDate.getMonth() + 1) + '';
         var myDay    = myDate.getDate() + '';
         var myHour   = myDate.getHours() + '';
         var myMinute = myDate.getMinutes() + '';
         if(myMonth.length == 1)  myMonth  = '0' + myMonth;
         if(myDay.length == 1)    myDay    = '0' + myDay;
         if(myHour.length == 1)   myHour   = '0' + myHour;
         if(myMinute.length == 1) myMinute = '0' + myMinute;
         var myDateString = myDay + '/' + myMonth + '/' + myYear + ' ' + myHour + ':' + myMinute;
         document.getElementById('fechaActualId').value = myDateString;
       } // gDispDate
       gDispDate();
       window.setInterval('gDispDate()', 1000);
        		
</script>