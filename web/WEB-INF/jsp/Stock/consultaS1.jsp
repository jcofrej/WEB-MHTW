
<%@page import="java.text.DecimalFormat"%>
<%@page import="Modelo.Stock"%>
<%@page import="java.util.LinkedList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String msg = (String)session.getAttribute("msgArticulo");
if(msg!=null){
%>
    <script language="JavaScript">
        alert('<%=msg %>');
    </script>
<%
}
session.removeAttribute("msgArticulo");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Gestión de Stock</title>
        <%@include file="../head.inc"%>
        <SCRIPT LANGUAGE="JavaScript">

            var calFechaIni = new CalendarPopup("testdiv1", 'es');
            calFechaIni.setCssPrefix("TEST");

            var calFechaFin = new CalendarPopup("testdiv1", 'es');
            calFechaFin.setCssPrefix("TEST");

            function desactivarPager() {
                var pagina;

            }

            function mostrarMensajes() {


            }

            var txtCamposVacios = "Debe especificarse algún criterio de búsqueda";
            var txtRangoError = "El rango de fechas especificado no es correcto";
            var txtFhInicialError = "La fecha inicial es incorrecta";
            var txtFhFinalError = "La fecha final es incorrecta";
            var txtFechasIncompletas = "Si desea filtrar por fecha, ha de especificar un rango";


            //literales de los modos
            var modoBusquedaStocks = 'MODO_BUSQUEDA_STOCKS';
            var modoBusquedaArticulos = 'MODO_BUSQUEDA_ARTICULO';
            var modoImprimir = 'MODO_IMPRIMIR';
            var modoResetear = 'MODO_RESETEAR';
            var modoDetalle = 'MODO_DETALLE';

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
                    <a href="#" class="home"> Gestión de Stock
                    </a> <img src="imagenes/icon-bread-crumbs.gif" alt="" h />
                    Consulta Stock
                </div>

                <form name="MWEBFilterStockForm" method="POST" action="#">
                    <!-- ============ Botonera de acciones ============ -->
                    <div class="dianet-mrg-bottom-15">
                        <div class="dianet-div-align-left">

                            <input type="button" name="" value="Limpiar búsqueda" onclick="btLimpiarBusquedaStock(modoResetear);" class="boton">
                            <input type="submit" name="" value="Buscar" class="boton">




                           <!-- <input type="button" name="" class="boton"
                                   value="Imprimir"
                                   onclick="alert('No se ha podido realizar la impresion de los stocks, ya que no hay ninguno');">





                            <input type="button" name="" class="boton"
                                   value="Exportar Excel"
                                   onclick="alert('No se ha podido realizar la exportacion a excel de los stocks, ya que no hay ninguno');">-->



                        </div>
                    </div>
                    <br />


                    <!-- ============ Formulario de filtro ============ -->
                    <p class="dianet-content-last-update">
                        Filtrar Stock por:
                    </p>
                    <table cellspacing="1" cellpadding="3" id="DIAnetTableFiltreStocks">
                        <tr>
                            <th width="150">Código Art.</a></th>
                            <th width="150">Código Art. MH</a></th>
                            <th>Descripción</th>
                            <th width="100">Lote</th>
                            <th width="75">Desde</th>
                            <th width="75">Hasta</th>
                        <tr>
                            <td><input id="codigoArticuloPropietario"
                                       name="codigoArticuloPropietario" maxLength="31" type="text"
                                       style="width: 98%"
                                       value="" />
                            </td>
                            <td><input id="codigoArticulo" name="codigoArticulo"
                                       type="text" style="width: 98%" maxLength="20"
                                       value="" />
                            </td>


                            <td><input id="descripcion" name="descripcion" type="text"
                                       style="width: 98%" maxLength="20"
                                       value="" /></td>
                            
                            <td><input id="lote" name="lote" type="text"
                                       style="width: 98%"
                                       value="" /></td>
                            <td><input id="fechaIni" name="fechaIni" type="text"
                                       onclick="calFechaIni.select(document.forms['MWEBFilterStockForm'].fechaIni, 'fechaIni', 'dd/MM/yyyy');
                                               return false;"
                                       style="width: 98%" maxLength="10"
                                       value="" /></td>
                            <td><input id="fechaFin" name="fechaFin" type="text"
                                       onclick="calFechaFin.select(document.forms['MWEBFilterStockForm'].fechaFin, 'fechaFin', 'dd/MM/yyyy');
                                               return false;"
                                       style="width: 98%" maxLength="10"
                                       value="" /></td>
                        </tr>
                    </table>

                    <input type="hidden" name="modo" value="">
                    <input type="hidden" name="idArticulo" value="">
                    <input type="hidden" name="codArtPropietarioDetalle" value="">
                    <input type="hidden" name="codArticuloDetalle" value="">
                    <input type="hidden" name="descripcionDetalle" value="">
                    <input type="hidden" name="categoriaDetalle" value="">
                    <input type="hidden" name="cantidadDetalle" value="">
                    <input type="hidden" name="cantidad" value="">
                    <input type="hidden" name="pageCurrent" value="1">
                    <input type="hidden" name="origen" value="1">
                    <input type="hidden" name="usuario" value="<%=usuario %>">

                </form>
                <script type="text/javascript" language="JavaScript">
                    <!--
                  var focusControl = document.forms["MWEBFilterStockForm"].elements["codigoArticuloPropietario"];

                    if (focusControl != null && focusControl.type != "hidden" && !focusControl.disabled && focusControl.style.display != "none") {
                        focusControl.focus();
                    }
                    // -->
                </script>

                <br />

                <div id="testdiv1"
                     style="position: absolute; visibility: hidden; background-color: white; left: 39px; top: 1040px;"></div>

                <!-- ============ Tabla con el contenido + navegacion ============ -->
                <%
                LinkedList<Stock> stc=null;
            DecimalFormat decimales = new DecimalFormat("0");
            stc= (LinkedList)session.getAttribute("stock");
            
            if(stc!=null){
            %>
            <table id="page" cellpadding="3" cellspacing="5">
                <tr>
                    <!- numero de registros -->
                    <td class="dianet-nav-listado">N. Registros <span> <%=stc.size()%>
                        </span></td>
                    <!- numero de páginas -->
                    <td class="dianet-nav-listado">N. Páginas <%=decimales.format(Math.ceil((double) stc.size() / (double) 10))%> </td>
                    <!- primera pag -->
                    <td><a class="dianet-nav-listado" id="pageFist"
                           onclick="irPage(0, 'DIAnetTableListadoStocks', '');
                                                       return false;"
                           href="#">&lsaquo;&lsaquo;</a></td>
                    <!- anterior pag -->
                    <td><a class="dianet-nav-listado" id="pagePrevious"
                           onclick="irPage('previous', 'DIAnetTableListadoStocks', '');
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
                           onclick="irPage('next', 'DIAnetTableListadoStocks', '');
                                                       return false;"
                           href="#">&rsaquo;</a></td>
                    <!- ultima pag -->
                    <td><a class="dianet-nav-listado"
                           onclick="irPage(2 - 1, 'DIAnetTableListadoStocks', '');
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

                            <table id="DIAnetTableListadoStocks"
                                   class="table-autopage:10"
                                   cellspacing="1" cellpadding="3">

                                <thead id="orderHead">
                                    <tr>
                                        <th width="150">Código Art.</th>
                                        <th width="150">Código Art. MH</th>
                                        <th width="200">Descripción</th>
                                        <th width="150" class="align-center">Cantidad</th>
                                        <th width="150" class="align-center">Acción</th>
                                    </tr>
                                    </tr>
                                </thead>
                                <tbody id="orderBody">
<% 
                                    
                                    
                                    if(stc!=null){
                                    for(int i=0;i<stc.size();i++){
                                    %>

                                    <tr>
                                        <td class="padding-left-10"><%=stc.get(i).getCodArt()%></td>
                                        <td class="padding-left-10"><%=stc.get(i).getCodMh()%></td>
                                        <td class="padding-left-10"><%=stc.get(i).getDescripcion()%></td>
                                        <td class="padding-left-10"><%=stc.get(i).getCantidad()%></td>
                                        <td class="padding-left-10"><a href="#" onclick="irDetalleStock('<%=stc.get(i).getCodArt()%>',<%=stc.get(i).getCantidad()%>)">Consultar</a></td>
                                    </tr>
                                     <%
                                    }
                                    }else{
                                     %>
                                     <tr>
                                        <td class="padding-left-10" colspan="5">No hay ningún resultado </td>
                                    </tr>
                                    <%
                                    }
                                    stc=null;
                                    session.removeAttribute("stock");
                                    %>
                                </tbody>
                            </table>

                        </td>
                    </tr>
                </table>




                <%@include file="../cabecera.inc"%>
                </body>
                </html>
