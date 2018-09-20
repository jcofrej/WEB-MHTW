
<%@page import="java.text.DecimalFormat"%>
<%@page import="Modelo.Articulos"%>
<%@page import="java.util.LinkedList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
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
<h
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Búsqueda de Artículo</title>


        <%@include file="../head.inc"%>


        <SCRIPT LANGUAGE="JavaScript">
            function desactivarPager() {
                var pagina;

            }

            function mostrarMensajes() {


                //alert("No se mostraran los productos porque no se ha establecido un criterio de busqueda");



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

                <%
                //aqui ponemos un if dependiendo el menu de donde viene la opcion que le damos
                    
                %>
                Gestión de Entregas
                <img src="imagenes/icon-bread-crumbs.gif" alt="" />
                
                <a href="#" onclick="irConsultaOrdenesEntrada();" class="home"> Consulta Entregas
                </a>
                <img src="imagenes/icon-bread-crumbs.gif" alt="" />
                <a href="#" onclick="btVolverAltaOE();" class="home">  
                    Alta de Pedidos

                </a>
                <%
                //cerramos
                %>
                <img src="imagenes/icon-bread-crumbs.gif" alt="" />
                Búsqueda de Artículo







            </div>


            <!-- ============ Botonera de acciones ============ -->
            <form name="MWEBFilterArticulosForm" method="POST" action="#">
                <input type="hidden" name="usuario" value="<%=usuario %>">
                <input type="hidden" name="pagina" value="nuevaep">
                <input type="hidden" name="origen">
                <div class="dianet-mrg-bottom-15">
                    <div class="dianet-div-align-left">
                        <input type="button" name="" value="Limpiar búsqueda" onclick="btLimpiarBusquedaArticulos();" class="boton">
                        <input type="submit" value="Buscar" class="boton">


                        <input type="button" name="" value="Volver" onclick="btVolverAltaEntrega('nuevaep');" class="boton">




                    </div>
                </div>
                <br />


                <!-- ============ Formulario de filtro ============ -->
                <p class="dianet-content-last-update">
                    Filtrar Artículo por:
                </p>
                <table cellspacing="1" cellpadding="3"
                       id="DIAnetTableFiltreArticulos">
                    <tr>
                        <th class="WF130">Código Art.</th>
                        <th class="WF200">Código Art. MH</th>
                        <th class="WF200">Descripción</th>

                    </tr>
                    <tr>
                        <td><input id="codigoArticuloPropietario"
                                   name="codigoArticuloPropietario" style="width: 98%" maxlength="25"
                                   type="text" style="width: 100%"
                                   value="" />
                        </td>
                        <td><input id="codigoArticulo" name="codigoArticulo"
                                   type="text" style="width: 98%" maxlength="31"
                                   value="" />
                        </td>
                        <td><input id="descripcion" name="descripcion" type="text"
                                   style="width: 98%"
                                   value="" />
                        </td>
                        
                    </tr>
                </table>
            </form>
            <script type="text/javascript" language="JavaScript">
                <!--
              var focusControl = document.forms["MWEBFilterArticulosForm"].elements["codigoArticuloPropietario"];

                if (focusControl != null && focusControl.type != "hidden" && !focusControl.disabled && focusControl.style.display != "none") {
                    focusControl.focus();
                }
                // -->
            </script>


            <br />

            <!-- ============ Tabla con el contenido + navegacion ============ -->
            <%
            DecimalFormat decimales = new DecimalFormat("0");
            LinkedList<Articulos> arti= (LinkedList)session.getAttribute("articulos");
            
            if(arti!=null){
            %>
            <table id="page" cellpadding="3" cellspacing="5">
                <tr>
                    <!- numero de registros -->
                    <td class="dianet-nav-listado">N. Registros <span> <%=arti.size()%>
                        </span></td>
                    <!- numero de páginas -->
                    <td class="dianet-nav-listado">N. Páginas <%=decimales.format(Math.ceil((double) arti.size() / (double) 10))%> </td>
                    <!- primera pag -->
                    <td><a class="dianet-nav-listado" id="pageFist"
                           onclick="irPage(0, 'DIAnetTableListadoArticulos', '');
                                                       return false;"
                           href="#">&lsaquo;&lsaquo;</a></td>
                    <!- anterior pag -->
                    <td><a class="dianet-nav-listado" id="pagePrevious"
                           onclick="irPage('previous', 'DIAnetTableListadoArticulos', '');
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
                           onclick="irPage('next', 'DIAnetTableListadoArticulos', '');
                                                       return false;"
                           href="#">&rsaquo;</a></td>
                    <!- ultima pag -->
                    <td><a class="dianet-nav-listado"
                           onclick="irPage(2 - 1, 'DIAnetTableListadoArticulos', '');
                                                       return false;"
                           href="#">&raquo;</a></td>

                </tr>
            </table>
                    <%
                    }
                    %>
            <table>


                <tr>
                    <td>
                        <p class="dianet-content-listado">
                            Listado de Artículos
                        </p>
                    </td>
                </tr>

                <tr>
                    <td>
                        <form name="resultados" method="POST">
                            <input type="hidden" name="codigoArticuloPropietario" value="">
                            <input type="hidden" name="codigoArticulo" value="">
                            <input type="hidden" name="descripcion" value="">
                            <input type="hidden" name="categoria" value="">
                            <input type="hidden" name="id" value="">
                            <input type="hidden" name="controlStock" value="">
                            <input type="hidden" name="pagina" value="">
                            <input type="hidden" name="origen" value="">
                            <input type="hidden" name="codSeguimiento" value="">
                            <input type="hidden" name="comentario" value="">
                            <input type="hidden" name="proveedor" value="">
                            <input type="hidden" name="usuario" value="<%=usuario %>">


                            <table id="DIAnetTableListadoArticulos"
                                   class="table-autopage:10"
                                   cellspacing="1" cellpadding="3">
                                <thead id="orderHead">
                                    <tr>
                                        <th class="WF130">Código Art.</th>
                                        <th class="WF200">Código Art. MH</th>
                                        <th class="WF200">Descripción</th>
                                        <th class="WF120">Categoria</th>
                                        <th class="WF80">Acción</th>
                                    </tr>
                                </thead>
                                <tbody id="orderBody">

                                    <% 
                                    
                                    //String origen = request.getParameter("origen");
                                    if(arti!=null){
                                    for(int i=0;i<arti.size();i++){
                                    %>

                                    <tr>
                                        <td class="padding-left-10"><%=arti.get(i).getCodArt()%></td>
                                        <td class="padding-left-10"><%=arti.get(i).getCodMh()%></td>
                                        <td class="padding-left-10"><%=arti.get(i).getDescripcion()%></td>
                                        <td class="padding-left-10"><%=arti.get(i).getCategoria()%></td>
                                        <td class="padding-left-10"><a href="#" onclick="irSeleccionarArticuloAltaEntrega('<%=arti.get(i).getCodArt()%>',<%=arti.get(i).getCodMh()%>,
                                                                       '<%=arti.get(i).getDescripcion()%>','<%=arti.get(i).getCategoria()%>','irArticuloNEp','irArticuloNEp',
                                                                       '<%=codSeguimiento %>','<%=comentario %>','<%=proveedor %>');">Seleccionar</a></td>
                                     <%
                                    }
                                    }else{
                                     %>
                                     <tr>
                                        <td class="padding-left-10" colspan="5">No hay ningún resultado </td>
                                    </tr>
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