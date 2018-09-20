<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Controlador.ConsultasMnh"%>
<%@page import="Controlador.Consultas"%>
<%@page import="Modelo.Usuario"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.OrdenesEntrada"%>
<%@page import="Modelo.ProductosExcel"%>

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
    String vrEstilo="";
    session.removeAttribute("msg");
    msg="";
    LinkedList<OrdenesEntrada> oe = null;
    String codProvBuscar="";
    String codSeguimiento = request.getParameter("codSeguimiento");
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

    String vrPagina = request.getParameter("pagina");
    if (vrPagina!=null)
    {
        if (vrPagina.length()==9)
        {
            request.getSession(false).removeAttribute("ListadoArticulos");
        }
    }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Upload Ingreso</title>
        
        <%@include file="../head.inc"%>
        
         <script language="JavaScript">
        window.onload = function ()
            {

                //document.forms['MWEBFilterOrdenesForm'].codSeguimiento.value='<%=codSeguimiento %>';
                //document.getElementById("proveedor").value='<%=codProvBuscar %>';
               
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
        <div id="DIAnetContainer">
            <div id="DIAnetClearHeader"></div>
            <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

            <%@include file="../menu.inc"%>
            <%
                Consultas id_clt = new Consultas();
                String id_clte = id_clt.getUsuarioWeb(usuario);
                request.getSession().setAttribute("idcliente2", id_clte);
                String vrCargaArticulos=(String)request.getSession().getAttribute("CargaArticulos");
            %>
            <!--  navegación -->
            <div id="DIAnetBreadCrumbs">
               Esta en
                Gestión de Ordenes de Entrada
                <img src="imagenes/icon-bread-crumbs.gif" alt="" /> <a href="#"
                                                                       onclick="irConsultaOrdenesEntrada();" class="home"> Consulta Ordenes de Entrada
                </a> <img src="imagenes/icon-bread-crumbs.gif" alt="" />
                Upload de Ingreso
            </div>
            <%
                if (vrCargaArticulos=="NO"){%>
                     <div class="dianet-mrg-bottom-15">
                        <div class="dianet-div-align-left"> 
                            <form action="#" method="post" name="MWEBVolverSubirArchivo" enctype="multipart/form-data" >
                                <br><table cellspacing="1" cellpadding="3" id="DIAnetTableMensaje">
                                 <tr>
                                     <th class="WF370" align="center">&nbsp&nbsp&nbsp&nbsp&nbspEl&nbspproveedor&nbspno&nbspexiste,&nbspfavor&nbspenviar&nbspinformacion&nbsppara&nbspcrearlo</th>
                                 </tr>
                                 <tr><th></th> </tr>
                                 <tr>
                                     <th class="WF370"><input type="submit" value="Volver" class="boton" onclick="LimpiarUploadIngreso();" /> 
                                 </tr>
                            </table>
                            </form>  
                        </div>
                    </div>
                 <%
                     vrEstilo="style='display:none";
                     request.getSession(false).removeAttribute("CargaArticulos");
                }
                %>
            <div class="dianet-mrg-bottom-15" <%=vrEstilo%>>
                <div class="dianet-div-align-left"> 
                    <table cellspacing="1" cellpadding="3" id="DIAnetTableFiltreOrdenes">
                        <tr>
                            <th class="WF100">Formato Archivo de Entrada</th>
                            <th class="WF100" colspan="2">
                                <a href="#" onclick="location.href = 'Formato_Excel_Ingresos.xls'; ">
                                 Descargar Aquí
                                </a>
                            </th>
                        </tr>
                         <tr>
                             <form action="#" method="post" name="MWEBSubirArchivosForm" enctype="multipart/form-data" > 
                             <input type="hidden" name="pagina" value="CargandoArchivo">
                             <input type="hidden" name="rutaexcel" value="">
                             <input type="hidden" name="idcliente" value="">
                             <th class="WF170">Fichero:</th>
                             <th >
                                 <input type="file" name="fichero" class="boton" accept="application/vnd.ms-excel"/>
                             </th>
                             <th class="WF130"><input type="submit" value="Subir fichero" class="boton" onclick="if (this.form.fichero.value==''){ alert('Debe Seleccionar Archivo'); return false; } else { irSubiendoArchivo(this.form.fichero.value,'CargandoArchivo',<%=id_clte%>); }" /> </th>
                             </form>                     
                         </tr>
                     </table>
                    <%
                    List<ProductosExcel> ListaProductos=null;// = new ArrayList<ProductosExcel>();
                    
                    ListaProductos = (List<ProductosExcel>)session.getAttribute("ListadoArticulos");
                    if (ListaProductos!=null)
                    {
                    %>
                    <table id="DIAnetTableFiltreOrdenes">
                        <tr>
                            <th class="WF80">Código&nbspProveedor</th>
                            <th class="WF100">Código&nbspSeguimiento</th>
                            <th class="WF80">Fecha&nbspEsperada</th>
                            <th class="WF80">Código&nbspArticulo</th>
                            <th class="WF80">Lote</th>
                            <th class="WF170">Descripción</th>
                            <th class="WF80">Cantidad</th>
                            <th class="WF170">Observación</th>
                        </tr>
                    <%
                    for(int i=0;i<ListaProductos.size();i++){
                    %>
                    <tr>
                        <td><%=ListaProductos.get(i).getCodProv()%></td>
                        <td><%=ListaProductos.get(i).getCodSeg()%></td>
                        <td><%=ListaProductos.get(i).getFechaIngreso() %></td>
                        <td><%=ListaProductos.get(i).getCodArt()%></td>
                        <td><%=ListaProductos.get(i).getLote()%></td>
                        <td><%=ListaProductos.get(i).getDescripcion()%></td>
                        <td><%=ListaProductos.get(i).getCantidad()%></td>
                        <td><%=ListaProductos.get(i).getObservacion() %></td>
                    </tr>
                    <%}%>
                    <tr>
                        <td colspan="8" style="text-align: center" > 
                        
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8" style="text-align: center" > 
                        <form action="#" method="post" name="MWEBProcesarTablaIngreso" enctype="multipart/form-data" > 
                            <input type="submit" value="Procesar" class="boton" onclick="if (confirm('Desea Procesar el Archivo')){ProcesarTabla();}else{ LimpiarPagina(); }"
                        </form>    
                        </td>
                    </tr>
                    </table>
                    <%
                        //request.getSession(false).removeAttribute("ListadoArticulos");
                     }
                    %>
                </div>
            </div>
        </div>
      </div>
      <%@include file="../cabecera.inc"%>
    </body>
</html>
