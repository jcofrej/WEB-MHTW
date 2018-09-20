// comun
function enContruccion() {
	location.href = 'enConstruccion.do';
}

function btVolver(action) {
	location.href = action;
}
//Cerrar Session
function irCerrarSesion() {
	location.href = 'cerrarSesion.do';
}

/* Menu */
function irMenuGestionOE() {
	location.href = 'ordenesServlet.do';
}

function irConsultaOrdenesEntrada() {
        //reenvia  a la pagina.
        /*alert(pagina);
        if(pagina!='')
        {
            document.forms['MWEBFilterArticulosForm'].pagina.value=pagina;
            document.forms['MWEBFilterArticulosForm'].action='ordenesServlet.do';
            document.forms['MWEBFilterArticulosForm'].submit();
        }else{*/
            location.href = 'ordenesServlet.do';
        /*}*/
}
function irConsultaEntrega() {
	location.href = 'pedidosServlet.do';
}

function irMenuGestionEntregas(){
        location.href='pedidosServlet.do'; 		    
} 
  
function irMenuGestionStock(){
        location.href='stockServlet.do'; 		    
}

function irMenuAcercaDe(){
	location.href='PaginaAcercaDe.do';
} 
 
function irMenuChgPwd(){
	location.href='cambioPass.do';
} 
function irMenuGestionUsuario(){
	location.href='gestionUsuarioServlet.do';
}  

function btLimpiarBusquedaUsuarios()
{
    location.href = 'gestionUsuarioServlet.do';
}

function irNuevoUsuario(pagina)
{
    if (pagina=="GuardarUsuario")
    {
       var vrusu=document.getElementById('nusuario').value;
       if (vrusu=='')
       {
           alert('Debe ingresar el nombre de usuario');
           document.getElementById('nusuario').focus();
           return false;
       }
       var vrcla=document.getElementById('pass').value;
       if (vrcla=='')
       {
           alert('Debe ingresar la contraseña');
           document.getElementById('pass').focus();
           return false;
       }       
       var vrnom=document.getElementById('nombre').value;
       if (vrnom=='')
       {
           alert('Debe ingresar el nombre completo');
           document.getElementById('nombre').focus();
           return false;
       }        
       var vrIdCliente=document.getElementById('idcliente').value;
       if (vrIdCliente=='0')
       {
           alert('Debe seleccionar el cliente');
           document.getElementById('idcliente').focus();
           return false;
       }
    }
    
    document.forms['MWEBFilterOrdenesForm']['pagina'].value = pagina;
    document.forms['MWEBFilterOrdenesForm'].action = "gestionUsuarioServlet.do";
    document.forms['MWEBFilterOrdenesForm'].submit();
}

/*  PAGINACION */
function irPage(page, div, tab) {
	var t = document.getElementById(div);
	var res;
	if (page=="previous") {
		res=Table.pagePrevious(t);
	}
	else if (page=="next") {
		res=Table.pageNext(t);
	} 
	else {
		res=Table.page(t,page);
	}
	if (res){
		var currentPage = res.page+1;
		desactivarPager(tab, res.pagecount, currentPage);
		activarPager(currentPage,tab);
		actualizaPageCurrent(currentPage,div);			
	}
}

function desactivarPager(tab, pagecount, currentPage) {
		var modulo = currentPage%10;
		if (modulo == 0) modulo = 10;
		var inicio = currentPage - modulo + 1;
		var fin = currentPage - modulo + 10;
		var pagina;
		var bAcabar=false;
		var i=1;
		while (!bAcabar) 
		{
			if (document.getElementById(tab+'page'+i))
			{
				pagina = document.getElementById(tab+'page'+i);
				pagina.style.backgroundColor="#FFFF99";
				
				if (i<inicio || i>fin){
					pagina.style.display = 'none';
				}else{
					pagina.style.display = '';
				}
				
			} else {
				bAcabar=true;
			}
			i++;
		}			
}

function activarPager(currentPage,tab) {
	var paginaActual;
	if (document.getElementById(tab+'page' + currentPage))
	{
		paginaActual = document.getElementById(tab+'page' + currentPage);
		paginaActual.style.backgroundColor = "#FFCC33";
	}
}

function actualizaPageCurrent(currentPage,div) {
	if ( div=="DIAnetTableListadoOrdenes") {
			document.forms['MWEBFilterOrdenesForm']['pageCurrent'].value=currentPage;
	}  else if (   div=="DIAnetTableListadoEntregas")  {
   				document.forms['MWEBFilterEntregaForm']['pageCurrent'].value=currentPage;
	}
	if (div == "DIAnetTableProductosAlta"){
				document.forms['MWEBNuevaOEForm']['pageCurrentTab1'].value=currentPage;
	} else if (div == "DIAnetTableValoresAgregadosAlta"){
				document.forms['MWEBNuevaOEForm']['pageCurrentTab2'].value=currentPage;
	} else if (div == "DIAnetTableDocumentacionAlta"){
				document.forms['MWEBNuevaOEForm']['pageCurrentTab3'].value=currentPage;
	} 
	
	if(div == "DIAnetTableListadoStocks"){
		document.forms['MWEBFilterStockForm']['pageCurrent'].value=currentPage;
	}
	
}

/*
Tab detalle.
Comun para entregas y ordenes de entrada
*/
function cambiarTabDetalle(numTab) {
	document.getElementById("tabProductosDetalle").style.display = "none";
	document.getElementById("tabValoresDetalle").style.display = "none";
	document.getElementById("etiquetaTabProductosDetalle").style.backgroundColor = "#FFFFFF";
	document.getElementById("etiquetaTabValoresDetalle").style.backgroundColor = "#FFFFFF";
	switch (numTab) {
		case 1:
			// mostramos elcontenido de la primera opcion
			document.getElementById("tabProductosDetalle").style.display = "block";
			document.getElementById("etiquetaTabProductosDetalle").style.backgroundColor = "#EAEAEA";
			break;
		case 2:
			// mostramos elcontenido de la segunda opcion
			document.getElementById("tabValoresDetalle").style.display = "block";
			document.getElementById("etiquetaTabValoresDetalle").style.backgroundColor = "#EAEAEA";
			break;
	}
}

function cambiarTabAlta(numTab) {
	document.getElementById("tabProductosAlta").style.display = "none";
	document.getElementById("tabValoresAlta").style.display = "none";
	document.getElementById("tabDocumentacionAlta").style.display = "none";
	document.getElementById("etiquetaTabProductosAlta").style.backgroundColor = "#FFFFFF";
	document.getElementById("etiquetaTabValoresAlta").style.backgroundColor = "#FFFFFF";
	document.getElementById("etiquetaTabDocumentacionAlta").style.backgroundColor = "#FFFFFF";
	switch (numTab) {
		case 1:
			// mostramos elcontenido de la primera opcion
			document.getElementById("tabProductosAlta").style.display = "block";
			document.getElementById("etiquetaTabProductosAlta").style.backgroundColor = "#EAEAEA";
			//nameFocus=document.getElementById("etiquetaTabProductosAlta").getAttributeNode("focusValue").value;
			//document.getElementsByName(nameFocus)[0].focus();
			break;
		case 2:
			// mostramos elcontenido de la segunda opcion
			document.getElementById("tabValoresAlta").style.display = "block";
			document.getElementById("etiquetaTabValoresAlta").style.backgroundColor = "#EAEAEA";
			break;
		case 3:
			// mostramos elcontenido de la tercera opcion
			document.getElementById("tabDocumentacionAlta").style.display = "block";
			document.getElementById("etiquetaTabDocumentacionAlta").style.backgroundColor = "#EAEAEA";
			break;
	}

}

function cambiarTabAltaFocus(numTab) {
	cambiarTabAlta(numTab);
	switch (numTab) {
	case 1:
		tabRef="etiquetaTabProductosAlta";
		break;
	case 2:
		tabRef="etiquetaTabValoresAlta";
		break;
	case 3:
		tabRef="etiquetaTabDocumentacionAlta";
		break;
	}	
	focusName=document.getElementById(tabRef).getAttributeNode("focusValue").value;
	document.getElementsByName(focusName).item(0).focus();
}

function cambiarTabAltaFocus(numTab, focusName) {
	cambiarTabAlta(numTab);
	if (focusName.length && document.getElementsByName(focusName).length>0){
		document.getElementsByName(focusName).item(0).focus();
	}


}

function cambiarTabAltaYSetFocus(numTab, idFocus) {
	cambiarTabAlta(numTab);
	document.getElementById(idFocus).focus();
}	

/* Ponemos alerta */
function ponerAlerta(listadoMsj) {
	if (listadoMsj.length > 0) {
		var txtAlerta = "";
		for ( var i = 0; i < listadoMsj.length; i++) {
			txtAlerta = txtAlerta + listadoMsj[i] + "\n";
		}
		alert(txtAlerta);
		return true;
	} else {
		return false;
	}
}
 
 

  
/* Comprobacion de ficheros */
function compruebaExtension(archivo) {
	extensiones_permitidas = new Array(".jpg", ".JPG", ".jpeg", ".JPEG", ".pdf", ".PDF");
	extension = (archivo.substring(archivo.lastIndexOf("."))).toLowerCase();
	permitida = false;
	for ( var i = 0; i < extensiones_permitidas.length; i++) {
		if (extensiones_permitidas[i] == extension) {
			permitida = true;
			break;
		}
	}
	if (!permitida) {
		alert(errorExtensionAjunto);
		return false;
	}
	return true;
}


function compruebaRepetido(nombreFichero, listaAdjuntos){  
	var retorno = true;
	if (listaAdjuntos.length > 0) {
	    var i = 0;
		for(i = 0; i < listaAdjuntos.length && retorno; i++ ){
			if(nombreFichero == listaAdjuntos[i]){
				retorno = false;
			}
		}
		if(!retorno){
			alert(errorAdjuntoRepetido);
		}
	}
	return retorno;
	
}


/* Comprobacion cadenas */
function estaVacio(q) {
	q = q.replace(/^\s*|\s*$/g, "");
	if (q.length == 0) {
		return true;
	} else {
		return false;
	}
}

function trim(s) {
	var l = 0;
	var r = s.length - 1;
	while (l < s.length && s[l] == ' ') {
		l++;
	}
	while (r > l && s[r] == ' ') {
		r -= 1;
	}
	return s.substring(l, r + 1);
}

function estaVacioSelect(q) {
	q = q.replace("---","");
	if (q.length == 0) {
	   return true;
	} 
	else {
	   return false;
    }
}

function estanTodosCamposVacios(listado) {
	for ( var i = 0; i < listado.length; i++) {
		if (!estaVacio(listado[i])) {
			return false;
		}
	}
	return true;
}

function esEntero(valor) {	
	if (/(^0$|^[1-9][0-9]*$)/.test(valor)){
		return true;	
    }else{
    	return false;
    }
}

function esEnteroPositivo(valor) {
	return (esEntero(valor));
}

function esPorcentaje(valor) {
	return (esEntero(valor) && valor >= 0 && valor <= 100);
}

function isDefined( variable) { return (typeof(window[variable]) != "undefined");}

  
  
//Habilitamos y desahabilitamos input  
function controlarEdicion(nombreForm, nombreInputHabibiltar, nombreInputDeshabibiltar) {
	habilita(nombreForm, nombreInputHabibiltar);
	deshabilita(nombreForm, nombreInputDeshabibiltar);
}

function deshabilita(nombreForm, nombreInput) {
	document.forms[nombreForm][nombreInput].removeAttribute("readonly", true);
	document.forms[nombreForm][nombreInput].value = "";
}

function habilita(nombreForm, nombreInput) {
	document.forms[nombreForm][nombreInput].removeAttribute("readonly", false);
}
   


/* Comprobacion Fechas */
function validaFechas( fechaIni, fechaFin){
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


function esFechaValida(Cadena) {
	var Fecha = new String(Cadena);
	var Ano = new String(Fecha.substring(Fecha.lastIndexOf("/") + 1, Fecha.length));
	var Mes = new String(Fecha.substring(Fecha.indexOf("/") + 1, Fecha.lastIndexOf("/")));
	var Dia = new String(Fecha.substring(0, Fecha.indexOf("/")));

	if (isNaN(Ano) || Ano.length < 4 || parseFloat(Ano) < 1900) {
		return false;
	}
	if (isNaN(Mes) || parseFloat(Mes) < 1 || parseFloat(Mes) > 12) {
		return false;
	}
	if (isNaN(Dia) || parseInt(Dia, 10) < 1 || parseInt(Dia, 10) > 31) {
		return false;
	}
	if (Mes == 4 || Mes == 6 || Mes == 9 || Mes == 11) {
		if (isNaN(Dia) || parseInt(Dia, 10) < 1 || parseInt(Dia, 10) > 30) {
			return false;
		}
	}
	if (Mes == 2) {
		if (comprobarSiBisisesto(Ano) && parseInt(Dia, 10) > 29) {
			return false;
		}
		if (!comprobarSiBisisesto(Ano) && parseInt(Dia, 10) > 28) {
			return false;
		}
	}
	return true;
}

function comprobarSiBisisesto(anio) {
	if ((anio % 100 != 0) && ((anio % 4 == 0) || (anio % 400 == 0))) {
		return true;
	} 
	else {
		return false;
	}
}

function compararFechas(FechaInicial, FechaFinal) {
	var AnoInicial = parseInt(FechaInicial.substring(FechaInicial.lastIndexOf("/") + 1, FechaInicial.length), 10);
	var MesInicial = parseInt(FechaInicial.substring(FechaInicial.indexOf("/") + 1, FechaInicial.lastIndexOf("/")), 10);
	var DiaInicial = parseInt(FechaInicial.substring(0, FechaInicial.indexOf("/")), 10);
	
	var AnoFinal = parseInt(FechaFinal.substring(FechaFinal.lastIndexOf("/") + 1, FechaInicial.length), 10);
	var MesFinal = parseInt(FechaFinal.substring(FechaFinal.indexOf("/") + 1, FechaFinal.lastIndexOf("/")), 10);
	var DiaFinal = parseInt(FechaFinal.substring(0, FechaFinal.indexOf("/")), 10);

	if (AnoFinal > AnoInicial) {
		return true;
	}
	else {
		if (AnoFinal == AnoInicial) {
			if (MesFinal > MesInicial) {
				return true;
			}
			else {
				if (MesFinal == MesInicial) {
					return (DiaFinal >= DiaInicial);
				}
				else{		
					return false;
				}
			}
		} 
		else {
			return false;
		}

	}
}

