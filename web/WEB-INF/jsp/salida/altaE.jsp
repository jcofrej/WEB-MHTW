<%@page import="Controlador.ConsultasMnh"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Modelo.DetalleStock"%>
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
//msg=null;
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
}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title> 
            Alta de Pedido
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
            
            function ValidarCantidadCombo()
            {
                var vrestado=true;
                var vrsum=0;
                var vrcantidad = document.getElementById('cantidad').value;
                var selector = document.getElementById('lote_articulo');
                var lista = document.getElementById("lote_articulo").length;

                if (selector.selectedIndex>0){
                    var value = selector[selector.selectedIndex].value;
                    var ValueParts = value.split('|');
                    var var1=ValueParts[1];    
                }
                else
                {
                    for(var i=1;i<lista;i++)
                    {
                        var ValueParts = selector[i].value.split('|');
                        var var1=ValueParts[1];    

                        vrsum = vrsum + parseInt(var1);
                    }
                    var1=vrsum;
                }
                
                if(parseInt(vrcantidad)>parseInt(var1))
                {
                    alert('La Cantidad Ingresada es Mayor al Stock');
                    document.getElementById('cantidad').value="";
                    document.getElementById('cantidad').focus();
                    vrestado=false;
                }
                else
                {
                   vrestado=true;
                }

                
                if (parseInt(vrcantidad)==0)
                {
                    alert('La Cantidad Ingresada no es Valida');
                    document.getElementById('cantidad').value="";
                    document.getElementById('cantidad').focus();
                    vrestado=false;
                }
                
                return vrestado;
            }
            
            function ValidarCantidadComboLinea(vrobjeto,selector )
            {
                var vrestado=true;
                var vrsum=0;
                var vrcantidad = vrobjeto.value;
                var lista = selector.length;

                if (selector.selectedIndex>0){
                    var value = selector[selector.selectedIndex].value;
                    var ValueParts = value.split('|');
                    var var1=ValueParts[1];    
                }
                else
                {
                    for(var i=1;i<lista;i++)
                    {
                        var ValueParts = selector[i].value.split('|');
                        var var1=ValueParts[1];    
                        vrsum = vrsum + parseInt(var1);
                    }
                    var1=vrsum;
                }
                
                if(parseInt(vrcantidad)>parseInt(var1))
                {
                    alert('La Cantidad Ingresada es Mayor al Stock('+var1+')');
                    vrobjeto.value="";
                    vrobjeto.focus();
                    vrestado=false;
                }
                else
                {
                   vrestado=true;
                }

                
                if (parseInt(vrcantidad)==0)
                {
                    alert('La Cantidad Ingresada no es Valida');
                    vrobjeto.value="";
                    vrobjeto.focus();
                    vrestado=false;
                }
                
                return vrestado;
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
                    
                    estado=ValidarCantidadComboLinea(document.getElementById('cantidadm'), document.getElementById('lote_articulom'));
                    
                    if(document.getElementById('cantidadm').disabled == true)
                    {
                            document.getElementById('lote_articulom').disabled=false;
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
                          
                          estado=ValidarCantidadComboLinea(document.getElementsByName('cantidadm')[x], document.getElementsByName('lote_articulom')[x]);
                          
                          if(document.getElementsByName('cantidadm')[x].disabled == true)
                           {
                                   document.getElementsByName('lote_articulom')[x].disabled=false;
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
            
            function setSelectedValue(selectObj, valueToSet) {
                for (var i = 0; i < selectObj.options.length; i++) {
                    if (selectObj.options[i].text== valueToSet) {
                        selectObj.options[i].selected = true;
                        return;
                    }
                }
            }
            
            function ControlarLotesCombo(vrCod,vrTexto,vrNom,vrIndice)
            {
                //var vrLargo=document.getElementById('DIAnetTableProductosAlta').rows.length-1
                //var myArray = new Array(vrLargo,vrLargo);
                //alert(vrIndice);
                //alert(vrNom);
                //alert(vrCod);
                //alert(vrTexto);
                //this.options[this.selectedIndex].text
                var objSelect = document.getElementsByName('lote_articulom')[vrIndice];//document.getElementById("lote_articulom");
                for (var i=1;i <= document.getElementById('DIAnetTableProductosAlta').rows.length -1; i++){
                        
                        var vrCodArt=document.getElementById('DIAnetTableProductosAlta').rows[i].cells[1].innerHTML;
                        var combo = document.getElementsByName('lote_articulom')[i-1];
                        var vrNomLote = combo.options[combo.selectedIndex].text;
                        if (i-1!=vrIndice){
                            if (vrCodArt==vrCod)
                            {
                                //alert(vrNomLote);
                                if (vrNomLote==vrTexto)
                                {
                                    alert('El Lote ya Existe');
                                    setSelectedValue(objSelect,vrNom);
                                    break;
                                }
                            }
                        }
                        
               }     
               //alert(myArray);
            }
            
            window.onload = function ()
            {
                comprobarTabAlta();
                mostrarMensajes();

                /* defecto*/
                document.forms['MWEBNuevaOEForm'].codSeguimiento.focus();
                //modo = '';
                document.forms['MWEBNuevaOEForm'].codSeguimiento.value='<%=codSeguimiento %>';
                document.forms['MWEBNuevaOEForm'].proveedor.value='<%=proveedor %>';
                document.forms['MWEBNuevaOEForm'].comentario.value='<%=comentario %>';
                
                if (document.getElementById("codigoArticuloPropietario").value!="")
                {
                    document.getElementById("cantidad").focus();
                }
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
                if (estaVacio(codSeguimientoVal) || codSeguimientoVal.length > 20) {
                    alertas.push(mensajeValidacionCodSeguimiento);
                }
                idProveedorVal = document.forms['MWEBNuevaOEForm']['infoOrdenEntradaOT.idProveedor'].value;
                if (estaVacio(idProveedorVal) || idProveedorVal.length > 15) {
                    alertas.push(mensajeValidacionProveedor);
                }
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
                Gestión de Pedidos
                <img src="imagenes/icon-bread-crumbs.gif" alt="" /> <a href="#"
                                                                       onclick="irConsultaEntrega();" class="home"> Consulta Pedidos
                </a> <img src="imagenes/icon-bread-crumbs.gif" alt="" />

                Alta de Pedido

            </div>
            <div id="MWEBInLineError" >

            </div>
            <!-- ============ Botonera de acciones ============ -->

            <div class="dianet-mrg-bottom-15">
                <div class="dianet-div-align-left">
                    <input type="button" name="" tabindex="20"
                           value="Guardar"
                           onclick="btGuardarAltaEntrega();" class="boton">
                           <!--onclick="btGuardarAltaOE();" class="boton">-->
                    <input type="button" name="" tabindex="20" value="Cancelar" onclick="btCancelarAltaEntrega();" class="boton">
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
                <!--<input type="hidden" id="origen" name="origen" value="listaoe">!-->
                <input type="hidden" id="origen" name="origen" value="">
                <table cellspacing="1" cellpadding="3" id="DIAnetTableAltaOrdenes">
                    <tr>
                        <th class="WF170">Código Seguimiento</th>
                        
                        <th class="WF130"><a href="#" onclick="irClientesAltaEntrega();" tabindex="30">Cliente</a></th>

                    </tr>
                    <tr>
                        <td><input id="codSeguimiento"
                                   name="codSeguimiento" style="width: 98%"
                                   maxlength="15" type="text"
                                   value='' />
                        </td>
                        
                        <td> 
                            <input id="proveedor" name="proveedor"
                                   maxlength="15" style="width: 98%" type="text"
                                   value='<%=codProv%>' />
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
                        <a href="#" onclick="cambiarTabAltaFocus(1, 'lineaArticuloOT.numeroLinea');" tabindex="50">Productos</a></span> 
                    <span id="etiquetaTabValoresAlta" focusValue="valorAgregado[0].bAplicar"></span> 
                    <span id="etiquetaTabDocumentacionAlta" focusValue="contenidoFichero"></span>
                </div>


                <div id="tabProductosAlta" style="display: none;">
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
                                    Listado de productos pedido:
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
                                            <th width="100">Lote</th>
                                            <th width="100">Cantidad</th>
                                            <th width="100">Accion</th>
                                        </tr>
                                    </thead>

                                    <tbody id="orderBody">
                                    <SCRIPT>
                                        //articulosContenidos.push('00001');
                                        
                                    </SCRIPT>
                                    <%
                                        ConsultasMnh conds = new ConsultasMnh();
                                        LinkedList<DetalleStock> dsts=null;
      
                                        for(int j=0;j<datosOe.size();j++){
                                            String numLineaF = String.format("%05d", j+1);
                                            String vrCodCli = datosOe.get(j).getCliente();
                                            String vrCodArt = datosOe.get(j).getArticuloPropietario();
                                            dsts= conds.getDetalleStock(vrCodCli,vrCodArt);
                                             %>
                                    <tr>
                                        <td class="align-right"><%=numLineaF %></td>
                                        <td><%=datosOe.get(j).getArticuloPropietario() %></td>
                                        <td><%=datosOe.get(j).getArticuloMh() %></td>
                                        <td><%=datosOe.get(j).getDescripcion() %></td>
                                        <td>  
                                            <select id="lote_articulom" name="lote_articulom" onchange="ControlarLotesCombo('<%=vrCodArt%>',this.options[this.selectedIndex].text,'<%=datosOe.get(j).getLote()%>',<%=j%>);" disabled>
                                             <option value="0">Sin Lote</option>
                                             <%
                                             String vrLote=datosOe.get(j).getLote();
                                             for(int i=0;i<dsts.size();i++){
                                                 String vrSel="";
                                                 if (dsts.get(i).getLote().equals(vrLote))
                                                 {
                                                     vrSel="selected";
                                                 }
                                             %>
                                                  <option value="<%=i%>|<%=dsts.get(i).getCantidad()%>" <%=vrSel%>><%=dsts.get(i).getLote()%></option>
                                             <%
                                             }
                                             %>
                                             </select>
                                             <input id="lotem" type="hidden" name="lotem" value="">
                                        </td>
                                        <td class="align-right">
                                            <input id="cantidadm" name="cantidadm" type="text" maxlength="9" size="9" class="W96" onkeypress="return valida(event)"  value='<%=datosOe.get(j).getCantidad()%>' disabled />
                                        </td>
                                        <td class="align-center">
                                            <a href="#"
                                               id="btnMod"
                                               name="btnMod"
                                               onclick="if (irValidarProdOE('<%=datosOe.size()%>','<%=numLineaF %>',<%=j%>)==true){ irModificarProdOE('<%=numLineaF %>','<%=datosOe.size()%>',<%=j%>);}">Modificar</a>
                                            <br />
                                            <a href="#"
                                               onclick="irEliminarProductoOE('<%=numLineaF %>','Pedidos');">Eliminar</a>
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
                                                               onclick="irArticulosEntrega('irArticuloNEp');document.getElementById('cantidad').focus();return false;" tabindex="100">Código Art.</a></th>
                                            <th width="100"><a href="#"
                                                               onclick="irArticulosEntrega('irArticuloNEp');" tabindex="100">Código Art. MH</a></th>
                                            <th width="200">Descripción</th>
                                            <th width="50">Lote</th>
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
                                                       onChange="compruebaCodigoEntrega('codigoArticuloPropietario','<%=usuario %>','irArticuloNEp','irArticuloNEp');"
                                                       name="codigoArticuloPropietario"
                                                       maxlength="25" type="text" class="W96"
                                                       value='<%=arti.get(0).getCodArt()%>' />
                                            </td>
                                            <td><input id="codigoArticulo"
                                                       onChange="compruebaCodigoEntrega('codigoArticulo','<%=usuario %>','irArticuloNEp','irArticuloNEp');"
                                                       name="codigoArticulo" type="text"
                                                       class="W96"
                                                       value='<%=arti.get(0).getCodMh()%>' />
                                            </td>
                                            <td><input id="descripcion"
                                                       name="descripcion" type="text"
                                                       readonly="readonly" tabindex="-1" class="W96"
                                                       value='<%=arti.get(0).getDescripcion()%>' />
                                            </td>
                                            <td>
  
                                                <%
                                                LinkedList<DetalleStock> dstd=null;
                                                dstd= (LinkedList)session.getAttribute("detalleStock");
                                                if (dstd!=null){
                                                %>
                                                    <select id="lote_articulo" name="lote_articulo">
                                                    <option value="0" selected>Sin Lote</option>
                                                    <%
                                                    for(int i=0;i<dstd.size();i++){
                                                    %>
                                                         <option value="<%=i%>|<%=dstd.get(i).getCantidad()%>"><%=dstd.get(i).getLote()%></option>
                                                    <%
                                                    }
                                                    %>
                                                    </select>
                                                <%}
                                                %>
                                                <input id="lotem" type="hidden" name="lotem" value="">
                                                <!--<input id="lote"
                                                                  name="lote" type="text"
                                                                  maxlength="20" size="20" class="W96"
                                                                  value='' />-->
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
                                                       onChange="compruebaCodigoEntrega('codigoArticuloPropietario','<%=usuario %>','irArticuloNEp','irArticuloNEp');"
                                                       name="codigoArticuloPropietario"
                                                       maxlength="25" type="text" class="W96"
                                                       value='' />
                                            </td>
                                            <td><input id="codigoArticulo"
                                                       onChange="compruebaCodigoEntrega('codigoArticulo','<%=usuario %>','irArticuloNEp','irArticuloNEp');"
                                                       name="codigoArticulo" type="text"
                                                       class="W96"
                                                       value='' />
                                            </td>
                                            <td><input id="descripcion"
                                                       name="descripcion" type="text"
                                                       readonly="readonly" tabindex="-1" class="W96"
                                                       value='' />
                                            </td>
                                            <td><input id="lote"
                                                                  name="lote" type="text"
                                                                  maxlength="20" size="20" class="W96"
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
                                    <input id="lotep" type="hidden" name="lotep" value="">
                                    <input type="button" name="" value="Añadir" onclick="if (ValidarCantidadCombo()==true){irBusquedaArticulosAltaEntregaStock();}" class="boton margin-right-10">

                                </p>
                            </td>
                        </tr>
                    </table>
                    


                </div>
                <!-- ============ detalle listado  ============ -->
                <%
                LinkedList<DetalleStock> dstc=null;
                DecimalFormat decimales = new DecimalFormat("0");
                dstc= (LinkedList)session.getAttribute("detalleStock");
                if(dstc!=null){
                %>
                <table id="page" cellpadding="3" cellspacing="5">
                <tr>
                    <!-- numero de registros -->
                    <td class="dianet-nav-listado">N. Registros <span> <%=dstc.size()%>
                        </span></td>
                    <!- numero de páginas -->
                    <td class="dianet-nav-listado">N. Páginas <%=decimales.format(Math.ceil((double) dstc.size() / (double) 5))%> </td>
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
                               class="table-autopage:5"
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
                                if (dstc.size()>0){
                                    %>
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
                                    <%
                                    }
                                    session.removeAttribute("detalleStock");
                                }else{
                                %>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                <%
                                }
                                %>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </table>

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
                                    <tbody id="orderBody"></tbody>
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
