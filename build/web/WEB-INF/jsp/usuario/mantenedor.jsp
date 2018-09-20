
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Mantenedor de Usuarios</title>
        <%@include file="../head.inc"%>

    </head>

    <body>

    <!-- Division principal -->
    <div id="DIAnetContainer">
        <div id="DIAnetClearHeader"></div>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

        <%@include file="../menu.inc"%>

        <!--  navegación -->
        <div id="DIAnetBreadCrumbs">
            Esta en
            <a href="#" class="home"> Mantenedor de Usuarios
            </a> <img src="imagenes/icon-bread-crumbs.gif" alt="" />
            Usuarios
        </div>



        <!-- Formulario -->
        <div class="dianet-div-align-left">

            <!--  titulo con el nombre del usuario -->
            <div class="dianet-box-login">
                Cambio de la contraseña del usuario 
                <br/>
                <%=usuario%>

                <% 
                String msg="";
                msg = (String)session.getAttribute("servletMsg"); 
                
                %>
            </div>		
             
            
            <!-- html:form action="ChgPwd.do" focus="ChgPwd" method="POST"-->
            <form name="MWEBCambioPasswordForm" method="POST" action="cambioPass.do">
                <input type="hidden" name="usuario" value="<%=usuario%>">
                <div class="padding-top-20">
                    <div class="dianet-box-acess">
                        <% if(msg!=null){
                            
                        %>
                        <div class="dianet-box-login-idioma">
                                <font color="#ff0000"><%=msg %></font>
                        </div>
                        <% 
                        msg="";    
                        }
                        %>

                        <div class="dianet-box-login">
                            <!-- PwdOld -->
                            <p>
                                <label for="campoPwdOld" class="obligado">Contraseña (actual)</label>
                            </p>
                            <div class="dianet-box-login-field">
                                <input id="passwordViejo" name="passwordViejo" type="password"
                                       class="dianet-login-field" style="width: 207px;" value="" required="required" />
                            </div>

                            <!-- Pwd1 -->
                            <p>
                                <label for="campoPwd1" class="obligado">Nueva contraseña</label>
                            </p>
                            <div class="dianet-box-login-field">
                                <input id="passwordNuevo" name="passwordNuevo" type="password"
                                       class="dianet-login-field" style="width: 207px;" value="" required="required" />
                            </div>

                            <!-- Pwd2 -->
                            <p>
                                <label for="campoPwd2" class="obligado">Nueva contraseña (repetir)</label>
                            </p>
                            <div class="dianet-box-login-field">
                                <input id="passwordNuevo2" name="passwordNuevo2" type="password"
                                       class="dianet-login-field" style="width: 207px;" value="" required="required" />
                            </div>

                            <!--  boton entrar -->
                            <div class="dianet-box-login-field">
                                <input type="submit" value="Cambiar Contraseña" class="botonLogin">
                            </div>
                        </div>
                    </div>
            </form>
            <script type="text/javascript" language="JavaScript">
                <!--
              var focusControl = document.forms["MWEBCambioPasswordForm"].elements["login"];

                if (focusControl != null && focusControl.type != "hidden" && !focusControl.disabled && focusControl.style.display != "none") {
                    focusControl.focus();
                }
                // -->
            </script>

        </div>

        <!-- Fin Formulario -->
        <%@include file="../cabecera.inc"%>
    </body>
</html>
