/////////////////////////////////////////
/////////// <GESTION_STOCK>  //////////// 
/////////////////////////////////////////
   
//comprobamos que los parametros para realizar la busqueda sean correctos 
//asignamos el modo
function btBuscarStock(){
		var form = document.forms['MWEBFilterStockForm'];
		var listado=[ form['codigoArticuloPropietario'].value, form['codigoArticulo'].value, 
                            form['descripcion'].value, form['categoria'].value, form['lote'].value,
                            form['fechaIni'].value, form['fechaFin'].value  ];
		if (estanTodosCamposVacios(listado) ) {
			alert(txtCamposVacios);
		}
		else if (validaFechasStock()){
			//form['modo'].value = modo;
                        //alert(listado);
    	    document.forms['MWEBFilterStockForm'].submit();	    
     	} 
} 

function validaFechasStock(){
	var fechaIni = document.forms['MWEBFilterStockForm']['fechaIni'].value;
	var fechaFin = document.forms['MWEBFilterStockForm']['fechaFin'].value;
	if (  estaVacio(fechaIni) && estaVacio(fechaFin) ){
		return true;
	}
	else {
		var alertas=[];
		if (  (  !estaVacio(fechaIni) && estaVacio(fechaFin) ) 
			||  (  estaVacio(fechaIni) && !estaVacio(fechaFin)  )   ){
				alertas.push(txtFechasIncompletas);
		}
		if ( ! esFechaValida(fechaIni)) {
				alertas.push(txtFhInicialError);
		}
		
		if ( ! esFechaValida(fechaFin)) {
				alertas.push(txtFhFinalError);
		} 
		
		if ( ! compararFechas(fechaIni, fechaFin)) {
				alertas.push(txtRangoError);
		}
		if ( alertas.length > 0 ){
			ponerAlerta(alertas);
			return false;
		}
	}
	
	return true;
}
	
function btLimpiarBusquedaStock(modo){
	location.href = 'stockServlet.do';
	/*var form = document.forms['MWEBFilterStockForm'];
	form['modo'].value = modo;			
    form.submit();*/
  		 
}

function btImprimirStock(modo){
    window.open('ImprimeStocksAction.do');
}

function btDescargarExcelStock() {
	location.href = 'ExportarDetalleExcelStockAction.do';
}

function irDetalleStock( codArtPropietario,cantidad){
	     
	   var form = document.forms['MWEBFilterStockForm'];
	   //form['idArticulo'].value = idArticulo;
           //alert(codArtPropietario);
	   form['codArtPropietarioDetalle'].value = codArtPropietario;
           form['cantidad'].value = cantidad; 
           form['origen'].value = 'detalleStock'; 
	   form.action = "stockServlet.do";			
	   form.submit();
}
 
function irBusquedaArticulosStock(modo){
	var form = document.forms['MWEBFilterStockForm'];
	form['modo'].value = modo;			
    form.submit();
}

//para el detalle de stocks
function irVolverBusquedaStocksdesdeDetalle(modoVolver){
	var form = document.forms['MWEBStockDetalleForm'];	
	form['modoDetalle'].value = modoVolver;			
    form.submit();
}

function irABusquedaDetalleStock(modoBusqueda, almacenParticular, estadoCalidad){
	var form = document.forms['MWEBStockDetalleForm'];	
	form['modoDetalle'].value = modoBusqueda;
	form['almacenParticular'].value = almacenParticular;
	form['estadoCalidad'].value = estadoCalidad;
    form.submit();
}
//fin detalle stocks


function btVolverConsultaStock(){
	
	location.href = 'GestorBusquedaStocks.do';
	  
} 

function irSeleccionarArticuloStock(codigoPropietario, codigoArticulo, descripcion,
		categoria) {
	document.forms['resultados']['codigoArticuloPropietario'].value = codigoPropietario;
	document.forms['resultados']['codigoArticulo'].value = codigoArticulo;
	document.forms['resultados']['descripcion'].value = descripcion;
	document.forms['resultados']['categoria'].value = categoria;
	document.forms['resultados'].action = "GestorBusquedaStocks.do";
	document.forms['resultados'].submit();
}
