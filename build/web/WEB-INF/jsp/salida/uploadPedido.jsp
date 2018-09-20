<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Controlador.ConsultasMnh"%>
<%@page import="Controlador.Consultas"%>
<%@page import="Modelo.Usuario"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.OrdenesEntrada"%>
<%@page import="Modelo.ProductosExcelPedido"%>

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
    String codProvBuscar="";
    String codSeguimiento = request.getParameter("codSeguimiento");
    String codProv = request.getParameter("codProveedor");

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
        <style type="text/css">
            #Topicos_Datatable {
                table-layout: fixed;
                width: 1130px;              
            }

            table.ListaTabla {
                //width: auto;
                border: none;
                font-family: "century gothic", "Lucida Grande", Verdana, Arial, Helvetica, sans-serif;
            }

            div .ListaTabla {
                border: 0px solid lightgray !important;
            }

            .ListaTabla th {
                background-color: #CCFFFF;
                color: #727374;
                font-size: 12px;
                border: 0px solid #D1D0C6;
                border-collapse: collapse;
                font-family: "Century Gothic";
            }

            #Topicos_Datatable {
                table-layout: fixed;
            }

            table.ListaTabla td {
                color: #000;
                font-size: 8pt;
                border: 0px solid #D1D0C6;
                border-collapse: collapse;
            }

            //thead, tbody { display: block; }
            tbody {
                overflow-y: auto;
                overflow-x: hidden;
            }
            thead {
                overflow-y: auto;
                overflow-x: hidden;
            }
        </style>        
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
                Gestión de Pedidos
                <img src="imagenes/icon-bread-crumbs.gif" alt="" /> <a href="#"
                                                                       onclick="irConsultaEntrega();" class="home"> Consulta pedidos
                </a> <img src="imagenes/icon-bread-crumbs.gif" alt="" />
                Upload de Pedidos
            </div>
            <%
                if (vrCargaArticulos!=null)
                {
                    if (vrCargaArticulos=="NO"){%>
                         <div class="dianet-mrg-bottom-15">
                            <div class="dianet-div-align-left"> 
                                <form action="#" method="post" name="MWEBVolverSubirArchivo" >
                                    <br><table cellspacing="1" cellpadding="3" id="DIAnetTableMensaje">
                                     <tr>
                                         <!--<th class="WF370" align="center">&nbsp&nbsp&nbsp&nbsp&nbspEl&nbspproveedor&nbspno&nbspexiste,&nbspfavor&nbspenviar&nbspinformacion&nbsppara&nbspcrearlo</th>-->
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
                }
                %>
            <div class="dianet-mrg-bottom-15" <%=vrEstilo%>>
                <div class="dianet-div-align-left"> 
                    <table cellspacing="1" cellpadding="3" id="DIAnetTableFiltreOrdenes">
                        <tr>
                            <th class="WF130">Formato Archivo de Pedido</th>
                            <th class="WF100" colspan="2">
                                <a href="#" onclick="location.href = 'Formato_Excel_Pedidos.xls'; ">
                                 Descargar Aquí
                                </a>
                            </th>
                        </tr>
                         <tr>
                             <form action="#" method="post" name="MWEBSubirArchivosForm" enctype="multipart/form-data" > 
                             <input type="hidden" name="pagina" value="CargandoArchivo">
                             <input type="hidden" name="rutaexcel" value="">
                             <input type="hidden" name="idcliente" value="">
                             <input type="hidden" name="extension" value="">
                             <th class="WF100">Fichero:</th>
                             <th >
                                 <input type="file" name="fichero" id="fichero" class="boton" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel"/>
                             </th>
                             <th class="WF130"><input type="submit" value="Subir fichero" class="boton" onclick="if (this.form.fichero.value==''){ alert('Debe Seleccionar Archivo'); return false; } else { irSubiendoArchivoPedido(this.form.fichero.value,'CargandoArchivo',<%=id_clte%>); }" /> </th>
                             </form>                     
                         </tr>
                     </table>
                    <%
                    List<ProductosExcelPedido> ListaProductos=null;// = new ArrayList<ProductosExcel>();
                    
                    ListaProductos = (List<ProductosExcelPedido>)session.getAttribute("ListadoArticulos");
                    if (ListaProductos!=null)
                    {
                    %>
                    <div class="scroll-div-tablas" id="TablaContenedor" style="height: 315px;overflow-y: auto;overflow-x: hidden;">
                    <table class="ListaTabla"  id="Topicos_Datatable">
                        <thead id="Topicos_Cabecera_Datos">
                        <tr>
                            <th style="width: 10%;">Número de pedido</th>
                            <th style="width: 10%;">Código de cliente</th>
                            <th style="width: 40%;">Nombre del cliente</th>
                            <th style="width: 10%;">Fecha entrega</th>
                            <th style="width: 10%;">Código artículo</th>
                            <th style="width: 30%;">Descripción</th>
                            <th style="width: 10%;">Cantidad</th>
                            <th style="width: 10%;">Lote</th>
                            <th style="width: 40%;">Observación</th>
                        </tr>
                        </thead>     
                    <tbody id="gtnp_Listado_Datos" style="overflow-y: auto">
                    <%
                    for(int i=0;i<ListaProductos.size();i++){
                    %>
                    <tr>
                        <td><%=ListaProductos.get(i).getNumPedido() %></td>
                        <td><%=ListaProductos.get(i).getRutCliente() %></td>
                        <td><%=ListaProductos.get(i).getNomCliente() %></td>
                        <td><%=ListaProductos.get(i).getFechaEntrega() %></td>
                        <td><%=ListaProductos.get(i).getCodArt()%></td>
                        <td><%=ListaProductos.get(i).getDescripcion()%></td>
                        <td><%=ListaProductos.get(i).getCantidad()%></td>
                        <td><%=ListaProductos.get(i).getLote()%></td>
                        <td align="Center"><%
                        String vrMsg=ListaProductos.get(i).getObservacion().trim();
                        if (vrMsg.length()==2)
                        {%><font color="black">
                            <%=vrMsg%></font>
                        <%}else{%>
                            <font color="red"><%=vrMsg%></font>
                        <%}%>
                        </td>
                    </tr>
                    <%}%>
                    </tbody>                   
                    </table>
                 </div>        
                    <div align="center"><br>
                    <form action="#" method="post" name="MWEBProcesarTablaPedido" enctype="multipart/form-data" > 
                        <input type="submit" value="Procesar" class="boton" onclick="if (confirm('Desea Procesar el Archivo')){ProcesarTablaPedido();}else{ LimpiarPaginaPedido(); }"
                    </form>    
                </div>
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
