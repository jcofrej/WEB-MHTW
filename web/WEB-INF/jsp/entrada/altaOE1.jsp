<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelo.ArticulosOe"%>
<%@page import="Modelo.Articulos"%>
<%@page import="java.util.LinkedList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String codSeguimiento=""; 
String comentario=""; 
String proveedor=""; 
String codProv = request.getParameter("codProveedor");
if (codProv == null) {
    codProv = "";
}
String msg = (String)session.getAttribute("msgArticulo");
if(msg!=null){
%>
    <script language="JavaScript">
        alert('<%=msg %>');
    </script>
<%

}
session.removeAttribute("msgArticulo");
msg="";
String msgerror=(String)session.getAttribute("msgError");
if(msgerror!=null){
    
%>
    <script language="JavaScript">
        alert('<%=msgerror %>');
    </script>
<%
    session.removeAttribute("msgError");
    msgerror="";
    codSeguimiento=(String)session.getAttribute("codigoSeguimiento");
    if(codSeguimiento==null){
        codSeguimiento="";
    }
    comentario=(String)session.getAttribute("comentario");
    proveedor=(String)session.getAttribute("proveedor");
    if(proveedor==null){
        proveedor="";
    }
    
    session.removeAttribute("codigoSeguimiento");
    session.removeAttribute("comentario");
    session.removeAttribute("proveedor");
}else{


    codSeguimiento = request.getParameter("codSeguimiento");
    if (codSeguimiento == null) {
        codSeguimiento = "";
    }

    comentario = request.getParameter("comentario");
    if (comentario == null) {
            comentario = "";
    }

    proveedor = request.getParameter("proveedor");
    if (proveedor == null) {
        proveedor = "";
    }
}String accion =(String)session.getAttribute("accion");
if(accion!=null){
    codSeguimiento=(String)session.getAttribute("codSeguimiento");
    if(codSeguimiento==null){
        codSeguimiento="";
    }
    comentario=(String)session.getAttribute("comentario");
    proveedor=(String)session.getAttribute("proveedor");
    if(proveedor==null){
        proveedor="";
    }
    session.removeAttribute("accion");
}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title> 
            Alta de Orden de Entrada
        </title>


        <%@include file="../head.inc"%>


        <SCRIPT LANGUAGE="JavaScript">

            function valida(e){
                tecla = (document.all) ? e.keyCode : e.which;

                //Tecla de retroceso para borrar, siempre la permite
                if (tecla==8){
                    return true;
                }

                // Patron de entrada, en este caso solo acepta numeros
                patron =/[0-9]/;
                tecla_final = String.fromCharCode(tecla);
                return patron.test(tecla_final);
            }
            
            window.onload = function ()
            {
                comprobarTabAlta();
                mostrarMensajes();

                /* defecto*/
                document.forms['MWEBNuevaOEForm'].codSeguimiento.focus();
                modo = '';
                document.forms['MWEBNuevaOEForm'].codSeguimiento.value='<%=codSeguimiento %>';
                document.forms['MWEBNuevaOEForm'].proveedor.value='<%=proveedor %>';
                document.forms['MWEBNuevaOEForm'].comentario.value='<%=comentario %>';
                
            }

            function mostrarMensajes() {
                var alertas = [];
                var erroresAMostrar = '';
                if (erroresAMostrar != '') {
                    alertas.push(erroresAMostrar);
                }
                var mensajesAMostrar = '';
                if (mensajesAMostrar != '') {
                    alertas.push(erroresAMostrar);
                }
                ponerAlerta(alertas);
            }



            function comprobarTabAlta() {
                var tabVisible = "false";


                if (tabVisible == "false")
                {
                    cambiarTabAlta(1);
                }
            }



            function comprobarGuardarAltaOE() {
                var alertas = [];


                if (0 == 0) {
                    alertas.push(mensajeValidacionMinimoNumPrdocutos);
                }

                if (0 < 0) {
                    alertas.push(mensajeValidacionMinimoNumDocumento);
                }

                codSeguimientoVal = document.forms['MWEBNuevaOEForm']['infoOrdenEntradaOT.codigoSeguimiento'].value;
                alert(codSeguimientoVal);        
                if (estaVacio(codSeguimientoVal) || codSeguimientoVal.length > 20) {
                    alertas.push(mensajeValidacionCodSeguimiento);
                }
                idProveedorVal = document.forms['MWEBNuevaOEForm']['infoOrdenEntradaOT.idProveedor'].value;
                if (estaVacio(idProveedorVal) || idProveedorVal.length > 15) {
                    alertas.push(mensajeValidacionProveedor);
                }
                alert(idProveedorVal);
                comentarioVal = document.forms['MWEBNuevaOEForm']['infoOrdenEntradaOT.comentario'].value;
                if (estaVacio(comentarioVal) && comentarioVal.length > 600) {
                    alertas.push(mensajeValidacionComentario);
                }
                if (ponerAlerta(alertas)) {
                    return false;
                } else {
                    return true;
                }
            }
            
            function irValidarProdOE(NumReg,Linea,index) {
                var estado=true;
               // Linea=Linea-1;
               
                if (NumReg==1){
                    document.getElementById('btnMod').text="Grabar";
                    if (document.getElementById('cantidadm').value=="")
                      {
                         alert('Debe Ingresar un Número');
                         document.getElementById('cantidadm').focus();
                         estado=false;
                      }
                      
                    if (document.getElementById('cantidadm').value==0)
                    {
                        alert('La Cantidad Debe Ser Mayor a Cero');
                        document.getElementById('cantidadm').value='';
                        document.getElementById('cantidadm').focus();
                        estado=false;
                    }
                    
                    if(document.getElementById('cantidadm').disabled == true)
                    {
                            document.getElementById('cantidadm').disabled=false;
                            estado=false;
                            document.getElementById('cantidadm').focus();
                    }
                }
                if (NumReg>1){
                    document.getElementsByName('btnMod')[index].text="Grabar";
                    for (var x=0;x<=NumReg-1;x++)
                    {
                      if (document.getElementsByName('cantidadm')[x].value=="")
                      {
                         alert('Debe Ingresar un Número');
                         document.getElementsByName('cantidadm')[x].focus();
                         estado=false;
                         break;
                      }
                      
                      if (document.getElementsByName('cantidadm')[x].value==0)
                      {
                         alert('La Cantidad Debe Ser Mayor a Cero');
                         document.getElementsByName('cantidadm')[x].value='';
                         document.getElementsByName('cantidadm')[x].focus();
                         estado=false;
                         break;
                      }
 
                      if (index==x)
                      {                          
                          if(document.getElementsByName('cantidadm')[x].disabled == true)
                           {
                                   document.getElementsByName('cantidadm')[x].disabled=false;
                                   estado=false;
                           }
                      }
                    }
                }
               
               if (estado==false)
               {
                   return false;
               }else{
                   return true;
               }
            }



            //var mensajeValidacionMinimoNumPrdocutos = "No ha introducido ningún producto. Por favor, añada un producto a la orden de entrada.";
            //var mensajeValidacionMinimoNumDocumento = "El número minimo de documento a adjuntar es 0. Por favor, adjunte más documento a la orden de entrada.";
            //var mensajeValidacionNoAdjunto = "No se ha elegido ningún fichero adjunto. Por favor, elige el fichero pulsando el botón Examinar";
            //var mensajeConfirmarGuardar = "Se procederá a guardar la orden de entrada seleccionada. ¿Desea continuar?";
            //var mensajeValidacionTolerancia = "La tolerancia no sigue el formato. Debe estar definido y ser un entero positivo comprendido entre 0 y 100";
            //var mensajeValidacionCantidad = "La cantidad no sigue el formato correcto. Debe estar definido y ser un numero entero comprendido entre 1 y 999999999";
            //var mensajeValidacionCodSeguimiento = "Debe ingresar un codigo de seguimiento";
            //var mensajeValidacionProveedor = "Debe ingresar un proveedor";
            //var mensajeValidacionComentario = "El comentario no sigue el formato especificado. Debe tenr una longitud maxima de 600";
            //var mensajeValidacionCodArtProp = "El código del artículo no sigue el formato especificado. Debe estar definido y tener una longitud maxima de 31 caracteres ";
            //var mensjeValidacionCodArt = "El código artículo no sigue el formato especificado. Debe estar definido.";
            //var errorExtensionAjunto = "El fichero adjunto no es ninguno de los tipos soportados PDF o JPG";
            //var errorAdjuntoRepetido = "El documento que desea adjuntar ya ha sido procesado";

            //var mensajeLineaArticuloduplicada = "El Número de línea está duplicado. Utilice un numero de línea que no exista para esta orden de entrada.";
            //var mensajeLineaArticuloVacia = "El Número de línea no tiene un formato correcto. Debe estar definido y tener una longitud máxima 25.";
            //var errorExtensionAjunto = "El fichero adjunto no es ninguno de los tipos soportados PDF o JPG";
            //var txtConfirmarEliminarPdto = "Se procederá a eliminar el producto seleccionado. ¿Desea continuar?";


            var articulosContenidos = new Array();

        </script>

    </head>
    <body>


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
                Gestión de Ordenes de Entrada
                <img src="imagenes/icon-bread-crumbs.gif" alt="" /> <a href="#"
                                                                       onclick="irConsultaOrdenesEntrada();" class="home"> Consulta Ordenes de Entrada
                </a> <img src="imagenes/icon-bread-crumbs.gif" alt="" />


                Alta de Orden de Entrada
                
            </div>
            <div id="MWEBInLineError" >

            </div>
            <!-- ============ Botonera de acciones ============ -->

            <div class="dianet-mrg-bottom-15">
                <div class="dianet-div-align-left">
                    <input type="button" name="" tabindex="20"
                           value="Guardar"
                           onclick="btGuardarAltaOE();" class="boton">
                           <!--onclick="btGuardarAltaOE();" class="boton">-->
                    <input type="button" name="" tabindex="20" value="Cancelar" onclick="btCancelarAltaOE();" class="boton">
                </div>
            </div>
            <br />

            <!-- ============ alta cabecera  ============ -->
            <form id="seleccionaArt" name="MWEBNuevaOEForm" method="POST" action="#">

                <input type="hidden" name="modo" value="">
                <input type="hidden" name="articuloSelec" value="">
                <input type="hidden" name="ficheroAEliminar" value="">
                <input type="hidden" name="campoBusqueda" value="">
                <input type="hidden" name="estado" value="">
                <input type="hidden" name="accion" value="">
                <input id="pagina" type="hidden" name="pagina" value="">
                <!--<input type="hidden" name="codigoArticuloPropietario" value="">-->
                <input id="usuario" type="hidden" name="usuario" value="<%=usuario %>">
                <input type="hidden" name="pageCurrentTab1" value="1" />
                <input type="hidden" name="pageCurrentTab2" value="1" />
                <input type="hidden" name="pageCurrentTab3" value="1" />
                <!--<input type="hidden" id="origen" name="origen" value="listaoe">-->
                <input type="hidden" id="origen" name="origen" value="">
                

                <table cellspacing="1" cellpadding="3" id="DIAnetTableAltaOrdenes">
                    <tr>
                        <th class="WF170">Código Seguimiento</th>
                        <th class="WF130"><a href="#" onclick="irProveedoresAlta();" tabindex="30">Proveedor</a></th>
                    </tr>
                    <tr>
                        <td><input id="codSeguimiento"
                                   name="codSeguimiento" style="width: 98%"
                                   maxlength="25" size="25" type="text"
                                   value='' />
                        </td>
                        
                        <td> 
                            <input id="proveedor" name="proveedor"
                                   maxlength="15" size="15" style="width: 98%" type="text"
                                   value='' />
                        </td>
                    </tr>
                </table>


                <table cellspacing="1" cellpadding="3" id="DIAnetTableDetalleOrdenes">
                    <tr>
                        <th class="W100">Comentario</th>
                    </tr>
                    <tr>
                        <td><input id="comentario"
                                   name="comentario" style="width: 98%"
                                   maxlength="600" type="text"
                                   value='' />
                        </td>

                    </tr>
                </table>


                <div id="etiquetasTabAlta">
                    <span id="etiquetaTabProductosAlta" focusValue="lineaArticuloOT.numeroLinea"> 
                        <a href="#"onclick="cambiarTabAltaFocus(1, 'lineaArticuloOT.numeroLinea');" tabindex="50">Productos</a></span> 
                    <span id="etiquetaTabValoresAlta" focusValue="valorAgregado[0].bAplicar"></span> 
                    <span id="etiquetaTabDocumentacionAlta" focusValue="contenidoFichero"></span>
                </div>


                <div id="tabProductosAlta" ><!--style="display: none;"-->
                    <%
                                    ArrayList<ArticulosOe> datosOe= (ArrayList<ArticulosOe>)request.getSession().getAttribute("datosOe");
                                    
                                    if(datosOe!=null){
                    
                        DecimalFormat decimales = new DecimalFormat("0");
            %>	
            <table id="page" cellpadding="3" cellspacing="5">
                <tr>
                    <!- numero de registros -->
                    <td class="dianet-nav-listado">N. Registros <span> <%=datosOe.size()%>
                        </span></td>
                    <!- numero de páginas -->
                    <td class="dianet-nav-listado">N. Páginas <%=decimales.format(Math.ceil((double) datosOe.size() / (double) 5))%> </td>
                    <!- primera pag -->
                    <td><a class="dianet-nav-listado" id="pageFist"
                           onclick="irPage(0, 'DIAnetTableProductosAlta', '');
                                                       return false;"
                           href="#">&lsaquo;&lsaquo;</a></td>
                    <!- anterior pag -->
                    <td><a class="dianet-nav-listado" id="pagePrevious"
                           onclick="irPage('previous', 'DIAnetTableProductosAlta', '');
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
                           onclick="irPage('next', 'DIAnetTableProductosAlta', '');
                                                       return false;"
                           href="#">&rsaquo;</a></td>
                    <!- ultima pag -->
                    <td><a class="dianet-nav-listado"
                           onclick="irPage(2 - 1, 'DIAnetTableProductosAlta', '');
                                                       return false;"
                           href="#">&raquo;</a></td>

                </tr>
            </table>
                    <table class="margin-both-20">
                        <tr>
                            <td>
                                <p class="dianet-content-listado">
                                    Listado de productos orden entrada:
                                </p>
                            </td>
                        </tr>

                        <tr>
                            <td>

                                <table id="DIAnetTableProductosAlta" 
                                       class="table-autopage:5"
                                       cellspacing="1" cellpadding="3">

                                    <thead id="orderHead">
                                        <tr>
                                            <th width="100">Línea</th>
                                            <th width="100">Código Art.</th>
                                            <th width="100">Código Art. MH</th>
                                            <th width="200">Descripción</th>
                                            <th width="100">Cantidad</th>
                                            <th width="100">Accion</th>
                                        </tr>
                                    </thead>

                                    <tbody id="orderBody">
                                    <SCRIPT>
                                        //articulosContenidos.push('00001');
                                        
                                    </SCRIPT>
                                    <%

                                        for(int j=0;j<datosOe.size();j++){
                                            
                                            String numLineaF=String.format("%05d", j+1);
                                    
                                    %>
                                    <tr>
                                        <td class="align-right"><%=numLineaF %></td>
                                        <td><%=datosOe.get(j).getArticuloPropietario() %></td>
                                        <td><%=datosOe.get(j).getArticuloMh() %></td>
                                        <td><%=datosOe.get(j).getDescripcion() %></td>
                                        <td class="align-right">
                                            <input id="cantidadm" name="cantidadm" type="text" maxlength="9" size="9" class="W96" onkeypress="return valida(event)"  value='<%=datosOe.get(j).getCantidad()%>' disabled />
                                        </td>
                                        <td class="align-center">
                                            <a href="#"
                                               id="btnMod"
                                               name="btnMod"
                                               onclick="if (irValidarProdOE('<%=datosOe.size()%>','<%=numLineaF %>',<%=j%>)==true){ irModificarProductoOE('<%=numLineaF %>','<%=datosOe.size()%>',<%=j%>);}">Modificar</a>
                                            <br />
                                            <a href="#"
                                               onclick="irEliminarProductoOE('<%=numLineaF %>','Entrega');">Eliminar</a>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                       
                                    }
                                    %>
                                    

                                    </tbody>
                                </table>
                            </td>
                        </tr>



                        <tr>
                            <td> 
                                <p class="dianet-content-listado">
                                    Nuevo producto:
                                </p>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <table id="DIAnetTableNuevoProductosAlta" cellspacing="1"
                                       cellpadding="3">
                                    <thead id="orderHead">
                                        <tr>
                                            <th width="100" id="DIAnetTableNuevoProductosAltaColunmaNumLinea">Línea</th>
                                            <th width="100"><a href="#"
                                                               onclick="irArticulosOE();" tabindex="100">Código Art.</a></th>
                                            <th width="100"><a href="#"
                                                               onclick="irArticulosOE();" tabindex="100">Código Art. MH</a></th>
                                            <th width="200">Descripción</th>
                                            <th width="50">Cantidad</th>
                                           
                                        </tr>
                                    </thead>
                                    <tbody id="orderBody">
                                        <%
                                            LinkedList<Articulos> arti = (LinkedList) session.getAttribute("articulos");
                                            
                                            if (arti != null && arti.size()>0 ) {
                                                
                                        %>
                                        <tr>
                                            <td  id="DIAnetTableNuevoProductosAltaColunmaNumLinea" ><input id="numeroLinea"
                                                                                                           name="lineaArticuloOT.numeroLinea" type="hidden"
                                                                                                           maxlength="25" class="W96"
                                                                                                           value='0' />
                                            </td>
                                            <td><input id="codigoArticuloPropietario"
                                                       onChange="compruebaCodigo('codigoArticuloPropietario');"
                                                       name="codigoArticuloPropietario"
                                                       maxlength="31" type="text" class="W96"
                                                       value='<%=arti.get(0).getCodArt()%>' />
                                            </td>
                                            <td><input id="codigoArticulo"
                                                       onChange="compruebaCodigo('codigoArticulo');"
                                                       name="codigoArticulo" type="text"
                                                       class="W96"
                                                       value='<%=arti.get(0).getCodMh()%>' />
                                            </td>
                                            <td><input id="descripcion"
                                                       name="descripcion" type="text"
                                                       readonly="readonly" tabindex="-1" class="W96"
                                                       value='<%=arti.get(0).getDescripcion()%>' />
                                            </td>
                                            <td width="50"><input id="cantidad"
                                                                  name="cantidad" type="text"
                                                                  maxlength="9" size="9" class="W96"
                                                                  onkeypress="return valida(event)"
                                                                  value='' />
                                            </td>
                                            

                                        </tr>
                                        <%
                                        arti=null;
                                        session.removeAttribute("articulos");
                                        } else {
                                        
                                            
                                            %>
                                        <tr>
                                            <td  id="DIAnetTableNuevoProductosAltaColunmaNumLinea" ><input id="numeroLinea"
                                                                                                           name="lineaArticuloOT.numeroLinea" type="hidden"
                                                                                                           maxlength="25" class="W96"
                                                                                                           value='0' />
                                            </td>
                                            <td><input id="codigoArticuloPropietario"
                                                       onChange="compruebaCodigo('codigoArticuloPropietario');"
                                                       name="codigoArticuloPropietario"
                                                       maxlength="31" type="text" class="W96"
                                                       value='' />
                                            </td>
                                            <td><input id="codigoArticulo"
                                                       onChange="compruebaCodigo('codigoArticulo');"
                                                       name="codigoArticulo" type="text"
                                                       class="W96"
                                                       value='' />
                                            </td>
                                            <td><input id="descripcion"
                                                       name="descripcion" type="text"
                                                       readonly="readonly" tabindex="-1" class="W96"
                                                       value='' />
                                            </td>
                                            <td width="50"><input id="cantidad"
                                                                  name="cantidad" type="text"
                                                                  maxlength="9" size="9" class="W96"
                                                                  value='' />
                                            </td>
                                            

                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>

                                </table>

                            </td>

                        </tr>

                        <tr><td>&nbsp;</td></tr>
                        <tr>
                            <td class="align-right">
                                <p align="right">


                                    <input type="button" name="" value="Añadir" onclick="if (this.form.cantidad.value>0){btAnadirArticuloAltaOE();}else{alert('La Cantidad debe ser Mayor a 0');}" class="boton margin-right-10">

                                </p>
                            </td>
                        </tr>
                    </table>



                </div>



                <div id="tabValoresAlta" style="display: none;">

                    <table class="margin-both-20">




                        <tr>
                            <td>
                                <p class="dianet-content-listado">
                                    Listado de valores agregados:
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td>

                                <table id="DIAnetTableValoresAgregadosAlta"
                                       class="table-autopage:5"
                                       cellspacing="1" cellpadding="3">



                                    <thead id="orderHead">
                                        <tr>
                                            <th width="120">Código</th>
                                            <th width="315">Nombre</th>
                                            <th width="600">Descripción</th>
                                            <th class="align-center" width="120">Aplicar</th>
                                        </tr>
                                    </thead>
                                    <tbody id="orderBody">

                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </table>




                </div>


                <div id="tabDocumentacionAlta" style="display: none;">

                    <table class="margin-both-20">


                        <tr>
                            <td>
                                <p class="dianet-content-listado">
                                    Documentacion Adjunta:
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td>

                                <table id="DIAnetTableDocumentacionAlta"
                                       class="table-autopage:5"
                                       cellspacing="1" cellpadding="3">

                                    <thead id="orderHead">
                                        <tr>
                                            <th width="700">Documento</th>
                                            <th width="150">Accion</th>
                                        </tr>
                                    </thead>
                                    <tbody id="orderBody">




                                        <tr>
                                            <td class="padding-left-10" colspan="2"> 
                                                No hay ninguna documentación adjunta
                                            </td>
                                        </tr>


                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="align-center padding-top-20"><input
                                    type="file" id="fichero" name="contenidoFichero"
                                    class="boton margin-right-40" size="30" /> <input
                                    type="button" class="boton"
                                    onClick="btAdjuntarDocumentoAltaOE();"
                                    value="Adjuntar documento" />
                            </td>
                        </tr>
                    </table>
                </div>




            </form>

            <%@include file="../cabecera.inc"%>
    </body>
</html>
