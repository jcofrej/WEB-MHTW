
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Proveedores"%>
<%@page import="Controlador.Consultas"%>
<%@page import="Controlador.ConsultasMnh"%>
<%@page import="Modelo.Usuario"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%
 
    LinkedList<Proveedores> prov;
    String codigo = request.getParameter("codigo");
    String nombre = request.getParameter("nombre");
    String pagina=request.getParameter("pagina");
    String codSeguimiento = request.getParameter("codSeguimiento");
    if (codSeguimiento == null) {
        codSeguimiento = "";
    }
    String comentario = request.getParameter("comentario");
    if (comentario == null) {
        comentario = "";
    }
    String proveedor = request.getParameter("proveedor");
    if (proveedor == null) {
        proveedor = "";
    }
%>







<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Búsqueda de Proveedores</title>
<%@include file="../head.inc"%>

<SCRIPT LANGUAGE="JavaScript">
  	
	
function mostrarMensajes(){
	   
	    
	}

   	</script>
</head>
<body onLoad="mostrarMensajes();">

	<!-- Division principal -->
	<div id="DIAnetContainer">
		<div id="DIAnetClearHeader"></div>
		<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
                <%@include file="../menu.inc"%>
		<!--  navegación -->
		<div id="DIAnetBreadCrumbs">
			Esta en
			Gestión de Ordenes de Entrada
			<img src="imagenes/icon-bread-crumbs.gif" alt="" /> <a href="#"
				onclick="irConsultaOrdenesEntrada();" class="home"> Consulta Ordenes de Entrada
			</a> <img src="imagenes/icon-bread-crumbs.gif" alt="" />
			Búsqueda de Proveedores
		</div>


		<!-- ============ Botonera de acciones ============ -->
		<form name="MWEBFilterProveedorForm" method="POST" action="#">
                    <input type="hidden" name="pagina" value="<%=pagina %>">
                    <input type="hidden" name="codSeguimiento" value="<%=codSeguimiento %>">
                    <input type="hidden" name="comentario" value="<%=comentario %>">
                    <input type="hidden" name="proveedor" value="<%=proveedor %>">
			<div class="dianet-mrg-bottom-15">
				<div class="dianet-div-align-left">

					<input type="button" name="" value="Limpiar búsqueda" onclick="btLimpiarBusquedaProveedores();" class="boton">
					<input type="submit" value="Buscar" class="boton">
                                        
					
					
						<input type="button" name="" value="Volver" onclick="irConsultaOrdenesEntrada();" class="boton">
					



				</div>
			</div>
			<br />


			<!-- ============ Formulario de filtro ============ -->
			<p class="dianet-content-last-update">
				Filtrar proveedor por:
			</p>
			<table cellspacing="1" cellpadding="3"
				id="DIAnetTableFiltreProveedores">
				<tr>
					<th class="WF130">Código</th>
					<th class="WF160">Nombre</th>
				</tr>
				<tr>
					<td><input id="codigo" name="codigo" type="text"
						style="width: 98%" maxlength="15"
						onfocus="controlarEdicion('MWEBFilterProveedorForm','codigo','nombre');"
						value="" /></td>
					<td><input id="nombre" name="nombre" type="text"
						style="width: 98%"
						onfocus="controlarEdicion('MWEBFilterProveedorForm','nombre','codigo');"
						value="" /></td>
                                        
				</tr>
			</table>
		</form>

		<br />



		<!-- ============ Tabla con el contenido + navegacion ============ -->
                <%

                if(codigo!=null){ 
                    Consultas id_clt = new Consultas();
                    String id_clte = id_clt.getUsuarioWeb(usuario);

                    ConsultasMnh conprov= new ConsultasMnh();
                    prov = conprov.getProveedor(id_clte,codigo,nombre);
                    DecimalFormat decimales = new DecimalFormat("0");
            %>	
            <table id="page" cellpadding="3" cellspacing="5">
                <tr>
                    <!- numero de registros -->
                    <td class="dianet-nav-listado">N. Registros <span> <%=prov.size()%>
                        </span></td>
                    <!- numero de páginas -->
                    <td class="dianet-nav-listado">N. Páginas <%=decimales.format(Math.ceil((double) prov.size() / (double) 10))%> </td>
                    <!- primera pag -->
                    <td><a class="dianet-nav-listado" id="pageFist"
                           onclick="irPage(0, 'DIAnetTableListadoProveedores', '');
                                                       return false;"
                           href="#">&lsaquo;&lsaquo;</a></td>
                    <!- anterior pag -->
                    <td><a class="dianet-nav-listado" id="pagePrevious"
                           onclick="irPage('previous', 'DIAnetTableListadoProveedores', '');
                                                       return false;"
                           href="#">&lsaquo;</a></td>
                    <!--<td id="page1"
                        class="dianet-nav-listado-selected">
                        <a style="color: rgb(0,0,0)"
                           onclick="irPage(0, 'DIAnetTableListadoOrdenes', ''); return false;"
                           href="#">1</a></td>-->
                    <!--<td id="page2"
                        class="dianet-nav-listado">
                        <a style="color: rgb(0,0,0)"
                           onclick="irPage(1, 'DIAnetTableListadoOrdenes', ''); return false;"
                           href="#">2</a></td>-->
                    <!- siguiente pag -->
                    <td><a class="dianet-nav-listado" id="pagePrevious"
                           onclick="irPage('next', 'DIAnetTableListadoProveedores', '');
                                                       return false;"
                           href="#">&rsaquo;</a></td>
                    <!- ultima pag -->
                    <td><a class="dianet-nav-listado"
                           onclick="irPage(2 - 1, 'DIAnetTableListadoProveedores', '');
                                                       return false;"
                           href="#">&raquo;</a></td>

                </tr>
            </table><% //} %>
                    
		<table>
			
			
			<tr>
				<td>
					<p class="dianet-content-listado">
						Listado de Proveedores
					</p>
				</td>
			</tr>
			
			<tr>
				<td>
					<form name="resultados" method="POST">
						<input type="hidden" name="proveedor" value="">
                                                <input type="hidden" name="pagina" value="">
                                                <input type="hidden" name="codSeguimiento" value="">
                                                <input type="hidden" name="comentario" value="">
                                                
						<table id="DIAnetTableListadoProveedores"
							class="table-autopage:10"
							cellspacing="1" cellpadding="3">
							<thead id="orderHead">
								<tr>
									<th width="70">Código</th>
									<th width="200">Nombre</th>
									<th width="200">Dirección</th>
									<th width="90">Ciudad</th>
									<th width="90">Provincia</th>
									<th width="80">País</th>
									<th width="75">Acción</th>
								</tr>
							</thead>
							<tbody id="orderBody">

								
<%
    //if(codigo!=null){
    
        
        if(pagina.equals("irProveedores")){
            pagina="";
        }
        if(pagina.equals("irProveedoresNOe")){
            pagina="nuevaoe";
        }
        
        
        
        for (int i=0;i < prov.size();i++){
            %>
            <tr> 
            <td class='padding-left-10'><%=prov.get(i).getCodigo()%></td> 
            <td class='padding-left-10'><%=prov.get(i).getNombre()%></td>
            <td class='padding-left-10'><%=prov.get(i).getDireccion()%></td>
            <td class='padding-left-10'><%=prov.get(i).getCiudad()%></td> 
            <td class='padding-left-10'><%=prov.get(i).getProvincia()%></td> 
            <td class='padding-left-10'><%=prov.get(i).getPais()%></td>
            <td class='padding-left-10'><a href="#" onclick="irSeleccionarProveedorOE('<%=prov.get(i).getCodigo()%>','<%=pagina %>','<%=codSeguimiento %>','<%=comentario %>');">Seleccionar</a></td> 
            </tr>
            <%
        }
    }else{
    %>
        <table id="DIAnetTableListadoClientes"
           class="table-autopage:10"
           cellspacing="1" cellpadding="3">
        <thead id="orderHead">
            <tr>
                <th width="70">Código</th>
                <th width="200">Nombre</th>
                <th width="200">Dirección</th>
                <th width="90">Ciudad</th>
                <th width="90">Provincia</th>
                <th width="80">País</th>
                <th width="75">Acción</th>
            </tr>
        </thead>
        <tbody id="orderBody">

            <tr>
                <td class='padding-left-10' colspan='7'>No hay ningún resultado</td>
            <tr>
        </tbody>
    </table>
    <%
    }   
%>
								

							</tbody>
						</table>
					</form>
				</td>
			</tr>
		</table>

		
<%@include file="../cabecera.inc"%>


</body>
</html>