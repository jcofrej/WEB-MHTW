<%@page import="Modelo.DetallePedidos"%>
<%@page import="Modelo.Pedidos"%>
<%@page import="Controlador.Consultas"%>
<%@page import="Modelo.OrdenesEntrada"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.DetalleOrdenEntrada"%>
<%@page import="Controlador.ConsultasMnh"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Detalle</title>

<%@include file="../head.inc"%>
<script language="JavaScript">
	
		function mostrarMensajes(){
	   
	    
	}

   	</script>
</head>
<body onload="mostrarMensajes();">
	

<script language="javascript">
	function redirigeAccesoProhibido(){
		location.href = 'PaginaSinPermisos.do';
	}
	
	
	
		
	 
</script>

	<!-- Division principal -->
	<div id="DIAnetContainer">
		<div id="DIAnetClearHeader"></div>
		<%@include file="../menu.inc"%>
		<!--  navegación -->
		<div id="DIAnetBreadCrumbs">
			Esta en
			Gestión de Pedidos
			<img src="imagenes/icon-bread-crumbs.gif" alt=""> <a href="#" onclick="irConsultaEntrega();" class="home"> Consulta Pedidos
			</a> <img src="imagenes/icon-bread-crumbs.gif" alt="">
			Detalle
		</div>


		<!-- ============ Botonera de acciones ============ -->

		<div class="dianet-mrg-bottom-15">
			<div class="dianet-div-align-left">
				<input type="button" name="" value="Volver" onclick="btVolverEntrega();" class="boton">
				<!--<input type="button" name="" value="Descargar (PDF)" onclick="btDescargarPdfOE(); return false;" class="boton">
				<input type="button" name="" value="Exportar Excel" onclick="btDescargarExcelOE(); return false;" class="boton">-->
			</div>
		</div>
		<br>


		<!-- ============ detalle cabecera  ============ -->
		
			<table cellspacing="1" cellpadding="3" id="DIAnetTableDetalleOrdenes">
				<tbody><tr>
					<th width="70">Código Seguimiento</th>
					<th width="70">Código Pedido</th>
					<th width="70">Fecha Alta</th>
					<th width="70">Cliente</th>
					<th width="70">Tipo</th>
					<th width="85">Estado</th>
				</tr>
                                <%
                                    LinkedList<Pedidos> oe;
                                    Consultas id_clt = new Consultas();
                                    String id_clte = id_clt.getUsuarioWeb(usuario);
                                    String codOE=request.getParameter("codigoOE");
                                    ConsultasMnh conoe = new ConsultasMnh();
                                    oe = conoe.getPedidos(id_clte,"",codOE,"","","");
                                    
                                %>
				<tr>
					<td><%=oe.get(0).getCodSeguimiento()%></td>
					<td><%=oe.get(0).getCodOE()%></td>
					<td><%=oe.get(0).getFechaAlta()%></td>
					<td><%=oe.get(0).getProveedor()%></td>
					<td><%=oe.get(0).getTipo()%></td>
					<td><%=oe.get(0).getEstado()%></td>
				</tr>
			</tbody></table>
			<table cellspacing="1" cellpadding="3" id="DIAnetTableDetalleOrdenes">
				<tbody><tr>
					<th width="100%">Comentario</th>
				</tr>
				<tr>
					<td><%=oe.get(0).getComentario()%></td>
				</tr>
			</tbody></table>
		

		<div id="etiquetasTabDetalle">
			<span id="etiquetaTabProductosDetalle" style="background-color: rgb(234, 234, 234);"> <a >Productos</a>
			</span> 
		</div>

		<div id="tabProductosDetalle" style="display: block;">
			<table class="margin-both-20" id="TABLE_1">
				
					

<%
    LinkedList<DetallePedidos> oeD;    
    ConsultasMnh conoeD = new ConsultasMnh();

    oeD = conoeD.getDetallePedidos(codOE);
    DecimalFormat decimales = new DecimalFormat("0");

%>


<tbody><tr>
	</tr></tbody></table><table id="TABLE_2"><tbody><tr>
	<td>
		<div class="dianet-div-align-right">
			<table id="page" cellpadding="3" cellspacing="5">
				<tbody><tr>
					<!--- numero de registros ---->
					<td class="dianet-nav-listado">N. Registros <span> <%=oeD.size()%>
					</span></td>
					<!--- numero de páginas ---->
                                        <td class="dianet-nav-listado">N. Páginas <%=decimales.format(Math.ceil((double)oeD.size()/(double)5)) %></td>
					<!--- primera pag ---->
					<td><a class="dianet-nav-listado" id="pageFist" onclick="irPage(0, 'DIAnetTableProductosOrdenes','tab1'); return false;" href="#">&lsaquo;&lsaquo;</a></td>
					<!--- anterior pag ---->
					<td><a class="dianet-nav-listado" id="pagePrevious" onclick="irPage('previous','DIAnetTableProductosOrdenes','tab1'); return false;" href="#">&lsaquo;</a></td>


					


					
					
								
						
						
							
								
									<!--<td id="tab1page1" class="dianet-nav-listado-selected">
										<a style="color: rgb(0,0,0)" onclick="irPage(0,'DIAnetTableProductosOrdenes','tab1'); return false;" href="#">1</a></td>
								
								
							
								
								
									<td id="tab1page2" class="dianet-nav-listado">
										<a style="color: rgb(0,0,0)" onclick="irPage(1,'DIAnetTableProductosOrdenes','tab1'); return false;" href="#">2</a></td>-->
								
							
													
									
					

					<!--- siguiente pag ---->
					<td><a class="dianet-nav-listado" id="pagePrevious" onclick="irPage('next', 'DIAnetTableProductosOrdenes','tab1'); return false;" href="#">&rsaquo;</a></td>
					<!--- ultima pag ---->
					<td><a class="dianet-nav-listado" onclick="irPage(2-1, 'DIAnetTableProductosOrdenes','tab1'); return false;" href="#">&rsaquo;&rsaquo;</a></td>

				</tr>
			</tbody></table>
			<div class="dianet-div-clear"></div>
		</div>
	</td>
	</tr></tbody></table>


				
				
				
					
						<p class="dianet-content-listado">
							Listado de productos orden entrada:
						</p>
					
				
				
					
						<table id="DIAnetTableProductosOrdenes" class="table-autopage:5" cellspacing="1" cellpadding="3">
							<thead id="orderHead">
								<tr>
									<th width="100" class="">Línea</th>
									<th width="100" class="">Código Art.</th>
									<th width="100" class="">Código Art. TW</th>
									<th width="200" class="">Descripción</th>
									<th width="100" class="">Lote</th>
									<th width="100" class="">Vencimiento</th>
									<th width="100" class="">Cantidad</th>
									<th width="100" class="">Cantidad Despachada</th>
								</tr>
							</thead>
							<tbody id="orderBody">
								
									<%
                                                                        for (int i=0;i < oeD.size();i++){
                                                                        %>
										<tr>
                                                                                    <td class="align-right"><%=decimales.format(Double.parseDouble(oeD.get(i).getNumLinea())) %></td>
											<td><%=oeD.get(i).getCodClte()%></td>
											<td><%=oeD.get(i).getCodMh()%></td>
											<td><%=oeD.get(i).getDescripcion()%></td>
											<td class="align-right"><%=oeD.get(i).getLote()%></td>
											<td class="align-center"><%=oeD.get(i).getVencimiento()%></td>
											<td class="align-right"><%=decimales.format(Double.parseDouble(oeD.get(i).getCantidad()))%></td>
                                                                                        <td class="align-right"><%=decimales.format(Double.parseDouble(oeD.get(i).getCantidadRecep()))%></td>
										</tr>
									
									<%
                                                                        }
                                                                        %>	
									
									
									
								

							</tbody>
						</table>
					
				
			
		</div>



		


<%@include file="../cabecera.inc"%>

</div></body></html>