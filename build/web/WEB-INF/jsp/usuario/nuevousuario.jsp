
<%@page import="Modelo.ClientesPe"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Controlador.ConsultasMnh"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

 <%

     String msg = (String)session.getAttribute("msgError");
    if(msg!=null){
        %>
            <script language="JavaScript">
                alert('<%=msg %>');
            </script>
        <%
        session.removeAttribute("msg");
        msg="";
    }
    
    ConsultasMnh conoe = new ConsultasMnh();
    LinkedList<ClientesPe> vrlstCliente=null;
    vrlstCliente = conoe.getClientes();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Gestion de Usuarios</title>
        <%@include file="../head.inc"%>
       
        <SCRIPT LANGUAGE="JavaScript">
  	
        function LimpiarTextos(){
	   document.getElementById('nusuario').value="";
	   document.getElementById('pass').value="";
           document.getElementById('nombre').value="";
           document.getElementById('nusuario').focus();
	}

   	</script>
    </head>

    <body onload="LimpiarTextos();">

        <!-- Division principal -->
        <div id="DIAnetContainer">
            <div id="DIAnetClearHeader"></div>
            <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

            <%@include file="../menu.inc"%>
           
            <!--  navegación -->
            <div id="DIAnetBreadCrumbs">
                Esta en
                <a href="#" class="home"> Gestión de Usuarios
                </a> <img src="imagenes/icon-bread-crumbs.gif" alt="" h />
                Ingreso de Usuario
            </div>
            
            <form name="MWEBFilterOrdenesForm" method="POST" action="#">
                <input type="hidden" name="pageCurrent" value="">
                <input type="hidden" name="pagina" id="pagina" value="">
                <input type="hidden" name="origen" value="listaoe">
                <!-- ============ Botonera de acciones ============ -->
                <div class="dianet-mrg-bottom-15">
                    <div class="dianet-div-align-left">

                        <input type="button" name="" value="Guardar" onclick="irNuevoUsuario('GuardarUsuario');" class="boton">
                        <input type="button" name="" value="Cancelar" onclick="btLimpiarBusquedaUsuarios();" class="boton">
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
                    
                </p>
                <table cellspacing="1" cellpadding="3" id="DIAnetTableFiltreOrdenes">
                    <tr>
                        <th class="WF170">Nombre Usuario</th>
                        <td><input id="nusuario" name="nusuario"
                                   type="text" style="width: 50%" maxlength="20"
                                   value="" />
                       </td>                        
                    </tr>
                    <tr>
                        <th class="WF170">Contraseña</th>
                        <td><input id="pass" name="pass" type="password"
                                   style="width: 50%" maxlength="20"
                                   value="" /></td>  
                    </tr>
                    <tr>
                        <th class="WF170">Nombre Completo</th>
                        <td><input id="nombre" name="nombre" type="text"
                                   style="width: 98%" maxlength="20"
                                   value="" />
                        </td>
                    </tr>
                    <tr>
                        <th class="WF170">Cliente</th>
                        <td>
                            <select id="idcliente" name="idcliente">
                                    <option value="0" Selected>Seleccionar Cliente</option>  
                                 <%
                                    for(int i=0;i<vrlstCliente.size()-1;i++)
                                    {
                                    %>
                                         <option value="<%=vrlstCliente.get(i).getCodigo()%>"><%=vrlstCliente.get(i).getNombre() %></option>
                                    <%
                                    }
                                 %>
                                </select>
                        </td>
                    </tr>
                    <tr>
                        <th class="WF170">Tipo Usuario</th>
                        <td>
                             <select id="tipo_Usuario" name="tipo_Usuario">
                                 <option value="0" selected>Usuario</option>    
                                 <option value="1">Administrador</option>
                             </select>
                        </td>
                    </tr>
                </table>
            </form>
                <%@include file="../cabecera.inc"%>
    </body>
</html>
