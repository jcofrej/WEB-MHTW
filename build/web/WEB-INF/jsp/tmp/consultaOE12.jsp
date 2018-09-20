<%@page import="Controlador.ConsultasMnh"%>
<%@page import="Controlador.Consultas"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.OrdenesEntrada"%>
<%@page import="Modelo.Usuario"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0050)http://localhost:808/WEB-MH/PaginaMenuGestionOE.do -->
<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Consulta Ordenes de Entrada</title>
        <!--aqui va los formatos-->
        <%@include file="../head.inc"%>
        <script language="JavaScript">
            var calFechaIni = new CalendarPopup("testdiv1", 'es');
                    calFechaIni.setCssPrefix("TEST");
                    var calFechaFin = new CalendarPopup("testdiv1", 'es');
                    calFechaFin.setCssPrefix("TEST");
                    function mostrarMensajes(){
                    < logic:messagesPresent >
                            < html:messages id = "error" >
                            alert("<bean:write name="error"/>");
                            < /html:messages> 
                            < /logic:messagesPresent>
                            < logic:messagesPresent  message = "true" >
                            alert("<html:messages id="message" message="true"><bean:write name="message"/></html:messages>");
                            < /logic:messagesPresent> 
                    }

            function muestraFecha(id, event){
            document.getElementById(id).style.display = "";
                    document.getElementById(id).style.left = event.clientX + "px";
                    document.getElementById(id).style.top = event.clientY + "px";
            }

            function ocultaFecha(id){
            document.getElementById(id).style.display = "none";
            }


            var txtCamposVacios = "Debe especificarse algún criterio de búsqueda";
                    var txtRangoError = "El rango de fechas especificado no es correcto";
                    var txtFhInicialError = "La fecha inicial es incorrecta";
                    var txtFhFinalError = "La fecha final es incorrecta";
                    var txtFechasIncompletas = "Si desea filtrar por fecha, ha de especificar un rango";        </script>


    </head>



    <body onload="mostrarMensajes();">

        <!-- Division principal -->
        <div id="DIAnetContainer">
            <div id="DIAnetClearHeader"></div>










            <div id="DIAnetContainerContentLeft">

                <div style="padding: 5px; border-bottom: 1px solid #fff;">
                    <div class="dianet-div-align-left">
                        <p style="font-size: 12px">

                            <%
                                LinkedList<OrdenesEntrada> oe;
                                Usuario usu = (Usuario) session.getAttribute("usuario");
                                String codSeguimiento = request.getParameter("codSeguimiento");
                                String usuario = usu.getNombre().toUpperCase();
                            %>
                            <%= usuario%>

                        </p>
                    </div>

                    <div class="dianet-div-align-right">
                        <form action="#" style="margin: 0px;">
                            <input type="text" style="font-size: 12px; border: 0px; text-align: right; background-color: transparent" id="fechaActualId">
                        </form>
                    </div>

                    <div class="dianet-div-clear"></div>

                    <div class="">
                        <form name="CerrarSesion" action="cerrarSesion.do" method="post">
                            <input id="Salir" class="boton" type="submit" style="width: 190px;" onclick="" value="Logout" name="Logout">
                        </form>
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
                                        var myYear = myDate.getFullYear();
                                        var myMonth = (myDate.getMonth() + 1) + '';
                                        var myDay = myDate.getDate() + '';
                                        var myHour = myDate.getHours() + '';
                                        var myMinute = myDate.getMinutes() + '';
                                        if (myMonth.length == 1)  myMonth = '0' + myMonth;
                                        if (myDay.length == 1)    myDay = '0' + myDay;
                                        if (myHour.length == 1)   myHour = '0' + myHour;
                                        if (myMinute.length == 1) myMinute = '0' + myMinute;
                                        var myDateString = myDay + '/' + myMonth + '/' + myYear + ' ' + myHour + ':' + myMinute;
                                        document.getElementById('fechaActualId').value = myDateString;
                                } // gDispDate
                        gDispDate();
                                window.setInterval('gDispDate()', 1000);            </script>

            <!--  navegación -->
            <div id="DIAnetBreadCrumbs">
                Esta en
                <a href="ordenesServlet.do#" class="home"> Gestión de Ordenes de Entrada
                </a> <img src="imagenes/icon-bread-crumbs.gif" alt="" h="">
                Consulta Ordenes de Entrada
            </div>


            <form name="MWEBFilterOrdenesForm" method="POST" action="#">
                <input type="hidden" name="pageCurrent" value="">
                <!-- ============ Botonera de acciones ============ -->
                <div class="dianet-mrg-bottom-15">
                    <div class="dianet-div-align-left">

                        <input type="button" name="" value="Nueva Orden Entrada" onclick="irNuevaOE();" class="boton">


                        <input type="button" name="" value="Limpiar búsqueda" onclick="btLimpiarBusqueda();" class="boton">
                        <input type="button" name="" value="Buscar" onclick="btBuscarOE();" class="boton">




                        <input type="button" name="" class="boton" value="Imprimir" onclick="alert('No se ha podido realizar la impresion de las ordenes de entrada, ya que no hay ninguna');">



                    </div>
                </div>
                <br>


                <!-- ============ Formulario de filtro ============ -->
                <!-- texto a mostrar de ayuda -->
                <div style="display: none; background: yellow; width: 150px; border: 5px solid gray; position: absolute; left: 450px; top: 150px; z-index: 2000; text-align: center;" id="FIni">
                    Desde
                </div>
                <div style="display: none; background: yellow; width: 150px; border: 5px solid gray; position: absolute; left: 450px; top: 150px; z-index: 2000; text-align: center;" id="FFin">
                    Hasta 
                </div>
                <p class="dianet-content-last-update">
                    Filtrar orden por:
                </p>
                <table cellspacing="1" cellpadding="3" id="DIAnetTableFiltreOrdenes">
                    <tbody><tr>
                            <th class="WF170">Código Seguimiento</th>
                            <th class="WF170">Código OE</th>
                            <th class="WF80">Desde</th>
                            <!--  onMouseOver="muestraFecha('FIni', event);" onMouseOut="ocultaFecha('FIni');" -->
                            <th class="WF80">Hasta</th>
                            <!--  onMouseOver="muestraFecha('FFin', event);" onMouseOut="ocultaFecha('FFin');" -->
                            <th class="WF130"><a href="ordenesServlet.do?pag=irProveedores"  onclick="irProveedoresOE();">Proveedor</a></th>
                        </tr>
                        <tr>
                            <td><input id="codSeguimiento" name="codSeguimiento" type="text" style="width: 98%" maxlength="20" value=""></td>
                            <td><input id="codGL" name="codGL" type="text" style="width: 98%" maxlength="20" value=""></td>
                            <td><input id="fechaIni" name="fechaIni" type="text" onclick="calFechaIni.select(document.forms['MWEBFilterOrdenesForm'].fechaIni, 'fechaIni', 'dd/MM/yyyy'); return false;" style="width: 70px;" value=""></td>
                            <td><input id="fechaFin" name="fechaFin" type="text" onclick="calFechaFin.select(document.forms['MWEBFilterOrdenesForm'].fechaIni, 'fechaIni', 'dd/MM/yyyy'); return false;" style="width: 70px;" value=""></td>
                            <td> 
                                <input id="proveedor" name="proveedor" type="text" style="width: 98%" maxlength="15" value="">
                            </td>
                        </tr>

                    </tbody></table>
            </form>
            <script type="text/javascript" language="JavaScript">
                                <!--
              var focusControl = document.forms["MWEBFilterOrdenesForm"].elements["codSeguimiento"];
                                if (focusControl != null && focusControl.type != "hidden" && !focusControl.disabled && focusControl.style.display != "none") {
                        focusControl.focus();
                        }
                        // -->
            </script>

            <br>

            <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; left: 39px; top: 1040px;"></div>

            <!-- ============ Tabla con el contenido + navegacion ============ -->
            <table>

            <%

                if (codSeguimiento != null) {
                    Consultas id_clt = new Consultas();
                    String id_clte = id_clt.getUsuarioWeb(usuario);

                    ConsultasMnh conoe = new ConsultasMnh();
                    oe = conoe.getOrdenesEntrada(id_clte);

            %>





                <tr>
                <table><tr>
                        <td>
                            <div class="dianet-div-align-right">
                                <table id="page" cellpadding="3" cellspacing="5">
                                    <tr>
                                        <!- numero de registros -->
                                        <td class="dianet-nav-listado">N. Registros <span> <%=oe.size()%>
                                            </span></td>
                                        <!- numero de páginas -->
                                        <td class="dianet-nav-listado">N. Páginas <%=oe.size()/10 %></td>
                                        <!- primera pag -->
                                        <td><a class="dianet-nav-listado" id="pageFist"
                                               onclick="irPage(0, 'DIAnetTableListadoOrdenes', ''); return false;"
                                               href="#">&lsaquo;&lsaquo;</a></td>
                                        <!- anterior pag -->
                                        <td><a class="dianet-nav-listado" id="pagePrevious"
                                               onclick="irPage('previous', 'DIAnetTableListadoOrdenes', ''); return false;"
                                               href="#">&lsaquo;</a></td>












                                        <td id="page1"
                                            class="dianet-nav-listado-selected">
                                            <a style="color: rgb(0,0,0)"
                                               onclick="irPage(0, 'DIAnetTableListadoOrdenes', ''); return false;"
                                               href="#">1</a></td>





                                        <td id="page2"
                                            class="dianet-nav-listado">
                                            <a style="color: rgb(0,0,0)"
                                               onclick="irPage(1, 'DIAnetTableListadoOrdenes', ''); return false;"
                                               href="#">2</a></td>






                                        <!- siguiente pag -->
                                        <td><a class="dianet-nav-listado" id="pagePrevious"
                                               onclick="irPage('next', 'DIAnetTableListadoOrdenes', ''); return false;"
                                               href="#">&rsaquo;</a></td>
                                        <!- ultima pag -->
                                        <td><a class="dianet-nav-listado"
                                               onclick="irPage(2 - 1, 'DIAnetTableListadoOrdenes', ''); return false;"
                                               href="#">&raquo;</a></td>

                                    </tr>
                                </table>


                                <table id="TABLE_1">



                                    <tbody><tr>
                                            <td>
                                                <p class="dianet-content-listado">
                                                    Listado de Ordenes
                                                </p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><form name="MWEBAccionOEForm" method="POST" action="consultadetalleoe.do">
                                                    <input type="hidden" name="codigoOE" value="">
                                                    <input type="hidden" name="pageCurrent" value="">


                                                    <table id="DIAnetTableListadoOrdenes" class="table-autopage:10" cellspacing="1" cellpadding="3">


                                                        <thead id="orderHead">
                                                            <tr>
                                                                <th width="70" class="">Código Seguimiento</th>
                                                                <th width="150" class="">Código OE</th>
                                                                <th width="70" class="">Fecha Alta</th>
                                                                <th width="70" class="">Tipo</th>
                                                                <th width="70" class="">Fecha Caducidad</th>
                                                                <th width="85" class="">Estado</th>
                                                                <th width="70" class="">Proveedor</th>
                                                                <th width="120" class="">Comentario</th>
                                                                <th width="75" class="">Acción</th>
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
                                                                <td class='padding-left-10'><a href="#" onclick="irDetalleOE('<%=oe.get(i).getCodOE()%>');">Consultar</a></td> 
                                                            </tr>
                                                            <%
                                                                }
                                                            } else {
                                                            %>
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
                                    </tbody></table>




                                <div id="DIAnetContainerHeader">
                                    <table width="100%" id="TABLE_2">
                                        <tbody><tr>
                                                <td width="150" align="center" valign="top"><img height="75" src="imagenes/logo_Cliente.png">
                                                </td>
                                                <td align="center"><div style="color: #FFFFFF; font-size: 24px;">WEB-MHTW</div></td>
                                                <td width="150" align="center">
                                                    <!-- 			<img height="75" -->

                                                </td>
                                            </tr>
                                        </tbody></table>
                                </div>




                            </div><div id="extension-kmmojbkhfhninkelnlcnliacgncnnikf-installed"></div></body></html>