<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<script language="javascript">
	function redirigeAccesoProhibido(){
		location.href = 'PaginaSinPermisos.do';
	}
	
	<logic:notPresent name="NOMBRE_ATRIBUTO_TOKEN_SEGURIDAD" >
		redirigeAccesoProhibido();
	</logic:notPresent >
	<logic:present name="NOMBRE_ATRIBUTO_TOKEN_SEGURIDAD" >
		<logic:equal name="NOMBRE_ATRIBUTO_TOKEN_SEGURIDAD" value="false">
			redirigeAccesoProhibido();
		</logic:equal>
	</logic:present> 
</script>