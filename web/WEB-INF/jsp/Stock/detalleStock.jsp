<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.DetalleStock"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Gestión de Stock</title>


        <%@include file="../head.inc"%>


        <SCRIPT LANGUAGE="JavaScript">

            function mostrarMensajes() {


            }


            var txtCamposVacios = "Debe especificarse algún criterio de búsqueda";
            var txtRangoError = "El rango de fechas especificado no es correcto";
            var txtFhInicialError = "La fecha inicial es incorrecta";
            var txtFhFinalError = "La fecha final es incorrecta";
            var txtFechasIncompletas = "Si desea filtrar por fecha, ha de especificar un rango";

            //literales de los modos
            var modoBusqueda = 'MODO_BUSQUEDA_DETALLE';
            var modoInicial = 'MODO_INICIAL_DETALLE';
            var modoVolver = 'MODO_VOLVER_DETALLE';


        </script>
    </head>
    <body onLoad="mostrarMensajes();">


        <script language="javascript">
            function redirigeAccesoProhibido() {
                location.href = 'PaginaSinPermisos.do';
            }
        </script>

        <!-- Division principal -->
        <div id="DIAnetContainer">
            <div id="DIAnetClearHeader"></div>
            <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
            <%@include file="../menu.inc"%>
            <!--  navegación -->
            <div id="DIAnetBreadCrumbs">
                Esta en
                <a href="#" class="home"> Gestión de Stock
                </a> <img src="imagenes/icon-bread-crumbs.gif" alt="" h /> <a href="#"
                                                                              class="home"
                                                                              onClick="irVolverBusquedaStocksdesdeDetalle(modoVolver)"> Consulta Stock
                </a> <img src="imagenes/icon-bread-crumbs.gif" alt="" />
                Detalle

            </div>


            <!-- ============ Botonera de acciones ============ -->

            <br />
            <%
                String cantidad = request.getParameter("cantidad");
                if (cantidad == null) {
                    cantidad = "";
                }
                LinkedList<DetalleStock> dstc=null;
                DecimalFormat decimales = new DecimalFormat("0");
                dstc= (LinkedList)session.getAttribute("detalleStock");
            %>

            <!-- ============ detalle cabecera  ============ -->
            <table cellspacing="1" cellpadding="3"
                   id="DIAnetTableDetalleStocksCabecera">
                <tr>
                    <th class="WF170">Código Art.</th>
                    <th class="WF170">Código Art. MH</th>
                    <th class="WF200">Descripción</th>
                    <th class="align-center WF100">Cantidad</th>
                </tr>
                <tr>
                    <td><%=dstc.get(0).getCodArt()%></td>
                    <td><%=dstc.get(0).getCodMh()%></td>
                    <td><%=dstc.get(0).getDescripcion()%></td>
                    <td><%=cantidad %></td>
                </tr>
            </table>

            <!-- ============ detalle listado  ============ -->
            <% if(dstc!=null){ %>
            <table id="page" cellpadding="3" cellspacing="5">
                <tr>
                    <!- numero de registros -->
                    <td class="dianet-nav-listado">N. Registros <span> <%=dstc.size()%>
                        </span></td>
                    <!- numero de páginas -->
                    <td class="dianet-nav-listado">N. Páginas <%=decimales.format(Math.ceil((double) dstc.size() / (double) 15))%> </td>
                    <!- primera pag -->
                    <td><a class="dianet-nav-listado" id="pageFist"
                           onclick="irPage(0, 'DIAnetTableDetalleStocksListado', '');
                                                       return false;"
                           href="#">&lsaquo;&lsaquo;</a></td>
                    <!- anterior pag -->
                    <td><a class="dianet-nav-listado" id="pagePrevious"
                           onclick="irPage('previous', 'DIAnetTableDetalleStocksListado', '');
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
                           onclick="irPage('next', 'DIAnetTableDetalleStocksListado', '');
                                                       return false;"
                           href="#">&rsaquo;</a></td>
                    <!- ultima pag -->
                    <td><a class="dianet-nav-listado"
                           onclick="irPage(2 - 1, 'DIAnetTableDetalleStocksListado', '');
                                                       return false;"
                           href="#">&raquo;</a></td>

                </tr>
            </table>
                <%
            }
                %>
            <!-- ============ Tabla de contadores ============ -->

            <p class="dianet-content-listado">
               Detalle Stock Artículo
            </p>
            <table>



                <tr>
                    <td>
                        <p class="dianet-content-listado">
                            Listado de Lotes/Fecha Vencimiento
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table id="DIAnetTableDetalleStocksListado"
                               class="table-autopage:15"
                               cellspacing="1" cellpadding="3">
                            <thead id="orderHead">
                                <tr>
                                    <th width="150">Lote</th>
                                    <th width="150">Fecha Caducidad</th>
                                    <th width="200">Estado</th>
                                    <th width="150" class="align-center">Cantidad</th>
                                </tr>
                            </thead>

                            <tbody id="orderBody">
                                <%
                                for(int i=0;i<dstc.size();i++){
                                %>
                                <tr>
                                    <td><%=dstc.get(i).getLote()%></td>
                                    <td><%=dstc.get(i).getVencimiento()%></td>
                                    <td><%=dstc.get(i).getEstado()%></td>
                                    <td><%=dstc.get(i).getCantidad()%></td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </table>


            <div style="display: none">
                <form name="MWEBStockDetalleForm" method="POST" action="#">
                    <input type="hidden" name="estadoCalidad" value="">
                    <input type="hidden" name="almacenParticular" value="">
                    <input type="hidden" name="modoDetalle" value="">
                    <input type="hidden" name="codArtPropietarioDetalle" value="">
                    <input type="hidden" name="codArticuloDetalle" value="">
                    <input type="hidden" name="descripcionDetalle" value="">
                    <input type="hidden" name="categoriaDetalle" value="">
                    <input type="hidden" name="cantidadDetalle" value="">
                </form>
            </div>
            <%@include file="../cabecera.inc"%>
    </body>
</html>