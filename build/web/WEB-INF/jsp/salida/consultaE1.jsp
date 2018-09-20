<%@page import="java.util.Date"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="Modelo.Pedidos"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Controlador.ConsultasMnh"%>
<%@page import="Controlador.Consultas"%>
<%@page import="Modelo.Usuario"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.OrdenesEntrada"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
    String msg = (String)session.getAttribute("msg");
    if(msg!=null){
    %>
        <script language="JavaScript">
            alert('<%=msg %>');
        </script>
    <%
    }
    session.removeAttribute("msg");
    msg="";
    LinkedList<Pedidos> oe = null;

    String codSeguimiento = request.getParameter("codSeguimiento");
    String codMh = request.getParameter("codMh");
    String fechaIni = request.getParameter("fechaIni");
    String fechaFin = request.getParameter("fechaFin");
    String codProv = request.getParameter("codProveedor");
    String codProvBuscar = request.getParameter("proveedor");
    if (codProv == null) {
        codProv = "";
    }
    if (codProvBuscar == null) {
        codProvBuscar = "";
    }
    
    // public void ExportarExcel( ArrayList<Pedidos> vrListPedidos,HttpServletResponse response){
    int vrcan=0;
      String vrPagina="";
      if (request.getParameter("pagina")!=null){
          vrPagina = request.getParameter("pagina");
      }

      if (vrPagina.equals("crearExcel"))
      {
        java.util.Calendar fecha = java.util.Calendar.getInstance();
        LinkedList<Pedidos> vrListPedidos = (LinkedList<Pedidos>) request.getSession().getAttribute("LitadoPedidos");
        response.setContentType("application/vnd.ms-excel;");
        if(vrListPedidos != null && !vrListPedidos.isEmpty()){
            HSSFWorkbook workBook = new HSSFWorkbook();
            HSSFSheet sheet = workBook.createSheet();
            HSSFRow headingRow = sheet.createRow(0);

            headingRow.createCell((short)0).setCellValue("Código Seguimiento");
            headingRow.createCell((short)1).setCellValue("Código Pedido MH");
            headingRow.createCell((short)2).setCellValue("Fecha Alta");
            headingRow.createCell((short)3).setCellValue("Tipo");
            headingRow.createCell((short)4).setCellValue("Fecha Caducidad");
            headingRow.createCell((short)5).setCellValue("Estado");
            headingRow.createCell((short)6).setCellValue("Cliente");
            headingRow.createCell((short)7).setCellValue("Comentario");    

            sheet.setColumnWidth(0, 4500);
            sheet.setColumnWidth(1, 4500);
            sheet.setColumnWidth(2, 4500);
            sheet.setColumnWidth(4, 4500);
            sheet.setColumnWidth(5, 4500);
            sheet.setColumnWidth(6, 4500);
            sheet.setColumnWidth(7, 4500);

            for (int x=0;x<=vrListPedidos.size()-1;x++)
            {
                HSSFRow row = sheet.createRow(x+1);;
                row.createCell(0).setCellValue(vrListPedidos.get(x).getCodSeguimiento());
                row.createCell(1).setCellValue(vrListPedidos.get(x).getCodOE());
                row.createCell(2).setCellValue(vrListPedidos.get(x).getFechaAlta());
                row.createCell(3).setCellValue(vrListPedidos.get(x).getTipo());
                row.createCell(4).setCellValue(vrListPedidos.get(x).getFechaCaducidad());
                row.createCell(5).setCellValue(vrListPedidos.get(x).getEstado());
                row.createCell(6).setCellValue(vrListPedidos.get(x).getProveedor());
                row.createCell(7).setCellValue(vrListPedidos.get(x).getComentario());
         
            }
      
            try{
            
            
            String vrNomArchivo= "ReportePedidos" + Integer.toString(fecha.get(java.util.Calendar.YEAR))
                    +  Integer.toString(fecha.get(java.util.Calendar.MONTH)) 
                    +  Integer.toString(fecha.get(java.util.Calendar.DATE)) 
                    +  Integer.toString(fecha.get(java.util.Calendar.HOUR))
                    +  Integer.toString(fecha.get(java.util.Calendar.MINUTE))
                    +  Integer.toString(fecha.get(java.util.Calendar.SECOND))+".xls";
            
            ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
            workBook.write(outByteStream);
            byte [] outArray = outByteStream.toByteArray();
            //response.setContentType("application/ms-excel");
            //response.setContentLength(outArray.length);
            //response.setHeader("Expires:", "0"); // eliminates browser caching
            response.setHeader("Content-Disposition", "attachment; filename="+vrNomArchivo);
            OutputStream outStream = response.getOutputStream();
            outStream.write(outArray);
            outStream.flush();
            outStream.close();
            outArray=null;
            outByteStream.close();
            sheet=null;
            workBook=null;
            response.resetBuffer();
            response.reset();

            }catch(FileNotFoundException e){
                e.printStackTrace();
                System.out.println("Invalid directory or file not found");
            }catch(IOException e){
                e.printStackTrace();
                System.out.println("Error occurred while writting excel file to directory");
            }
        }
    }

%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Consulta Pedidos</title>
       
        <%@include file="../head.inc"%>
        <SCRIPT LANGUAGE="JavaScript">

            var calFechaIni = new CalendarPopup("testdiv1", 'es');
            calFechaIni.setCssPrefix("TEST");

            var calFechaFin = new CalendarPopup("testdiv1", 'es');
            calFechaFin.setCssPrefix("TEST");

            function mostrarMensajes() {

            }
            
            function muestraFecha(id, event) {
                document.getElementById(id).style.display = "";
                document.getElementById(id).style.left = event.clientX + "px";
                document.getElementById(id).style.top = event.clientY + "px";
            }

            function ocultaFecha(id) {
                document.getElementById(id).style.display = "none";
            }

            var txtCamposVacios = "Debe especificarse algún criterio de búsqueda";
            var txtRangoError = "El rango de fechas especificado no es correcto";
            var txtFhInicialError = "La fecha inicial es incorrecta";
            var txtFhFinalError = "La fecha final es incorrecta";
            var txtFechasIncompletas = "Si desea filtrar por fecha, ha de especificar un rango";

        </script>


    </head>


    <body onLoad="mostrarMensajes();">

        <!-- Division principal -->
        <div id="DIAnetContainer">
            <div id="DIAnetClearHeader"></div>
            <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

            <%@include file="../menu.inc"%>
           <%

                if (codSeguimiento != null) {
                    Consultas id_clt = new Consultas();
                    String id_clte = id_clt.getUsuarioWeb(usuario);

                    ConsultasMnh conoe = new ConsultasMnh();
                    oe = conoe.getPedidos(id_clte, codSeguimiento, codMh, fechaIni, fechaFin, codProvBuscar);
                    request.getSession().setAttribute("LitadoPedidos", oe);
                    request.getSession().setAttribute("ListadoArticulos", null);
                    
                    if (oe.size()>0)
                    {
                        vrcan=1;
                    }
                }
            %>	
            <!--  navegación -->
            <div id="DIAnetBreadCrumbs">
                Esta en
                <a href="#" class="home"> Gestión de pedidos
                </a> <img src="imagenes/icon-bread-crumbs.gif" alt="" h />
                Consulta pedidos
            </div>


            <form name="MWEBFilterOrdenesForm" method="POST" action="#">
                <input type="hidden" name="pageCurrent" value="">
                <input type="hidden" name="pagina" value="">
                <input type="hidden" name="cantlist" id="cantlist" value="<%=vrcan%>">
                <input type="hidden" name="origen" value="listaoe">
                <!-- ============ Botonera de acciones ============ -->
                <div class="dianet-mrg-bottom-15">
                    <div class="dianet-div-align-left">

                        <input type="button" name="" value="Nuevo Pedido" onclick="irNuevaEntrega('nuevaep');" class="boton">
                        <input type="button" name="" value="Limpiar búsqueda" onclick="btLimpiarBusquedaEntrega();" class="boton">
                        <input type="button" name="" value="Buscar" onclick="btBuscarOE();" class="boton">
                        <input type="button" name="" value="Upload" onclick="irNuevaEntrega('uploading');" class="boton">
                        <input type="button" name="" value="Exportar Excel" onclick="if (document.getElementById('cantlist').value>0) {crearExcelPedidos('crearExcel');} else{alert('Debe generar una busqueda con resultados antes de exportar');}" class="boton">
                        <!--<img src="imagenes/Excel_2013_23480.png" width="25" height="15" class="boton" style="vertical-align: middle" onclick="crearExcelPedidos('crearExcel');"/>-->
                        <!--<input type="button" name="" class="boton"
                               value="Imprimir"
                               onclick="alert('No se ha podido realizar la impresion de las ordenes de entrada, ya que no hay ninguna');">-->

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
                    Filtrar pedidos por:
                </p>
                <table cellspacing="1" cellpadding="3" id="DIAnetTableFiltreOrdenes">
                    <tr>
                        <th class="WF170">Código Seguimiento</th>
                        <th class="WF170">Código Pedido</th>
                        <th class="WF80">Desde</th>
                        <!--  onMouseOver="muestraFecha('FIni', event);" onMouseOut="ocultaFecha('FIni');" -->
                        <th class="WF80">Hasta</th>
                        <!--  onMouseOver="muestraFecha('FFin', event);" onMouseOut="ocultaFecha('FFin');" -->
                        <th class="WF130"><a href="#" onclick="irClientesEntrega('irClientes');">Cliente</a></th>
                    </tr>
                    <tr>
                        <td><input id="codSeguimiento" name="codSeguimiento"
                                   type="text" style="width: 98%" maxlength="20"
                                   value="" /></td>
                        <td><input id="codGL" name="codMh" type="text"
                                   style="width: 98%" maxlength="20"
                                   " value="" /></td>
                        <td><input id="fechaIni" name="fechaIni" type="text"
                                   onclick="calFechaIni.select(document.forms['MWEBFilterOrdenesForm'].fechaIni, 'fechaIni', 'dd/MM/yyyy');
                                                        return false;"
                                   style="width: 70px;"
                                   value="" /></td>
                        <td><input id="fechaFin" name="fechaFin" type="text"
                                   onclick="calFechaFin.select(document.forms['MWEBFilterOrdenesForm'].fechaFin, 'fechaFin', 'dd/MM/yyyy');
                                                        return false;"
                                   style="width: 70px;"
                                   value="" /></td>
                        <td> 
                            <input id="proveedor" name="proveedor" type="text"
                                   style="width: 98%" maxlength="15"
                                   value="<%=codProvBuscar%>" />
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
            <%

                if (codSeguimiento != null) {
                    //Consultas id_clt = new Consultas();
                    //String id_clte = id_clt.getUsuarioWeb(usuario);

                    //ConsultasMnh conoe = new ConsultasMnh();
                    //oe = conoe.getPedidos(id_clte, codSeguimiento, codMh, fechaIni, fechaFin, codProvBuscar);
                  //  request.getSession().setAttribute("LitadoPedidos", oe);
                    DecimalFormat decimales = new DecimalFormat("0");
            %>	
            <table id="page" cellpadding="3" cellspacing="5">
                <tr>
                    <!- numero de registros -->
                    <td class="dianet-nav-listado">N. Registros <span> <%=oe.size()%>
                        </span></td>
                    <!- numero de páginas -->
                    <td class="dianet-nav-listado">N. Páginas <%=decimales.format(Math.ceil((double) oe.size() / (double) 10))%> </td>
                    <!- primera pag -->
                    <td><a class="dianet-nav-listado" id="pageFist"
                           onclick="irPage(0, 'DIAnetTableListadoOrdenes', '');
                                                       return false;"
                           href="#">&lsaquo;&lsaquo;</a></td>
                    <!- anterior pag -->
                    <td><a class="dianet-nav-listado" id="pagePrevious"
                           onclick="irPage('previous', 'DIAnetTableListadoOrdenes', '');
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
                           onclick="irPage('next', 'DIAnetTableListadoOrdenes', '');
                                                       return false;"
                           href="#">&rsaquo;</a></td>
                    <!- ultima pag -->
                    <td><a class="dianet-nav-listado"
                           onclick="irPage(2 - 1, 'DIAnetTableListadoOrdenes', '');
                                                       return false;"
                           href="#">&raquo;</a></td>

                </tr>
            </table>
            <table>
                <tr>
                    <td>
                        <p class="dianet-content-listado">
                            Listado de Pedidos
                        </p>
                    </td>
                </tr>
                <tr>
                    <td><form name="MWEBAccionOEForm" method="POST" action="#">
                            <input type="hidden" name="codigoOE" value="">
                            <input type="hidden" name="pageCurrent" value="">


                            <table id="DIAnetTableListadoOrdenes"
                                   class="table-autopage:10"
                                   cellspacing="1" cellpadding="3">


                                <thead id="orderHead">
                                    <tr>
                                        <th width="70">Código Seguimiento</th>
                                        <th width="150">Código Pedido MH</th>
                                        <th width="70">Fecha Alta</th>
                                        <th width="70">Tipo</th>
                                        <th width="70">Fecha Caducidad</th>
                                        <th width="85">Estado</th>
                                        <th width="70">Cliente</th>
                                        <th width="120">Comentario</th>
                                        <th width="75">Acción</th>
                                    </tr>
                                </thead>
                                <tbody id="orderBody">

                                    <%
                                        for (int i = 0; i < oe.size(); i++) {

                                    %>

                                    <tr> 
                                        <td class='padding-left-10'><%=oe.get(i).getCodSeguimiento()%></td> 
                                        <td class='padding-left-10'><%=oe.get(i).getCodOE()%></td>
                                        <td class='padding-left-10'><%=oe.get(i).getFechaAlta()%></td>
                                        <td class='padding-left-10'><%=oe.get(i).getTipo()%></td> 
                                        <td class='padding-left-10'><%=oe.get(i).getFechaCaducidad()%></td> 
                                        <td class='padding-left-10'><%=oe.get(i).getEstado()%></td>
                                        <td class='padding-left-10'><%=oe.get(i).getProveedor()%></td>
                                        <td class='padding-left-10'><%=oe.get(i).getComentario()%></td>
                                        <td class='padding-left-10'><a href="#" onclick="irDetalleEntrega('<%=oe.get(i).getCodOE()%>');">Consultar</a></td> 
                                    </tr>
                                    <%
                                        }
                                    } else {
                                    %><table>



                                    <tr>
                                        <td>
                                            <p class="dianet-content-listado">
                                                Listado de Pedidos
                                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><form name="MWEBAccionOEForm" method="POST" action="#">
                                                <input type="hidden" name="codigoOE" value="">
                                                <input type="hidden" name="pageCurrent" value="">


                                                <table id="DIAnetTableListadoOrdenes"
                                                       class="table-autopage:10"
                                                       cellspacing="1" cellpadding="3">


                                                    <thead id="orderHead">
                                                        <tr>
                                                            <th width="70">Código Seguimiento</th>
                                                            <th width="150">Código Pedido MH</th>
                                                            <th width="70">Fecha Alta</th>
                                                            <th width="70">Tipo</th>
                                                            <th width="70">Fecha Caducidad</th>
                                                            <th width="85">Estado</th>
                                                            <th width="70">Cliente</th>
                                                            <th width="120">Comentario</th>
                                                            <th width="75">Acción</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="orderBody">
                                                        <tr>
                                                            <td class='padding-left-10' colspan='9'>No hay ningún resultado</td>
                                                        <tr>
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
