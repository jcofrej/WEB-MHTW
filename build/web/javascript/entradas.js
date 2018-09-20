/////////////////////////////////////////
////////// <GESTION_ENTRADAS> /////////// 
/////////////////////////////////////////

/* Consulta Ordenes de entrada */
function btBuscarOE(){
        document.forms['MWEBFilterOrdenesForm']['pagina'].value="";
	var form = document.forms['MWEBFilterOrdenesForm'];
	var listado=[ form['codSeguimiento'].value, form['codGL'].value, form['fechaIni'].value, form['fechaFin'].value, form['proveedor'].value];
	if (estanTodosCamposVacios(listado) ) {
		alert(txtCamposVacios);
	}
	else if (validaFechasOE()){
	     document.forms['MWEBFilterOrdenesForm'].submit();	    
 	} 
} 

function validaFechasOE() {
	var fechaIni = document.forms['MWEBFilterOrdenesForm']['fechaIni'].value;
	var fechaFin = document.forms['MWEBFilterOrdenesForm']['fechaFin'].value;
	if (estaVacio(fechaIni) && estaVacio(fechaFin)) {
		return true;
	}
	else {
		var alertas = [];
		if ((!estaVacio(fechaIni) && estaVacio(fechaFin))
				|| (estaVacio(fechaIni) && !estaVacio(fechaFin))) {
			alertas.push(txtFechasIncompletas);
		}
		if (!esFechaValida(fechaIni)) {
			alertas.push(txtFhInicialError);
		}

		if (!esFechaValida(fechaFin)) {
			alertas.push(txtFhFinalError);
		}

		if (!compararFechas(fechaIni, fechaFin)) {
			alertas.push(txtRangoError);
		}
		if (ponerAlerta(alertas)) {
			return false;
		}
	}
	return true;
}

function btImprimirOE() {
	window.open('ImprimeOrdenesEntradaAction.do');
}

function irNuevaOE(pagina) {
        document.forms['MWEBFilterOrdenesForm']['pagina'].value = pagina;
	document.forms['MWEBFilterOrdenesForm'].action = "ordenesServlet.do";
	document.forms['MWEBFilterOrdenesForm'].submit();
	//location.href = 'ordenesServlet.do?pagina=nuevaoe';

}

function btLimpiarBusqueda() {
	location.href = 'ordenesServlet.do';
}

function irDetalleOE(codigoOE) {
	document.forms['MWEBAccionOEForm']['codigoOE'].value = codigoOE;
	document.forms['MWEBAccionOEForm']['pageCurrent'].value = document.forms['MWEBFilterOrdenesForm']['pageCurrent'].value;
	document.forms['MWEBAccionOEForm'].action = "ordenesServlet.do";
	document.forms['MWEBAccionOEForm'].submit();
}


function irEditarOE(codigoOE){
	document.forms['MWEBAccionOEForm']['codigoOE'].value = codigoOE;
	document.forms['MWEBAccionOEForm']['pageCurrent'].value = document.forms['MWEBFilterOrdenesForm']['pageCurrent'].value;
	document.forms['MWEBAccionOEForm'].action = "EditarOE.do";
	document.forms['MWEBAccionOEForm'].submit();
}

function irProveedoresOE(pagina) {
	document.forms['MWEBFilterOrdenesForm']['pagina'].value = pagina;
        document.forms['MWEBFilterOrdenesForm']['origen'].value = 'listaoe';
        document.forms['MWEBFilterOrdenesForm'].action = "ordenesServlet.do";
	document.forms['MWEBFilterOrdenesForm'].submit();
}

function irAnularOE(codigoOE, txtConfirmacion) {
	if (confirm(txtConfirmacion)) {
		document.forms['MWEBAccionOEForm']['codigoOE'].value = codigoOE;
		document.forms['MWEBAccionOEForm']['pageCurrent'].value = document.forms['MWEBFilterOrdenesForm']['pageCurrent'].value;
		document.forms['MWEBAccionOEForm'].action = "AnularOE.do";
		document.forms['MWEBAccionOEForm'].submit();
	}
}



/*  Proveedores */
function btLimpiarBusquedaProveedores(){
                document.forms['MWEBFilterProveedorForm']['pagina'].value ='irProveedoresNOe';
                
		document.forms['MWEBFilterProveedorForm'].action = "ordenesServlet.do";
		document.forms['MWEBFilterProveedorForm'].submit();
	 	
}

function irSeleccionarProveedorAltaOE(codigo) {
	document.forms['resultados']['codProveedor'].value = codigo;
	document.forms['resultados'].action = "ActualizarNuevaOE.do";
	document.forms['resultados'].submit();
}

function irSeleccionarProveedorOE(codigo,destino,codSeguimiento,comentario) {
        //alert(destino);
	document.forms['resultados']['pagina'].value = destino;
        document.forms['resultados']['proveedor'].value = codigo;
        document.forms['resultados']['codSeguimiento'].value = codSeguimiento;
        document.forms['resultados']['comentario'].value = comentario;
	document.forms['resultados'].action = "ordenesServlet.do";
	document.forms['resultados'].submit();
}

function btVolverOE() {
	location.href = 'ordenesServlet.do';
}



/* Detalle Ordenes de entrada */
function btDescargarPdfOE() {
	window.open('ExportarDetallePDFOrdenesEntradaAction.do');
}

function btDescargarExcelOE() {
	location.href = 'ExportarDetalleExcelOrdenesEntradaAction.do';
}




/* Alta-Modificacion ordenes de entrada */
function btGuardarAltaOE(){
    /*if ( comprobarGuardarAltaOE()){
        document.forms['MWEBNuevaOEForm'].submit();
        
    }*/
    codSeg=document.getElementById('codSeguimiento').value;
    idProv=document.getElementById('proveedor').value;
    coment=document.getElementById('comentario').value;
    datoEnv="?codigoSeguimiento="+codSeg+"&proveedor="+idProv+"&comentario="+coment;
    //alert("rcpMhServlet.do");
    document.getElementById('seleccionaArt').action="rcpMhServlet.do"+datoEnv;
    document.getElementById('seleccionaArt').submit();
}

function btCancelarAltaOE() {
	location.href = 'ordenesServlet.do';
}



function irProveedoresAlta() {

        codSeguimiento=document.getElementById("codSeguimiento").value;
        comentario=document.getElementById("comentario").value;
        proveedor=document.getElementById("proveedor").value;
        //Aqui nos vamos al menu
        //datosEnvio="ordenesServlet.do?pagina="+pagina+"&origen="+origen+"&codSeguimiento="+codSeguimiento+"&proveedor="+proveedor+"&comentario="+comentario;
	document.forms['MWEBNuevaOEForm'].codSeguimiento.value=codSeguimiento;
        document.forms['MWEBNuevaOEForm'].proveedor.value=proveedor;
        document.forms['MWEBNuevaOEForm'].comentario.value=comentario;
        document.forms['MWEBNuevaOEForm'].pagina.value="irProveedoresNOe";
        document.forms['MWEBNuevaOEForm'].origen.value="retornoNOe";
        document.forms['MWEBNuevaOEForm'].action = "ordenesServlet.do";
	document.forms['MWEBNuevaOEForm'].submit();

}

function irArticulosOE() {
	/*if (document.forms['MWEBNuevaOEForm'].modo.value == '') {
		document.forms['MWEBNuevaOEForm'].estado.value = 'MODO_ANADIR_ARTICULO';
	}
	else {
		document.forms['MWEBNuevaOEForm'].estado.value = document.forms['MWEBNuevaOEForm'].modo.value;
	}*/
        //alert(origen);
	document.forms['MWEBNuevaOEForm']['origen'].value = "irArticuloNOe";
        codSeguimiento=document.getElementById("codSeguimiento").value;
        comentario=document.getElementById("comentario").value;
        proveedor=document.getElementById("proveedor").value;
        //pagina=document.getElementById("pagina").value;
        //document.forms['MWEBNuevaOEForm'].pagina.value="irArticuloNOe";
        document.forms['MWEBNuevaOEForm'].codSeguimiento.value=codSeguimiento;
        document.forms['MWEBNuevaOEForm'].proveedor.value=proveedor;
        document.forms['MWEBNuevaOEForm'].comentario.value=comentario;
        
        //datosEnvio="articulosServlet.do?origen="+origen+"&codSeguimiento="+codSeguimiento+"&proveedor="+proveedor+"&comentario="+comentario;
	//document.forms['MWEBNuevaOEForm'].action = datosEnvio;
        document.forms['MWEBNuevaOEForm'].action = "articulosServlet.do";
	document.forms['MWEBNuevaOEForm'].submit();
}

function btAnadirArticuloAltaOE() {
    
    cantidad = document.getElementById("cantidad").value;
    
    codigoArticulo = document.getElementById("codigoArticulo").value;
    codigoArticuloPropietario = document.getElementById("codigoArticuloPropietario").value;
    descripcion=document.getElementById("descripcion").value;
    usuario=document.getElementById("usuario").value;
    codSeguimiento=document.getElementById("codSeguimiento").value;
    comentario=document.getElementById("comentario").value;
    proveedor=document.getElementById("proveedor").value;
    
    document.forms['MWEBNuevaOEForm'].cantidad.value=cantidad;
    document.forms['MWEBNuevaOEForm'].accion.value="agregar";
    document.forms['MWEBNuevaOEForm'].codigoArticuloPropietario.value=codigoArticuloPropietario;
    document.forms['MWEBNuevaOEForm'].codigoArticulo.value=codigoArticulo;
    document.forms['MWEBNuevaOEForm'].descripcion.value=descripcion        
    document.forms['MWEBNuevaOEForm'].usuario.value=usuario;
    document.forms['MWEBNuevaOEForm'].codSeguimiento.value=codSeguimiento;
    document.forms['MWEBNuevaOEForm'].comentario.value=comentario;
    document.forms['MWEBNuevaOEForm'].proveedor.value=proveedor;
    document.forms['MWEBNuevaOEForm'].pagina.value="irArticuloNOe";
    document.forms['MWEBNuevaOEForm'].origen.value="irArticuloNOe";
    /*datosEnvio="?codigoArticuloPropietario="+codigoArticuloPropietario+"&cantidad="+cantidad+"&codigoArticulo=";
    datosEnvio=datosEnvio+codigoArticulo+"&descripcion="+descripcion+"&pagina=irArticuloNOe&usuario="+usuario+"&origen=irArticuloNOe";
    datosEnvio=datosEnvio+"&codSeguimiento="+codSeguimiento+"&proveedor="+proveedor+"&comentario="+comentario;*/
    document.forms['MWEBNuevaOEForm'].action="articulosServlet.do";//+datosEnvio;
    document.forms['MWEBNuevaOEForm'].submit();
    if(cantidad="" || cantidad<1){
        alert("Debe ingresar una cantidad valida");
        cantidad="";
    }
    

}
function btAnadirArticuloAltaOEOld(listaArticulos) {
        //alert(listaArticulos);
        //("hola");
        numeroLinea = document.getElementById("numeroLinea").value;
	cantidad = document.getElementById("cantidad").value;
	//tolerancia = document.getElementById("tolerancia").value;
	codigoArticuloPorpietario = document.getElementById("codigoArticuloPropietario").value;
	codigoArticulo = document.getElementById("codigoArticulo").value;
	textoErrores = "";
	errores = false;
	
	if(numeroLinea != '' || numeroLinea.length > 25){ 
		//validar linea	 articulo no repetida 
		encontrado = false;
		var i = 0;
		for(i = 0; i < listaArticulos.length && !encontrado; i++){ 
			if(listaArticulos[i] ==	 numeroLinea){ 
				encontrado = true; 
				errores = true; 
				textoErrores= textoErrores + codLineaMsg + '\n'; 
			} 
		} 
	}
	else if (numeroLinea!=''){ 
		 errores = true;
	     textoErrores= textoErrores + codLineaMsgNoFormato + '\n'; 
	}
	 
	//comprobar cantidad 
	if((!esEntero(cantidad)) || (cantidad > 999999999) || (cantidad < 1)){ 
		 errores = true; textoErrores= textoErrores + cantidadMsg + '\n';
	}
	  
	//comprobar tolerancia 
	/*if((!esEntero(tolerancia)) || (tolerancia < 0) || (tolerancia > 100)){ 
		 errores = true;
	    textoErrores =textoErrores + toleranciaMsg + '\n';
	}*/
	 
	//comprobar codigo articulo propietario
	if(codigoArticuloPorpietario.length > 31){ 
		 errores = true; textoErrores = textoErrores + codArtPropMsg + '\n';
	}
	 
	 //comprobamos articulo 
	if((codigoArticulo.length == undefined) || (codigoArticulo.length < 1) ){ 
		 errores = true; textoErrores =textoErrores + 	 codArtMsg + '\n';
	}
	 

	if (!errores) {
            document.forms['MWEBNuevaOEForm']['cantidad'].value = cantidad;
            document.forms['MWEBNuevaOEForm']['codigoArticulo'].value = codigoArticulo;
            document.forms['MWEBNuevaOEForm']['codigoArticuloPropietario'].value = codigoArticuloPorpietario;
            document.forms['MWEBNuevaOEForm'].action = "articulosServlet.do";
            document.forms['MWEBNuevaOEForm'].submit();
	}
	else {
		alert(textoErrores);
	}

}


// comprueba el codigo del articulo, teniendo en cuenta el codigo del articulo y
// el codigo del articulo del propietario
function compruebaCodigo(elementoBusqueda) {
	
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
        
        document.forms['MWEBNuevaOEForm'].codSeguimiento.value=codSeguimiento;
        document.forms['MWEBNuevaOEForm'].comentario.value=comentario;
        document.forms['MWEBNuevaOEForm'].proveedor.value=proveedor;
        document.forms['MWEBNuevaOEForm'].pagina.value="irArticuloNOe";
        document.forms['MWEBNuevaOEForm'].origen.value="irArticuloNOe";
        document.forms['MWEBNuevaOEForm'].usuario.value=usuario;
        document.forms['MWEBNuevaOEForm'].action ="articulosServlet.do"; //datosEnvio;
        document.forms['MWEBNuevaOEForm'].submit();
	
}


function irModificarProductoOE(linea,cantidad,index) {
    var vrcantidad=0;
    var codSeguimiento = document.getElementById('codSeguimiento').value;
    var comentario = document.getElementById('comentario').value;
    var proveedor = document.getElementById('proveedor').value; 
    if (cantidad==1){
            vrcantidad = document.getElementById('cantidadm').value;    
        }
        if (cantidad>1)
        {
            vrcantidad = document.getElementsByName('cantidadm')[index].value;    
        }
        
        document.forms['MWEBNuevaOEForm'].codSeguimiento.value=codSeguimiento;
        document.forms['MWEBNuevaOEForm'].proveedor.value=proveedor;
        document.forms['MWEBNuevaOEForm'].comentario.value=comentario;
        document.forms['MWEBNuevaOEForm'].cantidadm.value=vrcantidad;
        document.forms['MWEBNuevaOEForm'].accion.value="modificar";
        document.forms['MWEBNuevaOEForm'].articuloSelec.value = linea;
        document.forms['MWEBNuevaOEForm'].origen.value = 'irArticuloNOe';
        document.forms['MWEBNuevaOEForm'].pagina.value = 'irArticuloNOe';
	//document.forms['MWEBNuevaOEForm'].modo.value = 'MODO_MODIFICAR_ARTICULO';
	//document.forms['MWEBNuevaOEForm'].estado.value = document.forms['MWEBNuevaOEForm'].modo.value;
        //document.forms['MWEBNuevaOEForm'].action = "meoeServlet.do";
        document.forms['MWEBNuevaOEForm'].action = "articulosServlet.do"
	document.forms['MWEBNuevaOEForm'].submit();
}

function btCancelarModificarArticuloAltaOE() {
	document.forms['MWEBNuevaOEForm'].modo.value = 'MODO_CANCELAR_MODIFICAR_ARTICULO';
	document.forms['MWEBNuevaOEForm'].submit();
}

function irModificarProdOE(linea,cantidad,index) {
        var vrcantidad=0;
	var codSeguimiento = document.getElementById('codSeguimiento').value;
        var comentario = document.getElementById('comentario').value;
        var proveedor = document.getElementById('proveedor').value;   
        if (cantidad==1){
            vrcantidad = document.getElementById('cantidadm').value;    
            var selector = document.getElementById('lote_articulom');
            lote = selector[selector.selectedIndex].text;
        }
        if (cantidad>1)
        {
            vrcantidad = document.getElementsByName('cantidadm')[index].value;    
            var selector = document.getElementsByName('lote_articulom')[index];
            lote = selector[selector.selectedIndex].text;
        }
        
        
        document.forms['MWEBNuevaOEForm'].codSeguimiento.value=codSeguimiento;
        document.forms['MWEBNuevaOEForm'].proveedor.value=proveedor;
        document.forms['MWEBNuevaOEForm'].comentario.value=comentario;
        document.forms['MWEBNuevaOEForm'].cantidadm.value=vrcantidad;
        document.forms['MWEBNuevaOEForm'].lotep.value=lote;
        document.forms['MWEBNuevaOEForm'].accion.value="modificar";
        document.forms['MWEBNuevaOEForm'].articuloSelec.value = linea;
        document.forms['MWEBNuevaOEForm'].origen.value = 'irArticuloNEp';
        document.forms['MWEBNuevaOEForm'].pagina.value = 'irArticuloNEp';        
        document.forms['MWEBNuevaOEForm'].action = "articulosServlet.do"
        //document.forms['MWEBNuevaOEForm'].action = "meoeServlet.do";
        document.forms['MWEBNuevaOEForm'].submit();

}


function irEliminarProductoOE(linea,vrpagina) {
	var codSeguimiento = document.getElementById('codSeguimiento').value;
        var comentario = document.getElementById('comentario').value;
        var proveedor = document.getElementById('proveedor').value;
        confirmar=confirm("Desea eliminar la linea "+linea +"?..");
        
        if (confirmar){
            document.forms['MWEBNuevaOEForm'].codSeguimiento.value=codSeguimiento;
            document.forms['MWEBNuevaOEForm'].proveedor.value=proveedor;
            document.forms['MWEBNuevaOEForm'].comentario.value=comentario;
            document.forms['MWEBNuevaOEForm'].accion.value="elimina";
            document.forms['MWEBNuevaOEForm'].pagina.value = vrpagina; 
            document.forms['MWEBNuevaOEForm'].articuloSelec.value = linea;
            document.forms['MWEBNuevaOEForm'].action = "meoeServlet.do";
            document.forms['MWEBNuevaOEForm'].submit();
        }else{
            
        }  
}

function btAdjuntarDocumentoAltaOE(  ){
 		if (estaVacio(document.forms['MWEBNuevaOEForm'].fichero.value)) {
   			alert(mensajeValidacionNoAdjunto);
   		} else if (compruebaExtension(document.forms['MWEBNuevaOEForm'].fichero.value)) {
			document.forms['MWEBNuevaOEForm'].modo.value='MODO_GUARDA_FICHERO';
   		document.forms['MWEBNuevaOEForm'].submit();
		}	
}
     

function irEliminarDocumentoAltaOE(rutaFichero) {
	document.forms['MWEBNuevaOEForm'].modo.value = 'MODO_BORRA_FICHERO';
	document.forms['MWEBNuevaOEForm'].ficheroAEliminar.value = rutaFichero;
	document.forms['MWEBNuevaOEForm'].submit();
}

/* Articulos */
function btLimpiarBusquedaArticulos(){
                document.forms['MWEBFilterOrdenesForm'].proveedor.value="";
		location.href='articulosServlet.do';	 
}

function btBuscarArticulos(){
		var form = document.forms['MWEBFilterArticulosForm'];
		var listado=[ form['codigoArticuloPropietario'].value, form['codigoArticulo'].value, form['descripcion'].value];
		if (estanTodosCamposVacios(listado) && estaVacioSelect(form['categoria'].value) ) {
			alert(txtCamposVacios);
		   //No compruebo el size de los campos. Estan limitados con el maxLengh	
		}
		else {
    	     document.forms['MWEBFilterArticulosForm'].submit();	    
     	} 
			 
}

function irSeleccionarArticulo(codigoPropietario, codigoArticulo, descripcion,
		categoria,pagina,origen,codSeguimiento,comentario,proveedor) {
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

function btVolverAltaOE(pagina) {
    document.forms['MWEBFilterArticulosForm']['pagina'].value = pagina;
    document.forms['MWEBFilterArticulosForm'].action = "ordenesServlet.do";
    document.forms['MWEBFilterArticulosForm'].submit();
}
function irUploadIngreso(pagina) {
        document.forms['MWEBFilterOrdenesForm']['pagina'].value = pagina;
	document.forms['MWEBFilterOrdenesForm'].action = "ordenesServlet.do";
	document.forms['MWEBFilterOrdenesForm'].submit();
}

function irSubiendoArchivo(ruta,pagina,idCliente) {
         

        document.forms['MWEBSubirArchivosForm']['pagina'].value = pagina;
        document.forms['MWEBSubirArchivosForm']['rutaexcel'].value = ruta;
        document.forms['MWEBSubirArchivosForm']['idcliente'].value = idCliente;
	document.forms['MWEBSubirArchivosForm'].action = "ordenesUploadIngreso.do";
	document.forms['MWEBSubirArchivosForm'].submit();

}

function ProcesarTabla()
{
    document.forms['MWEBProcesarTablaIngreso'].action = "procesarTablaIngreso.do";
    document.forms['MWEBProcesarTablaIngreso'].submit();
}

function LimpiarPagina()
{
    document.forms['MWEBProcesarTablaIngreso'].action = "ordenesUploadIngreso.do";
    document.forms['MWEBProcesarTablaIngreso'].submit();
}

function LimpiarUploadIngreso()
{
    document.forms['MWEBVolverSubirArchivo'].action = "ordenesUploadIngreso.do";
    document.forms['MWEBVolverSubirArchivo'].submit();
}
