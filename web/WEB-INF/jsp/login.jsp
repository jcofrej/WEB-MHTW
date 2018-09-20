<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF8">
        <title>Login</title>

        <title>Login</title>
        <link rel="stylesheet" href="css/dianet-styles-SGT.css" media="screen">
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




            <div id="DIAnetContainerHeader">
                <table width="100%">
                    <tbody>
                            <td width="150" align="center" valign="top"><img height="75" 
                                                                             src="imagenes/logo_Cliente.png"/>
                               
                            </td>
                            <td align="center"><div style="color: #FFFFFF; font-size: 24px;">WEB-MHTW</div></td>
                            <td width="150" align="center">
                                <!-- 			<img height="75" -->

                            </td>
                        
                    </tbody></table>

                <!-- BO DIAnet CONTENT LEFT //-->
                <div id="DIAnetContainerContentLeft">
                    <div id="DIAnetContainerSearchtoolbox"></div>
                </div>
                <!--  Login  -->
                <div id="DIAnetContainerContent">
                    <form name="MWEBLoginForm1" method="POST" action="validarServlet.do">
                        <div class="dianet-area-login  padding-top-100">
                            <div class="dianet-box-acess">
                                <!--  #3608 - Se quita la posibilidad de seleccionar otra lengua -->
                                <!--
                                
                                                                                <p>
                                                                                        Selecciona el idioma :
                                                                                </p>
                                                                                <div class="dianet-box-login-idioma">
                                                                                        <p>
                                                                                                <a href="cambioidioma.do?language=es">Espa&ntilde;ol</a>&nbsp;&nbsp;
                                                                                                <a href="cambioidioma.do?language=pt">Portugu&ecirc;s</a>&nbsp;&nbsp;
                                                                                                <a href="cambioidioma.do?language=en">English</a>
                                                                                        </p>
                                                                                </div>
                                -->
                                <%

                                    String msg="";
                                    msg = (String)session.getAttribute("servletMsg"); 
                                    if(msg!=null){
                                %>
                                <div class="dianet-box-login-idioma">
                                        <font color="#ff0000"><%=msg%></font>
                                </div>
                                <%
                                    }
                                %>
                                <div class="dianet-box-login">
                                    <!-- Usuario -->
                                    <p>
                                        <label for="campologin" class="obligado"></label>
                                    </p>
                                    <div class="dianet-box-login-field">
                                        <input placeholder="Usuario" required="required" id="campologin" name="login" type="text" class="dianet-login-field" style="width: 207px;" value="">
                                    </div>
                                    <!-- Usuario -->
                                    <p>
                                        <label for="campopw" class="obligado"></label>
                                    </p>
                                    <div class="dianet-box-login-field">
                                        <input placeholder="Contraseña" required="required" id="campopw" name="psswd" type="password" class="dianet-login-field" style="width: 207px;" value="">
                                    </div>
                                    <!--  boton entrar -->
                                    <div class="dianet-box-login-field">
                                        <input type="submit" value="Enviar" class="botonLogin">
                                    </div>
                                </div>
                            </div>

                            <script type="text/javascript" language="JavaScript">
                                <!--
                              var focusControl = document.forms["MWEBLoginForm"].elements["login"];

                                if (focusControl != null && focusControl.type != "hidden" && !focusControl.disabled && focusControl.style.display != "none") {
                                    focusControl.focus();
                                }
                                // -->
                            </script>

                        </div></form>

                </div>




            </div></div></body></html>