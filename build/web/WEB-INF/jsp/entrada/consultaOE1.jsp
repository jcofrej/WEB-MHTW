<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.IOException"%>
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
    LinkedList<OrdenesEntrada> oe = null;
    String codProvBuscar="";
    String codSeguimiento = request.getParameter("codSeguimiento");
    String codMh = request.getParameter("codMh");
    String fechaIni = request.getParameter("fechaIni");
    String fechaFin = request.getParameter("fechaFin");
    String codProv = request.getParameter("codProveedor");
    //String codProvBuscar = request.getParameter("proveedor");
    codProvBuscar=(String)session.getAttribute("proveedor");
    
    if (codProvBuscar == null) {
        codProvBuscar = "";
    }
    session.removeAttribute("proveedor");
    if (codProv == null) {
        codProv = "";
    }
     
     int vrcan=0;
     String vrPagina="";
      if (request.getParameter("pagina")!=null){
          vrPagina = request.getParameter("pagina");
      }

      if (vrPagina.equals("crearExcel"))
      {
        java.util.Calendar fecha = java.util.Calendar.getInstance();
        LinkedList<OrdenesEntrada> vrListEntrada = (LinkedList<OrdenesEntrada>)request.getSession().getAttribute("ListadoEntradas");
        response.setContentType("application/vnd.ms-excel;");
        if(vrListEntrada != null && !vrListEntrada.isEmpty()){
            HSSFWorkbook workBook = new HSSFWorkbook();
            HSSFSheet sheet = workBook.createSheet();
      
            HSSFRow headingRow = sheet.createRow(0);
            
            headingRow.createCell((short)0).setCellValue("Código Seguimiento");
            headingRow.createCell((short)1).setCellValue("Código OE");
            headingRow.createCell((short)2).setCellValue("Código OE MH");
            headingRow.createCell((short)3).setCellValue("Fecha Alta");
            headingRow.createCell((short)4).setCellValue("Tipo");
            headingRow.createCell((short)5).setCellValue("Fecha Caducidad");
            headingRow.createCell((short)6).setCellValue("Estado");
            headingRow.createCell((short)7).setCellValue("Proveedor");
            headingRow.createCell((short)8).setCellValue("Comentario");     

            sheet.setColumnWidth(0, 4500);
            sheet.setColumnWidth(1, 4500);
            sheet.setColumnWidth(2, 4500);
            sheet.setColumnWidth(3, 4500);
            sheet.setColumnWidth(5, 4500);
            sheet.setColumnWidth(6, 4500);
            sheet.setColumnWidth(7, 4500);
            sheet.setColumnWidth(8, 4500);

            for (int x=0;x<=vrListEntrada.size()-1;x++)
            {
                HSSFRow row = sheet.createRow(x+1);

                row.createCell(0).setCellValue(vrListEntrada.get(x).getCodSeguimiento());
                row.createCell(1).setCellValue(vrListEntrada.get(x).getCodIdOE());
                row.createCell(2).setCellValue(vrListEntrada.get(x).getCodOE());
                row.createCell(3).setCellValue(vrListEntrada.get(x).getFechaAlta());
                row.createCell(4).setCellValue(vrListEntrada.get(x).getTipo());
                row.createCell(5).setCellValue(vrListEntrada.get(x).getFechaCaducidad());
                row.createCell(6).setCellValue(vrListEntrada.get(x).getEstado());
                row.createCell(7).setCellValue(vrListEntrada.get(x).getProveedor());
                row.createCell(8).setCellValue(vrListEntrada.get(x).getComentario());
         
            }
      
            try{
            
            
            String vrNomArchivo= "ReporteEntradas" + Integer.toString(fecha.get(java.util.Calendar.YEAR))
                    +  Integer.toString(fecha.get(java.util.Calendar.MONTH)) 
                    +  Integer.toString(fecha.get(java.util.Calendar.DATE)) 
                    +  Integer.toString(fecha.get(java.util.Calendar.HOUR))
                    +  Integer.toString(fecha.get(java.util.Calendar.MINUTE))
                    +  Integer.toString(fecha.get(java.util.Calendar.SECOND))+".xls";
            
            ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
            workBook.write(outByteStream);
            byte [] outArray = outByteStream.toByteArray();
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
            codSeguimiento=null;
                //FileOutputStream fos = new FileOutputStream(file);
               // workBook.write(fos);
                //fos.flush();
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
        <title>Consulta Ordenes de Entrada</title>
        <%@include file="../head.inc"%>
        <script language="JavaScript">
        window.onload = function ()
            {

                //document.forms['MWEBFilterOrdenesForm'].codSeguimiento.value='<%=codSeguimiento %>';
                document.getElementById("proveedor").value='<%=codProvBuscar %>';
               
            }
        </script>
        
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
                    oe = conoe.getOrdenesEntrada(id_clte, codSeguimiento, codMh, fechaIni, fechaFin, codProvBuscar);
                    request.getSession().setAttribute("ListadoEntradas", oe);
                    //DecimalFormat decimales = new DecimalFormat("0");
                    if (oe.size()>0)
                    {
                        vrcan=1;
                    }
                }
            %>	

            <!--  navegación -->
            <div id="DIAnetBreadCrumbs">
                Esta en
                <a href="#" class="home"> Gestión de Ordenes de Entrada
                </a> <img src="imagenes/icon-bread-crumbs.gif" alt="" h />
                Consulta Ordenes de Entrada
               
            </div>


            <form name="MWEBFilterOrdenesForm" method="POST" action="#">
                <input type="hidden" name="pageCurrent" value="">
                <input type="hidden" name="pagina" id="pagina" value="">
                <input type="hidden" name="cantlist" id="cantlist" value="<%=vrcan%>">
                <input type="hidden" name="origen" value="listaoe">
                <!-- ============ Botonera de acciones ============ -->
                <div class="dianet-mrg-bottom-15">
                    <div class="dianet-div-align-left">

                        <input type="button" name="" value="Nueva Orden Entrada" onclick="irNuevaOE('nuevaoe');" class="boton">

                        <input type="button" name="" value="Limpiar búsqueda" onclick="btLimpiarBusqueda();" class="boton">
                        <input type="button" name="" value="Buscar" onclick="btBuscarOE();" class="boton">
                        <input type="button" name="" value="Upload" onclick="irUploadIngreso('uploading');" class="boton">
                        <input type="button" name="" value="Exportar Excel" onclick="if (document.getElementById('cantlist').value>0) {crearExcelEntregas('crearExcel');} else{alert('Debe generar una busqueda con resultados antes de exportar');}" class="boton">
                        <!--<img src="imagenes/Excel_2013_23480.png" width="25" height="15" class="boton" style="vertical-align: middle" onclick="crearExcelEntregas('crearExcel');"/>-->
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
                    Filtrar orden por:
                </p>
                <table cellspacing="1" cellpadding="3" id="DIAnetTableFiltreOrdenes">
                    <tr>
                        <th class="WF170">Código Seguimiento</th>
                        <th class="WF170">Código OE MH</th>
                        <th class="WF80">Desde</th>
                        <!--  onMouseOver="muestraFecha('FIni', event);" onMouseOut="ocultaFecha('FIni');" -->
                        <th class="WF80">Hasta</th>
                        <!--  onMouseOver="muestraFecha('FFin', event);" onMouseOut="ocultaFecha('FFin');" -->
                        <th class="WF130"><a href="#" onclick="irProveedoresOE('irProveedores');">Proveedor</a></th>
                    </tr>
                    <tr>
                        <td><input id="codSeguimiento" name="codSeguimiento"
                                   type="text" style="width: 98%" maxlength="20"
                                   value="" /></td>
                        <td><input id="codGL" name="codMh" type="text"
                                   style="width: 98%" maxlength="20"
                                   value="" /></td>
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

                                   value="<%=codProvBuscar %>" />
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
                    //oe = conoe.getOrdenesEntrada(id_clte, codSeguimiento, codMh, fechaIni, fechaFin, codProvBuscar);
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
                            Listado de Ordenes
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
                                        <th width="150">Código OE</th>
                                        <th width="150">Código OE MH</th>
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

                                    <%
                                        for (int i = 0; i < oe.size(); i++) {

                                    %>

                                    <tr> 
                                        <td class='padding-left-10'><%=oe.get(i).getCodSeguimiento()%></td> 
                                        <td class='padding-left-10'><%=oe.get(i).getCodIdOE()%></td>
                                        <td class='padding-left-10'><%=oe.get(i).getCodOE()%></td>
                                        <td class='padding-left-10'><%=oe.get(i).getFechaAlta()%></td>
                                        <td class='padding-left-10'><%=oe.get(i).getTipo()%></td> 
                                        <td class='padding-left-10'><%=oe.get(i).getFechaCaducidad()%></td> 
                                        <td class='padding-left-10'><%=oe.get(i).getEstado()%></td>
                                        <td class='padding-left-10'><%=oe.get(i).getProveedor()%></td>
                                        <td class='padding-left-10'><%=oe.get(i).getComentario()%></td>
                                        <td class='padding-left-10'><a href="#" onclick="irDetalleOE('<%=oe.get(i).getCodOE()%>');">Consultar</a></td> 
                                    </tr>
                                    <%
                                        }
                                        //oe.clear();
                                    } else {
                                    %><table>



                                    <tr>
                                        <td>
                                            <p class="dianet-content-listado">
                                                Listado de Ordenes
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