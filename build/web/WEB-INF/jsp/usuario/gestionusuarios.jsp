
<%@page import="Modelo.Usuarios"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.LinkedList"%>
<%
    LinkedList<Usuarios> oe = null;
    String codSeguimiento = request.getParameter("codSeguimiento");
    
    String msg = (String)session.getAttribute("msg");
    if(msg!=null){
    %>
        <script language="JavaScript">
            alert('<%=msg %>');
        </script>
    <%
        session.removeAttribute("msg");
        msg="";
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Gestion de Usuarios</title>
        <%@include file="../head.inc"%>
       
    </head>

    <body>

        <!-- Division principal -->
        <div id="DIAnetContainer">
            <div id="DIAnetClearHeader"></div>
            <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

            <%@include file="../menu.inc"%>
            <%
                if (codSeguimiento != null) {
        
                    Consultas conoe = new Consultas();

                    oe = conoe.getListadoUsuariosWeb();
                    request.getSession().setAttribute("ListadoUsuarios", oe);
        
                }
            %>	
            <!--  navegación -->
            <div id="DIAnetBreadCrumbs">
                Esta en
                <a href="#" class="home"> Gestión de Usuarios
                </a> <img src="imagenes/icon-bread-crumbs.gif" alt="" h />
                Consulta de Usuarios
               
            </div>
            
            <form name="MWEBFilterOrdenesForm" method="POST" action="#">
                <input type="hidden" name="pageCurrent" value="">
                <input type="hidden" name="pagina" id="pagina" value="">
                <input type="hidden" name="origen" value="listaoe">
                <!-- ============ Botonera de acciones ============ -->
                <div class="dianet-mrg-bottom-15">
                    <div class="dianet-div-align-left">

                        <input type="button" name="" value="Nuevo Usuario" onclick="irNuevoUsuario('NuevoUsuario');" class="boton">

                        <input type="button" name="" value="Limpiar búsqueda" onclick="btLimpiarBusquedaUsuarios();" class="boton">
                        <input type="button" name="" value="Buscar" onclick="btBuscarOE();" class="boton">

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
                        <th class="WF170">Usuario</th>
                        <th class="WF170">Nombre</th>
                        <th class="WF80">Id Cliente</th>
                    </tr>
                    <tr>
                        <td><input id="usuario" name="usuario"
                                   type="text" style="width: 98%" maxlength="20"
                                   value="" /></td>
                        <td><input id="nombre" name="nombre" type="text"
                                   style="width: 98%" maxlength="20"
                                   value="" /></td>
                        <td><input id="idcliente" name="idcliente" type="text"
                                   style="width: 70px;"  value="" /></td>
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
                                        <th width="70">Usuario</th>
                                        <th width="150">Nombre</th>
                                        <th width="150">Id Cliente</th>
                                        <th width="150">Tipo Usuario</th>
                                        <th width="75">Acción</th>
                                    </tr>
                                </thead>
                                <tbody id="orderBody">

                                    <%
                                        for (int i = 0; i < oe.size(); i++) {

                                    %>

                                    <tr> 
                                        <td class='padding-left-10'><%=oe.get(i).getNombre() %></td> 
                                        <td class='padding-left-10'><%=oe.get(i).getDescripcion()  %></td>
                                        <td class='padding-left-10'><%=oe.get(i).getIdCliente()  %></td>
                                        <td class='padding-left-10'><% if (oe.get(i).getTipoUsuario().equals("0")){
                                                                         System.out.print("Usuario");
                                                                       }else
                                                                       {
                                                                           System.out.print("Administrador");
                                                                       }
                                                  %></td>
                                        <td class='padding-left-10'><a href="#" onclick="irDetalleOE('<%=oe.get(i).getIdUsuario() %>');">Modificar</a></td> 
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
                                                            <th width="70">Usuario</th>
                                                            <th width="150">Nombre</th>
                                                            <th width="70">Id Cliente</th>
                                                            <th width="70">Tipo Usuario</th>
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
