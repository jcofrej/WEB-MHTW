
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Proveedores"%>
<%@page import="Modelo.Usuario"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">






<%
    Usuario usu = (Usuario)session.getAttribute("usuario");
    LinkedList<Proveedores> prov;
    String usuario = usu.getNombre().toUpperCase();
    String codigo = request.getParameter("codigo");
    String nombre = request.getParameter("nombre");
%>




<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Consulta Ordenes de Entrada</title>



<link rel="stylesheet" href="css/dianet-styles-SGT.css" media="screen" />
<link rel="stylesheet" href="css/global.css" media="screen" />
<link rel="stylesheet" href="css/CalendarPopup.css" media="screen" />

<script type="text/javascript" src="javascript/table.js"></script>
<script type="text/javascript" src="javascript/CalendarPopup.js"></script>
<script type="text/javascript" src="javascript/date.js"></script>

<script type="text/javascript" src="javascript/mweb.js"></script>
<script type="text/javascript" src="javascript/entradas.js"></script>
<script type="text/javascript" src="javascript/entregas.js"></script>
<script type="text/javascript" src="javascript/stocks.js"></script>


<SCRIPT LANGUAGE="JavaScript">



    var calFechaIni = new CalendarPopup("testdiv1", 'es');
    calFechaIni.setCssPrefix("TEST");
    
	var calFechaFin = new CalendarPopup("testdiv1",'es');
    calFechaFin.setCssPrefix("TEST");		

  
	function mostrarMensajes(){
	   
	    	
			alert("No se ha podido obtener la entrega seleccionada.");
			
			alert("No se ha podido obtener la entrega seleccionada.");
			 
	   
	    
	}

	function muestraFecha(id, event){
		   document.getElementById(id).style.display="";
		   document.getElementById(id).style.left=event.clientX + "px";
           document.getElementById(id).style.top=event.clientY + "px";
    }
    
    function ocultaFecha(id){
               document.getElementById(id).style.display="none"; 
	}
	
	
	var txtCamposVacios = "Debe especificarse algún criterio de búsqueda";
	var txtRangoError = "El rango de fechas especificado no es correcto";
	var txtFhInicialError = "La fecha inicial es incorrecta";
	var txtFhFinalError = "La fecha final es incorrecta";
	var txtFechasIncompletas= "Si desea filtrar por fecha, ha de especificar un rango";
   
   	</script>


</head>



<body onLoad="mostrarMensajes();">

	<!-- Division principal -->
	<div id="DIAnetContainer">
		<div id="DIAnetClearHeader"></div>
		<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">









<div id="DIAnetContainerContentLeft">

	<div style="padding: 5px; border-bottom: 1px solid #fff;">
		<div class="dianet-div-align-left">
			<p style="font-size: 12px">
				
					<%=usuario  %>
				
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
				onclick="location.href='CerrarSesion.do'" value="Logout"
				name="Logout">
		</div>
	</div>

	<div id="DIAnetLeftNavigation">
		<ul>
			
				<div id="menu_1">
					<li><a onclick="irMenuGestionOE();" href="#">Gestión de Ordenes de Entrada</a></li>
				</div>
			

			
				<div id="menu_2">
					<li><a onclick="irMenuGestionEntregas();" href="#">Gestión de Entregas</a></li>
				</div>
			

			
				<div id="menu_3">
					<li><a onclick="irMenuGestionStock();" href="#">Gestión de Stock</a></li>
				</div>
			
			
			<div id="menu_5">
				<li><a onclick="irMenuChgPwd();" href="#">Cambiar contraseña</a></li>
			</div>

			<div id="menu_4">
				<li><a onclick="irMenuAcercaDe();" href="#">Acerca de</a></li>
			</div>
			
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

		<!--  navegación -->
		<div id="DIAnetBreadCrumbs">
			Esta en
			<a href="#" class="home"> Gestión de Ordenes de Entrada
			</a> <img src="imagenes/icon-bread-crumbs.gif" alt="" h />
			Consulta Ordenes de Entrada
		</div>


		<form name="MWEBFilterOrdenesForm" method="POST" action="/WEB-MHTWpok/ConsultaOrdenesEntrada.do">
			<input type="hidden" name="pageCurrent" value="">
			<!-- ============ Botonera de acciones ============ -->
			<div class="dianet-mrg-bottom-15">
				<div class="dianet-div-align-left">
					
						<input type="button" name="" value="Nueva Orden Entrada" onclick="irNuevaOE();" class="boton">
					
					
						<input type="button" name="" value="Limpiar búsqueda" onclick="btLimpiarBusqueda();" class="boton">
						<input type="button" name="" value="Buscar" onclick="btBuscarOE();" class="boton">
						
						
							<input type="button" name="" value="Imprimir" onclick="btImprimirOE(); return false;" class="boton">
						
						
												
						
					
				</div>
			</div>
			<br />


			<!-- ============ Formulario de filtro ============ -->
			<!-- texto a mostrar de ayuda -->
			<div
				style="display: none; background: yellow; width: 150px; border: 5px solid gray; position: absolute; left: 450px; top: 150px; z-index: 2000; text-align: center;"
				id="FIni">
				Desde
			</div>
			<div
				style="display: none; background: yellow; width: 150px; border: 5px solid gray; position: absolute; left: 450px; top: 150px; z-index: 2000; text-align: center;"
				id="FFin">
				Hasta 
			</div>
			<p class="dianet-content-last-update">
				Filtrar orden por:
			</p>
			<table cellspacing="1" cellpadding="3" id="DIAnetTableFiltreOrdenes">
				<tr>
					<th class="WF170">Código Seguimiento</th>
					<th class="WF170">Código OE</th>
					<th class="WF80">Desde</th>
					<!--  onMouseOver="muestraFecha('FIni', event);" onMouseOut="ocultaFecha('FIni');" -->
					<th class="WF80">Hasta</th>
					<!--  onMouseOver="muestraFecha('FFin', event);" onMouseOut="ocultaFecha('FFin');" -->
					<th class="WF130"><a href="#" onclick="irProveedoresOE();">Proveedor</a></th>
				</tr>
				<tr>
					<td><input id="codSeguimiento" name="codSeguimiento"
						type="text" style="width: 98%" maxlength="20"
						value="%" /></td>
					<td><input id="codGL" name="codGL" type="text"
						style="width: 98%" maxlength="20"
						" value="" /></td>
					<td><input id="fechaIni" name="fechaIni" type="text"
						onclick="calFechaIni.select(document.forms['MWEBFilterOrdenesForm'].fechaIni,'fechaIni','dd/MM/yyyy'); return false;"
						style="width: 70px;"
						value="" /></td>
					<td><input id="fechaFin" name="fechaFin" type="text"
						onclick="calFechaFin.select(document.forms['MWEBFilterOrdenesForm'].fechaFin,'fechaFin','dd/MM/yyyy'); return false;"
						style="width: 70px;"
						value="" /></td>
					<td> 
							<input id="proveedor" name="proveedor" type="text"
								style="width: 98%" maxlength="15"
								value="" />
						</td>
				</tr>

			</table>
		</form>
<script type="text/javascript" language="JavaScript">
  <!--
  var focusControl = document.forms["MWEBFilterOrdenesForm"].elements["codSeguimiento"];

  if (focusControl != null && focusControl.type != "hidden" && !focusControl.disabled && focusControl.style.display != "none") {
     focusControl.focus();
  }
  // -->
</script>

		<br />

		<div id="testdiv1"
			style="position: absolute; visibility: hidden; background-color: white; left: 39px; top: 1040px;"></div>

		<!-- ============ Tabla con el contenido + navegacion ============ -->
		<table>
			
			
				




<tr>
	<table><tr>
	<td>
		<div class="dianet-div-align-right">
			<table id="page" cellpadding="3" cellspacing="5">
				<tr>
					<!- numero de registros -->
					<td class="dianet-nav-listado">N. Registros <span> 15
					</span></td>
					<!- numero de páginas -->
					<td class="dianet-nav-listado">N. Páginas
						2</td>
					<!- primera pag -->
					<td><a class="dianet-nav-listado" id="pageFist"
						onclick="irPage(0, 'DIAnetTableListadoOrdenes',''); return false;"
						href="#">&lsaquo;&lsaquo;</a></td>
					<!- anterior pag -->
					<td><a class="dianet-nav-listado" id="pagePrevious"
						onclick="irPage('previous','DIAnetTableListadoOrdenes',''); return false;"
						href="#">&lsaquo;</a></td>


					


					
					
								
						
						
							
								
									<td id="page1"
									class="dianet-nav-listado-selected">
										<a style="color: rgb(0,0,0)"
										onclick="irPage(0,'DIAnetTableListadoOrdenes',''); return false;"
										href="#">1</a></td>
								
								
							
								
								
									<td id="page2"
									class="dianet-nav-listado">
										<a style="color: rgb(0,0,0)"
										onclick="irPage(1,'DIAnetTableListadoOrdenes',''); return false;"
										href="#">2</a></td>
								
							
													
									
					

					<!- siguiente pag -->
					<td><a class="dianet-nav-listado" id="pagePrevious"
						onclick="irPage('next', 'DIAnetTableListadoOrdenes',''); return false;"
						href="#">&rsaquo;</a></td>
					<!- ultima pag -->
					<td><a class="dianet-nav-listado"
						onclick="irPage(2-1, 'DIAnetTableListadoOrdenes',''); return false;"
						href="#">&raquo;</a></td>

				</tr>
			</table>
			<div class="dianet-div-clear"></div>
		</div>
	</td>
	</tr></table>
</tr>

			
			
			<tr>
				<td>
					<p class="dianet-content-listado">
						Listado de Ordenes
					</p>
				</td>
			</tr>
			<tr>
				<td><form name="MWEBAccionOEForm" method="POST" action="/WEB-MHTWpok/DetalleOE.do">
						<input type="hidden" name="codigoOE" value="">
						<input type="hidden" name="pageCurrent" value="">
						
							<table id="DIAnetTableListadoOrdenes"
								class="table-autopage:10 table-page-current:1"
								cellspacing="1" cellpadding="3">
								
								

										<thead id="orderHead">
											<tr>
												<th width="70">Código Seguimiento</th>
												<th width="150">Código OE</th>
												<th width="70">Fecha Alta</th>
												<th width="70">Tipo</th>
												<th width="70">Fecha Caducidad</th>
												<th width="85">Estado</th>
												<th width="70">Proveedor</th>
												<th width="120">Comentario</th>
												<th width="75">Acción</th>
											</tr>
										</thead>
										<tbody id="orderBody">
											
												
													<tr>
														<td>002</td>
														<td>397</td>
														<td>31/05/2013</td>
														<td>OE Normal</td>
														<td>05/06/2013</td>
														<td>Incompleta</td>
														<td>002</td>
														<td>TRANSFERENCIA
														</td>
														
														<td class="align-center">
														<a href="#"
															onclick="irDetalleOE('397');"> Consultar</a> 
														 </td>
													</tr>
												
													<tr>
														<td>002</td>
														<td>464</td>
														<td>21/06/2013</td>
														<td>OE Normal</td>
														<td>26/06/2013</td>
														<td>Incompleta</td>
														<td>002</td>
														<td>TRASNFERENCIA INTERNA
														</td>
														
														<td class="align-center">
														<a href="#"
															onclick="irDetalleOE('464');"> Consultar</a> 
														 </td>
													</tr>
												
													<tr>
														<td>002</td>
														<td>466</td>
														<td>24/06/2013</td>
														<td>OE Normal</td>
														<td>29/06/2013</td>
														<td>Completa</td>
														<td>002</td>
														<td>transferencia interna
														</td>
														
														<td class="align-center">
														<a href="#"
															onclick="irDetalleOE('466');"> Consultar</a> 
														 </td>
													</tr>
												
													<tr>
														<td>002</td>
														<td>647</td>
														<td>29/08/2013</td>
														<td>OE Normal</td>
														<td>03/09/2013</td>
														<td>Completa</td>
														<td>002</td>
														<td>Llegada de combustibles.
														</td>
														
														<td class="align-center">
														<a href="#"
															onclick="irDetalleOE('647');"> Consultar</a> 
														 </td>
													</tr>
												
													<tr>
														<td>002</td>
														<td>648</td>
														<td>04/09/2013</td>
														<td>OE Normal</td>
														<td>03/09/2013</td>
														<td>Incompleta</td>
														<td>002</td>
														<td>Llegada de combustibles.
														</td>
														
														<td class="align-center">
														<a href="#"
															onclick="irDetalleOE('648');"> Consultar</a> 
														 </td>
													</tr>
												
													<tr>
														<td>002</td>
														<td>661</td>
														<td>02/09/2013</td>
														<td>OE Normal</td>
														<td>07/09/2013</td>
														<td>Completa</td>
														<td>002</td>
														<td>RECEPCION EXCEDENTES
														</td>
														
														<td class="align-center">
														<a href="#"
															onclick="irDetalleOE('661');"> Consultar</a> 
														 </td>
													</tr>
												
													<tr>
														<td>002</td>
														<td>682</td>
														<td>04/09/2013</td>
														<td>OE Normal</td>
														<td>09/09/2013</td>
														<td>Incompleta</td>
														<td>002</td>
														<td>reemplazo orden 648
														</td>
														
														<td class="align-center">
														<a href="#"
															onclick="irDetalleOE('682');"> Consultar</a> 
														 </td>
													</tr>
												
													<tr>
														<td>002</td>
														<td>434</td>
														<td>12/06/2013</td>
														<td>OE Normal</td>
														<td>17/06/2013</td>
														<td>Incompleta</td>
														<td>002</td>
														<td>transferencia interna
														</td>
														
														<td class="align-center">
														<a href="#"
															onclick="irDetalleOE('434');"> Consultar</a> 
														 </td>
													</tr>
												
													<tr>
														<td>002</td>
														<td>436</td>
														<td>13/06/2013</td>
														<td>OE Normal</td>
														<td>18/06/2013</td>
														<td>Completa</td>
														<td>002</td>
														<td>transferencia interna
														</td>
														
														<td class="align-center">
														<a href="#"
															onclick="irDetalleOE('436');"> Consultar</a> 
														 </td>
													</tr>
												
													<tr>
														<td>14032014</td>
														<td>1420</td>
														<td>14/03/2014</td>
														<td>OE Normal</td>
														<td>29/03/2014</td>
														<td>Completa</td>
														<td>002</td>
														<td>
														</td>
														
														<td class="align-center">
														<a href="#"
															onclick="irDetalleOE('1420');"> Consultar</a> 
														 </td>
													</tr>
												
													<tr>
														<td>guia 123</td>
														<td>1731</td>
														<td>28/05/2014</td>
														<td>OE Normal</td>
														<td>12/06/2014</td>
														<td>Caducada</td>
														<td>002</td>
														<td>orden de prueba, favor eliminar
														</td>
														
														<td class="align-center">
														<a href="#"
															onclick="irDetalleOE('1731');"> Consultar</a> 
														 </td>
													</tr>
												
													<tr>
														<td>111</td>
														<td>3861</td>
														<td>20/04/2015</td>
														<td>OE Normal</td>
														<td>20/05/2015</td>
														<td>Completa</td>
														<td>002</td>
														<td>combustible
														</td>
														
														<td class="align-center">
														<a href="#"
															onclick="irDetalleOE('3861');"> Consultar</a> 
														 </td>
													</tr>
												
													<tr>
														<td>123</td>
														<td>7421</td>
														<td>05/01/2017</td>
														<td>OE Normal</td>
														<td>04/02/2017</td>
														<td>Completa</td>
														<td>002</td>
														<td>
														</td>
														
														<td class="align-center">
														<a href="#"
															onclick="irDetalleOE('7421');"> Consultar</a> 
														 </td>
													</tr>
												
													<tr>
														<td>002-09122015</td>
														<td>5235</td>
														<td>09/12/2015</td>
														<td>OE Normal</td>
														<td>08/01/2016</td>
														<td>Completa</td>
														<td>002</td>
														<td>llega hoy
														</td>
														
														<td class="align-center">
														<a href="#"
															onclick="irDetalleOE('5235');"> Consultar</a> 
														 </td>
													</tr>
												
													<tr>
														<td>123</td>
														<td>7214</td>
														<td>11/11/2016</td>
														<td>OE Express</td>
														<td>11/12/2016</td>
														<td>Completa</td>
														<td>002</td>
														<td>
														</td>
														
														<td class="align-center">
														<a href="#"
															onclick="irDetalleOE('7214');"> Consultar</a> 
														 </td>
													</tr>
												
											

											
										</tbody>
									</table>
									</form>
									</td>
									</tr>
							</table>

							


<div id="DIAnetContainerHeader">
	<table width="100%">
		<tr>
			<td width="150" align="center" valign="top"><img height="75"
				src="./imagenes/logo_Cliente.png" />
			</td>
			<td align="center"><div style="color: #FFFFFF; font-size: 24px;">WEB-MHTW</div></td>
			<td width="150" align="center">
<!-- 			<img height="75" -->

			</td>
		</tr>
	</table>
							</div>
</body>
</html>
