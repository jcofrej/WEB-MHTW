/////////////////////////////////////////
////////// <GESTION_ENTREGAS> /////////// 
/////////////////////////////////////////

function btBuscarEntregas(){
	var form = document.forms['MWEBFilterOrdenesForm'];
	var listado=[ form['codSeguimiento'].value, form['codEntrega'].value, form['fechaIni'].value, form['codProductoContenido'].value,  form['codCliente'].value];
	if (estanTodosCamposVacios(listado) && estaVacioSelect(form['estado'].value) ) {
		alert(txtCamposVacios);
	}
	else if (validaFechas(form['fechaIni'].value, form['fechaFin'].value)){
		 document.forms['MWEBFilterOrdenesForm'].submit();
	     form.submit();	    
 	} 
} 

function btLimpiarBusquedaEntrega(){
   document.forms['MWEBFilterOrdenesForm'].codSeguimiento.value='';
   document.forms['MWEBFilterOrdenesForm'].proveedor.value='';
   document.forms['MWEBFilterOrdenesForm'].fechaIni.value='';
   document.forms['MWEBFilterOrdenesForm'].fechaFin.value='';
   document.forms['MWEBFilterOrdenesForm'].codMh.value='';
   document.forms['MWEBFilterOrdenesForm'].action = "pedidosServlet.do";
   document.forms['MWEBFilterOrdenesForm'].submit();
}

function btImprimirEntrega(){
   window.open('ImprimeEntregas.do');
}

function irBusquedaClienteEntrega(){
   document.forms['MWEBFilterEntregaForm'].modo.value='MODO_IR_CLIENTE';
   document.forms['MWEBFilterEntregaForm'].action = "PaginaClientesEntregas.do";
   document.forms['MWEBFilterEntregaForm'].submit();
}

function irBusquedaArticulosEntrega(){
   document.forms['MWEBFilterEntregaForm'].modo.value='MODO_IR_ARTICULOS';
   document.forms['MWEBFilterEntregaForm'].action = "PaginaArticulosEntregas.do";
   document.forms['MWEBFilterEntregaForm'].submit();
}

function irNuevaEntrega(pagina){
	document.forms['MWEBFilterOrdenesForm']['pagina'].value = pagina;
	document.forms['MWEBFilterOrdenesForm'].action = "pedidosServlet.do";
	document.forms['MWEBFilterOrdenesForm'].submit();	 
}

function crearExcelPedidos(pagina){
        var form = document.forms['MWEBFilterOrdenesForm'];
        document.forms['MWEBFilterOrdenesForm']['pagina'].value = pagina; 
        document.forms['MWEBFilterOrdenesForm'].submit();
        form.submit();
 
}

function crearExcelEntregas(pagina){
        var form = document.forms['MWEBFilterOrdenesForm'];
        document.forms['MWEBFilterOrdenesForm']['pagina'].value = pagina; 
        document.forms['MWEBFilterOrdenesForm'].submit();
        form.submit();
 
}

function irEditarEntrega(codigo){
	document.forms['MWEBAccionEntregaForm']['codigoEntrega'].value = codigo;
	document.forms['MWEBAccionEntregaForm']['pageCurrent'].value = document.forms['MWEBFilterEntregaForm']['pageCurrent'].value;
	document.forms['MWEBAccionEntregaForm'].action = "EditarEntrega.do";
	document.forms['MWEBAccionEntregaForm'].submit();
}


function irDetalleEntrega(codigoEp){
        document.forms['MWEBAccionOEForm']['codigoOE'].value = codigoEp;
	document.forms['MWEBAccionOEForm']['pageCurrent'].value = document.forms['MWEBFilterOrdenesForm']['pageCurrent'].value;
	document.forms['MWEBAccionOEForm'].action = "pedidosServlet.do";
	document.forms['MWEBAccionOEForm'].submit();
}  
  
function irAnularEntrega(codigoEntrega, txtConfirmacion){
		if (confirm(txtConfirmacion)) {
			document.forms['MWEBAccionEntregaForm']['codigoEntrega'].value = codigoEntrega;
			document.forms['MWEBAccionEntregaForm']['pageCurrent'].value = document.forms['MWEBFilterEntregaForm']['pageCurrent'].value;
			document.forms['MWEBAccionEntregaForm'].action = "EliminarEntrega.do";
			document.forms['MWEBAccionEntregaForm'].submit();
		}
}
  
function btVolverEntrega(){
	   location.href='pedidosServlet.do';
}

 
function irConsultaEntregas(){
	   location.href='PaginaEntregas.do';
}
 

//Clientes
function btBuscarClientes(){
	    var form = document.forms['MWEBFilterClienteForm'];
		var listado=[ form['codigo'].value, form['nombre'].value];
		if (estanTodosCamposVacios(listado) ) {
			alert(txtCamposVacios);
		   //No compruebo el size de los campos. Estan limitados con el maxLengh	
		}
		else {
    	     document.forms['MWEBFilterClienteForm'].submit();	    
     	} 
} 
 
function btLimpiarBusquedaClientes(){
                document.forms['MWEBFilterProveedorForm']['pagina'].value ='irClientesNEp';
                
		document.forms['MWEBFilterProveedorForm'].action = "pedidosServlet.do";
		document.forms['MWEBFilterProveedorForm'].submit();
} 


function irSeleccionarClienteEntrega(codigo,destino,codSeguimiento,comentario) {
	document.forms['resultados']['pagina'].value = destino;
        document.forms['resultados']['proveedor'].value = codigo;
        document.forms['resultados']['codSeguimiento'].value = codSeguimiento;
        document.forms['resultados']['comentario'].value = comentario;
	document.forms['resultados'].action = "pedidosServlet.do";
	document.forms['resultados'].submit();
}

function irSeleccionarClienteAlta(codigo,destino) {
        document.forms['resultados']['pagina'].value = destino;
	document.forms['resultados']['codProveedor'].value = codigo;
	document.forms['resultados'].action = "pedidosServlet.do";
	document.forms['resultados'].submit();
}



function btVolverAltaEntrega(pagina) {
    document.forms['MWEBFilterArticulosForm']['pagina'].value = pagina;
    document.forms['MWEBFilterArticulosForm'].action = "pedidosServlet.do";
    document.forms['MWEBFilterArticulosForm'].submit();
}

//Articulos
function irSeleccionarArticuloEntrega(codigoPropietario) {
	document.forms['resultados']['codigoArticuloPropietario'].value = codigoPropietario;
	document.forms['resultados'].action = "PaginaEntregas.do";
	document.forms['resultados'].submit();
}
 

function irSeleccionarArticuloAltaEntrega(codigoPropietario, codigoArticulo, descripcion, categoria, pagina,origen
                                            ,codSeguimiento,comentario,proveedor) {
	document.forms['resultados']['codigoArticuloPropietario'].value = codigoPropietario;
	document.forms['resultados']['codigoArticulo'].value = codigoArticulo;
	document.forms['resultados']['descripcion'].value = descripcion;
	document.forms['resultados']['categoria'].value = categoria;
	document.forms['resultados']['pagina'].value = pagina;
        document.forms['resultados']['origen'].value = origen;
	document.forms['resultados']['codSeguimiento'].value = codSeguimiento;
        document.forms['resultados']['comentario'].value = comentario;
        document.forms['resultados']['proveedor'].value = proveedor;
	document.forms['resultados'].action = "articulosServlet.do";
	document.forms['resultados'].submit();

}

function irSeleccionarArticuloEditaEntrega(codigoPropietario, codigoArticulo, descripcion, id, controlStock) {
	document.forms['resultados']['codigoArticuloPropietario'].value = codigoPropietario;
	document.forms['resultados']['codigoArticulo'].value = codigoArticulo;
	document.forms['resultados']['descripcion'].value = descripcion;
	document.forms['resultados']['id'].value = id;
	document.forms['resultados']['controlStock'].value = controlStock;
	
	document.forms['resultados'].action = "ActualizarNuevaEntrega.do";
	document.forms['resultados'].submit();

}

 
 //Detalle
function btDescargarPdfEntrega(){
	window.open('ExportarDetallePDFEntregasAction.do');
}
  
function btDescargarExcelEntrega(){
	location.href = 'ExportarDetalleExcelEntregasAction.do';
}
 
 
/* Alta-Modificacion Entrega */
function btGuardarAltaEntrega(){
	codSeg=document.getElementById('codSeguimiento').value;
        idProv=document.getElementById('proveedor').value;
        coment=document.getElementById('comentario').value;
        datoEnv="?codigoSeguimiento="+codSeg+"&proveedor="+idProv+"&comentario="+coment;
        //alert("rcpMhServlet.do");
        document.getElementById('seleccionaArt').action="dspMhServlet.do"+datoEnv;
        document.getElementById('seleccionaArt').submit();
}

function btCancelarAltaEntrega() {
	location.href = 'pedidosServlet.do';
}


//Control cambio valor del tipo
function actualizarTipoAnterior( ) {
    controlFormStock();
	document.forms['MWEBNuevaEntregaForm'].tipoAnterior.value=document.forms['MWEBNuevaEntregaForm']['infoEntregaOT.idTipo'].value;
	limpiarFormStock();
}

//Limpia el contenido del formulario de b�squeda de stock
function limpiarFormStock( ) {
	var form = document.forms['MWEBNuevaEntregaForm'];
	form.stockCodigoArticulo.value="";
	form.stockCodigoArticuloPropietario.value="";
	form.stockDescripcion.value="";
	form.stockLote.value="";
 	form.stockFechaCaducidadIni.value="";
	form.stockFechaCaducidadFin.value="";
	form.stockVidaUtil.value="";
	form.controlStock.value="";
}

function comprobarTipoEntregaAlta( ) {
	document.forms['MWEBNuevaEntregaForm'].modo.value = 'MODO_CAMBIAR_TIPO';
	document.forms['MWEBNuevaEntregaForm'].submit();
}

function comprobarConfirmTipoEntregaAlta(txtConfirm) {
	if (confirm(txtConfirm)) {
		document.getElementById('stockCodigoArticuloPropietario').value = "";
		document.getElementById('stockCodigoArticulo').value = "";
		document.getElementById('stockDescripcion').value = "";
		document.getElementById('stockLote').value = "";
		document.getElementById('stockFechaCaducidadIni').value = "";
		document.getElementById('stockFechaCaducidadFin').value = "";
		document.getElementById('stockVidaUtil').value = "";
		document.forms['MWEBNuevaEntregaForm'].modo.value = 'MODO_ELIMINAR_ARTICULOS';
		document.forms['MWEBNuevaEntregaForm'].submit();
	} else {
		document.forms['MWEBNuevaEntregaForm']['infoEntregaOT.idTipo'].value=document.forms['MWEBNuevaEntregaForm'].tipoAnterior.value;
		
	}
}	

//Control cambio valor del tipo
//este campo, s�lo se habilitar� si estamos dando de alta una Entrega de tipo Normal por Lote o Express por Lote y por tanto, el art�culo encontrado tiene control de lote.
function controlFormStock(){
	//Tipos:
	//1-Normal
	//2-Normal por lote
	//3-Normal por fecha
	//4-Express
	//5-Express por lote
	//6-Express por fecha
	
	var form = document.forms['MWEBNuevaEntregaForm'];
	var idTipo =form['infoEntregaOT.idTipo'].value;
	
	if ( idTipo == '2' || idTipo == '5'  ){
		// S�lo se habilitar� si el art�culo encontrado tiene control por lote ('B')
		var controlStock =form['controlStock'].value;
		if ( controlStock == 'B'  ){
			form.stockLote.readOnly=false;
		} else {
			form.stockLote.value="";
			form.stockLote.readOnly=true;
		}
	} else {
		form.stockLote.value="";
		form.stockLote.readOnly=true;
	}

	//s�lo se habilitar�n si tipo Normal, Express, Normal por Fecha de vencimiento o Express por Fecha de vencimiento 
	//y por tanto, el art�culo encontrado tiene control de fecha de vencimiento.
	if ( idTipo == '1' || idTipo == '4'  || idTipo == '3' || idTipo == '6'  ){
		// S�lo se habilitar� si el art�culo encontrado tiene control de fecha de vencimiento ('C')
		var controlStock =form['controlStock'].value;
		if ( controlStock == 'C'  ){
			form.stockFechaCaducidadIni.readOnly=false;
			form.stockFechaCaducidadFin.readOnly=false;
			form.stockVidaUtil.readOnly=false;
		} else {
		 	form.stockFechaCaducidadIni.value="";
			form.stockFechaCaducidadFin.value="";
			form.stockVidaUtil.value="";
			form.stockFechaCaducidadIni.readOnly=true;
			form.stockFechaCaducidadFin.readOnly=true;
			form.stockVidaUtil.readOnly=true;
		} 
	} else {
	 	form.stockFechaCaducidadIni.value="";
		form.stockFechaCaducidadFin.value="";
		form.stockVidaUtil.value="";
		form.stockFechaCaducidadIni.readOnly=true;
		form.stockFechaCaducidadFin.readOnly=true;
		form.stockVidaUtil.readOnly=true;
	}
}

function estaHabilitado(campo){
	var readonly = document.getElementById(campo).getAttribute("readOnly");
	if(readonly!=null) {
		return false;
	}  else {
		return true;
	}
}
	
	
function irClientesAltaEntrega() {
        //alert(origen);
               
        codSeguimiento=document.getElementById("codSeguimiento").value;
        comentario=document.getElementById("comentario").value;
        proveedor=document.getElementById("proveedor").value;
        
	//document.getElementById('seleccionaArt').action = "pedidosServlet.do?pagina="+pagina+"&origen="+origen+"&codSeguimiento="+codSeguimiento+"&proveedor="+proveedor+"&comentario="+comentario;
	//document.getElementById('seleccionaArt').submit();
     
        document.forms['MWEBNuevaOEForm'].codSeguimiento.value=codSeguimiento;
        document.forms['MWEBNuevaOEForm'].proveedor.value=proveedor;
        document.forms['MWEBNuevaOEForm'].comentario.value=comentario;
	document.forms['MWEBNuevaOEForm'].pagina.value = "irClientesNEp";
        document.forms['MWEBNuevaOEForm'].origen.value = "listaoe";
        //alert(document.forms['MWEBNuevaOEForm'].pagina.value = "irClientesNEp");
        document.forms['MWEBNuevaOEForm'].action = "pedidosServlet.do";
	document.forms['MWEBNuevaOEForm'].submit();
        
    
}
function irClientesEntrega(pagina) {
	document.forms['MWEBFilterOrdenesForm']['pagina'].value = pagina;
        document.forms['MWEBFilterOrdenesForm']['origen'].value = 'listaep';
        document.forms['MWEBFilterOrdenesForm'].action = "pedidosServlet.do";
	document.forms['MWEBFilterOrdenesForm'].submit();
}

function irArticulosEntrega() {
	if (document.forms['MWEBNuevaOEForm'].modo.value == '') {
		document.forms['MWEBNuevaOEForm'].estado.value = 'MODO_ANADIR_ARTICULO';
	}
	else {
		document.forms['MWEBNuevaOEForm'].estado.value = document.forms['MWEBNuevaOEForm'].modo.value;
	}

	//document.forms['MWEBNuevaOEForm']['pagina'].value = origen;
        codSeguimiento=document.getElementById("codSeguimiento").value;
        comentario=document.getElementById("comentario").value;
        proveedor=document.getElementById("proveedor").value;
	document.forms['MWEBNuevaOEForm'].action = "articulosServlet.do?origen=irArticuloNEp"+"&codSeguimiento="+codSeguimiento+"&proveedor="+proveedor+"&comentario="+comentario;
	document.forms['MWEBNuevaOEForm'].submit();
}


function irBusquedaArticulosAltaEntregaStock() {
    cantidad = document.getElementById("cantidad").value;
    codigoArticulo = document.getElementById("codigoArticulo").value;
    codigoArticuloPropietario = document.getElementById("codigoArticuloPropietario").value;
    descripcion=document.getElementById("descripcion").value;
    usuario=document.getElementById("usuario").value;
    var selector = document.getElementById('lote_articulo');
    lote = selector[selector.selectedIndex].text;
    //lote=document.getElementById("lote").value;
    codSeguimiento=document.getElementById("codSeguimiento").value;
    comentario=document.getElementById("comentario").value;
    proveedor=document.getElementById("proveedor").value;
    //alert(lote);
    /*
    datosEnvio="?codigoArticuloPropietario="+codigoArticuloPropietario+"&cantidad="+cantidad+"&codigoArticulo=";
    datosEnvio=datosEnvio+codigoArticulo+"&descripcion="+descripcion+"&pagina=irArticuloNEp&usuario="+usuario+"&origen=irArticuloNEp"+"&lote="+lote;
    datosEnvio=datosEnvio+"&codSeguimiento="+codSeguimiento+"&proveedor="+proveedor+"&comentario="+comentario;
    */ 
    document.forms['MWEBNuevaOEForm'].accion.value="agregar";
    document.forms['MWEBNuevaOEForm'].cantidad.value=cantidad;
    document.forms['MWEBNuevaOEForm'].codigoArticuloPropietario.value=codigoArticuloPropietario;
    document.forms['MWEBNuevaOEForm'].codigoArticulo.value=codigoArticulo;
    document.forms['MWEBNuevaOEForm'].descripcion.value=descripcion        
    document.forms['MWEBNuevaOEForm'].usuario.value=usuario;
    document.forms['MWEBNuevaOEForm'].lotep.value=lote;
    document.forms['MWEBNuevaOEForm'].codSeguimiento.value=codSeguimiento;
    document.forms['MWEBNuevaOEForm'].comentario.value=comentario;
    document.forms['MWEBNuevaOEForm'].proveedor.value=proveedor;
    document.forms['MWEBNuevaOEForm'].origen.value = 'irArticuloNEp';
    document.forms['MWEBNuevaOEForm'].pagina.value = 'irArticuloNEp';
    document.forms['MWEBNuevaOEForm'].action="articulosServlet.do";//+datosEnvio;
    document.forms['MWEBNuevaOEForm'].submit();
    if(cantidad="" || cantidad<1){
        alert("Debe ingresar una cantidad valida");
        cantidad="";
    }
    /*
    document.getElementById("codigoArticulo").value = codigoArticulo;
    document.getElementById("codigoArticuloPropietario").value = codigoArticuloPropietario;
    document.getElementById("descripcion").value = descripcion;
    document.getElementById("usuario").value = usuario;
    document.getElementById("origen").value = 'irArticuloNEp';
    document.getElementById("pagina").value = 'irArticuloNEp';
    
    document.getElementById("seleccionaArt").action="articulosServlet.do";//+datosEnvio;
    document.getElementById("seleccionaArt").submit();
    */
}

// comprueba el codigo del articulo, teniendo en cuenta el codigo del articulo y
// el codigo del artculo del propietario
function compruebaCodigoEntrega(elementoBusqueda) {
	
	/*busquedaAutom = true;
	
	var valueCampoBusqueda = document.getElementById(elementoBusqueda).value;
	var form = document.forms['MWEBNuevaEntregaForm'];
	if (estaVacio (valueCampoBusqueda) ) {
		document.forms['MWEBNuevaEntregaForm'].stockCodigoArticuloPropietario.value="";
		document.forms['MWEBNuevaEntregaForm'].stockCodigoArticulo.value="";
		document.forms['MWEBNuevaEntregaForm'].stockDescripcion.value="";
		document.forms['MWEBNuevaEntregaForm'].stockIdCodigoArticulo.value="";
	} else {
		if (document.forms['MWEBNuevaEntregaForm'].modo.value == '') {
			document.forms['MWEBNuevaEntregaForm'].estado.value = 'MODO_ANADIR_ARTICULO';
		}
		else {
			document.forms['MWEBNuevaEntregaForm'].estado.value = document.forms['MWEBNuevaEntregaForm'].modo.value;
		}
	
		document.forms['MWEBNuevaEntregaForm'].modo.value = 'MODO_BUSCAR_ARTICULO_AUTOMATICO';
		document.forms['MWEBNuevaEntregaForm'].campoBusqueda.value = elementoBusqueda;
		document.forms['MWEBNuevaEntregaForm'].submit();
	}*/
        var codSeguimiento = document.getElementById('codSeguimiento').value;
        var comentario = document.getElementById('comentario').value;
        var proveedor = document.getElementById('proveedor').value;
        var usuario = document.getElementById('usuario').value;
        var valueCampoBusqueda = document.getElementById(elementoBusqueda).value;
        if(elementoBusqueda=="codigoArticulo")
        {
            document.forms['MWEBNuevaOEForm'].codigoArticulo.value=valueCampoBusqueda;
        }else
        {
            document.forms['MWEBNuevaOEForm'].codigoArticuloPropietario.value=valueCampoBusqueda;
        }
        //datosEnvio="articulosServlet.do?"+elementoBusqueda+"="+valueCampoBusqueda+"&pagina="+pagina+"&usuario="+usuariob+"&origen="+origen;
        //datosEnvio=datosEnvio+"&codSeguimiento="+codSeguimiento+"&comentario="+comentario+"&proveedor="+proveedor;
        
        document.forms['MWEBNuevaOEForm'].accion.value="buscar";
        document.forms['MWEBNuevaOEForm'].codSeguimiento.value=codSeguimiento;
        document.forms['MWEBNuevaOEForm'].comentario.value=comentario;
        document.forms['MWEBNuevaOEForm'].proveedor.value=proveedor;
        document.forms['MWEBNuevaOEForm'].pagina.value="irArticuloNEp";
        document.forms['MWEBNuevaOEForm'].origen.value="irArticuloNEp";
        document.forms['MWEBNuevaOEForm'].usuario.value=usuario;
        document.forms['MWEBNuevaOEForm'].action ="articulosServlet.do"; //datosEnvio;
        document.forms['MWEBNuevaOEForm'].submit();
}

function irEliminarProductoEntrega(linea) {
	if ( confirm(txtConfirmarEliminarPdto) ){
		document.forms['MWEBNuevaEntregaForm'].modo.value = 'MODO_ELIMINAR_ARTICULO';
		document.forms['MWEBNuevaEntregaForm'].articuloSelec.value = linea;
		document.forms['MWEBNuevaEntregaForm'].submit();
	}
}

function btBuscarAltaStock() {
	
	if(!busquedaAutom){
		
		var form = document.forms['MWEBNuevaEntregaForm'];
		var listado=[ form['stockCodigoArticuloPropietario'].value, form['stockCodigoArticulo'].value, form['stockLote'].value, form['stockFechaCaducidadIni'].value,  form['stockFechaCaducidadFin'].value, form['stockVidaUtil'].value];
		if (estanTodosCamposVacios(listado)) {
			alert(txtCamposVacios);
			return false;
		} 
		var listadoCodigo=[ form['stockCodigoArticuloPropietario'].value, form['stockCodigoArticulo'].value];
		if (estanTodosCamposVacios(listadoCodigo)) {
			alert(txtArticuloVacio);
			return false;
		} 
		
		if ( validaFechas(form['stockFechaCaducidadIni'].value, form['stockFechaCaducidadFin'].value)) {
			if (!estaVacio(form['stockVidaUtil'].value)) {			
				if (!esEnteroPositivo( form['stockVidaUtil'].value)) {
					alert(mensajeValidacionVidaUtil);
					return false;
				}	
			}
		} else {
			return false;
		}
		form.modo.value = 'MODO_BUSCAR_STOCKS';
		form.action= 'ActualizarNuevaEntrega.do';
		form.submit();
		
	}
 
}

function btAnadirProductosAltaEntrega() {
	if (comprobarCantidad() ) {
		//if (hayCantidadCero () ) {
			var form = document.forms['MWEBNuevaEntregaForm'];
			form.modo.value = 'MODO_ANADIR_ARTICULO';
			form.action= 'ActualizarNuevaEntrega.do';
			form.submit();
		//}
	}
}


function comprobarCantidad() {
	var form = document.forms['MWEBNuevaEntregaForm'];
	var alertas = [];
	if ( form['valorCantidad'].length === undefined) {
    		validaCantidad (alertas,  form['valorCantidad'].value,  form['cantidadDisponible'].value, form['codigoArticulo'].value );
	} else {
		for (i=0; i<form['valorCantidad'].length; i++)
	    {
	    	validaCantidad (alertas,  form['valorCantidad'][i].value,  form['cantidadDisponible'][i].value, form['codigoArticulo'][i].value );
	    }
	}
  	if (ponerAlerta(alertas)) {
			return false;
	}
	return true;
}

function hayCantidadCero() 
{
   var form = document.forms['MWEBNuevaEntregaForm'];
   var  bExiste=false;
   var alertas = [];
   if ( form['valorCantidad'].length === undefined) {
		if ( form['valorCantidad'].value == "0" ) {
			bExiste=true;
		}
	} else {
		var x=0;
			while(x<i<form['valorCantidad'].length &&  !bExiste)
			{
			if ( form['valorCantidad'][x].value == "0" ) {
				bExiste=true;
			}
			x=x+1;
		}
	}
	return true;
	
}


function validaCantidad( alertas, cantidad, cantidadDiponible, codigo) {
    if (estaVacio(cantidad) || !esEnteroPositivo(cantidad) || parseInt(cantidad, 10) > parseInt(cantidadDiponible, 10)  ){
    	alertas.push(codigo + ":" + txtCantidad);
     }
}

/* TAB DOCUMENTACION*/
function btAdjuntarDocumentoAltaEntrega(  ){
 		if (estaVacio(document.forms['MWEBNuevaEntregaForm'].fichero.value)) {
   			alert(mensajeValidacionNoAdjunto);
   		} else if (compruebaExtension(document.forms['MWEBNuevaEntregaForm'].fichero.value)) {
			document.forms['MWEBNuevaEntregaForm'].modo.value='MODO_GUARDA_FICHERO';
   		document.forms['MWEBNuevaEntregaForm'].submit();
		}	
}
     

function irEliminarDocumentoAltaEntrega(rutaFichero) {
	document.forms['MWEBNuevaEntregaForm'].modo.value = 'MODO_BORRA_FICHERO';
	document.forms['MWEBNuevaEntregaForm'].ficheroAEliminar.value = rutaFichero;
	document.forms['MWEBNuevaEntregaForm'].submit();
}


function irSubiendoArchivoPedido(ruta,pagina,idCliente) 
{    

        var fileElement = document.getElementById('fichero');
        var fileExtension = "";
        fileExtension=fileElement.value.split('.')[1];
       // alert(fileExtension);
        
        document.forms['MWEBSubirArchivosForm']['pagina'].value = pagina;
        document.forms['MWEBSubirArchivosForm']['extension'].value = fileExtension;
        document.forms['MWEBSubirArchivosForm']['rutaexcel'].value = ruta;
        document.forms['MWEBSubirArchivosForm']['idcliente'].value = idCliente;
	document.forms['MWEBSubirArchivosForm'].action = "PedidosUploadIngreso.do";
	document.forms['MWEBSubirArchivosForm'].submit();
}

function ProcesarTablaPedido()
{
    document.forms['MWEBProcesarTablaPedido'].action = "procesarTablaPedido.do";
    document.forms['MWEBProcesarTablaPedido'].submit();
}

function LimpiarPaginaPedido()
{
    document.forms['MWEBProcesarTablaPedido'].action = "PedidosUploadIngreso.do";
    document.forms['MWEBProcesarTablaPedido'].submit();
}