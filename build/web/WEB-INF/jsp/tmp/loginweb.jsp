<%@include file="doctype.inc"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Login</title>
<link rel="stylesheet" href="css/dianet-styles-SGT.css" media="screen" />
<link rel="STYLESHEET" type="text/css" href="css/global.css">

<style type="text/css">
#DIAnetContainer {
	border-left-width: 0;
}

.dianet-box-acess {
	margin: auto;
}
</style>
</head>
<body>

	<!-- Division principal -->
	<div id="DIAnetContainer">

		<%@include file="cabecera.inc"%>

		<!-- BO DIAnet CONTENT LEFT //-->
		<div id="DIAnetContainerContentLeft">
			<div id="DIAnetContainerSearchtoolbox"></div>
		</div>

		<!--  Login  -->
		<div id="DIAnetContainerContent">
			<html:form action="#" focus="login" method="POST">
				<div class="dianet-area-login  padding-top-100">
					<div class="dianet-box-acess">
<!--  #3608 - Se quita la posibilidad de seleccionar otra lengua -->
<!--
						<p>
							<bean:message key="login.etiqueta.seleccionIdioma" />
						</p>
						<div class="dianet-box-login-idioma">
							<p>
								<a href="cambioidioma.do?language=es">Espa&ntilde;ol</a>&nbsp;&nbsp;
								<a href="cambioidioma.do?language=pt">Portugu&ecirc;s</a>&nbsp;&nbsp;
								<a href="cambioidioma.do?language=en">English</a>
							</p>
						</div>
-->

						<logic:present name="org.apache.struts.action.ERROR">
							<div class="dianet-box-login-idioma">
								<html:errors />
							</div>
						</logic:present>

						<div class="dianet-box-login">
							<!-- Usuario -->
							<p>
								<label for="campologin" class="obligado"><bean:message
										key="login.etiqueta.usuario" /></label>
							</p>
							<div class="dianet-box-login-field">
								<input id="campologin" name="usuario" type="text"
									class="dianet-login-field" style="width: 207px;" value="" />
							</div>
							<!-- Usuario -->
							<p>
								<label for="campopw" class="obligado"><bean:message
										key="login.etiqueta.pw" /></label>
							</p>
							<div class="dianet-box-login-field">
								<input id="campopw" name="psswd" type="password"
									class="dianet-login-field" style="width: 207px;" value="" />
							</div>
							<!--  boton entrar -->
							<div class="dianet-box-login-field">
								<html:submit styleClass="botonLogin">
									<bean:message key="login.boton.enviar" />
								</html:submit>
							</div>
						</div>
					</div>
			</html:form>
		</div>

	</div>
</body>
</html>
