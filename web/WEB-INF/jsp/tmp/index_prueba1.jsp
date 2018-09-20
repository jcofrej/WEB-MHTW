<%@include file="doctype.inc"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Incio sesión</title>
        <link rel="stylesheet" href="css/dianet-styles-SGT.css" media="screen" />
        <link rel="STYLESHEET" type="text/css" href="css/global.css">
    </head>
    <body>
        <h1>Inicio de sesión</h1>
        <form action="validarServlet.do" method="post">
            <input type="text" name="usuario" placeholder="Usuario" required="required" /><br/><br/>
            <input type="password" name="password" placeholder="Contraseña" required="required" /><br/><br/>
            <input type="submit" value="Iniciar Sessión"/>

        </form>
    </body>
</html>
