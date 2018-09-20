
package Controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Controlador.Consultas;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "CambioPass", urlPatterns = {"/cambioPass.do"})
public class CambioPass extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {

        response.setContentType("text/html;charset=UTF-8");
        String antiguo = request.getParameter("passwordViejo");
        String nuevo1 = request.getParameter("passwordNuevo");
        String nuevo2 = request.getParameter("passwordNuevo2");
        String usuario = request.getParameter("usuario");
        Consultas co = new Consultas();
        Consultas con = new Consultas();
        
        //aqui hay que validar que el dato no sea null
        int comparacion=1;
        if(antiguo!=null){
            if (nuevo1!=null ){
                if (nuevo2!=null ){
                    comparacion = nuevo1.compareTo(nuevo2);
                    
                }
            }
        }
        if(comparacion ==0){
            if(co.autenticacion(usuario,antiguo)){
                if(con.cambioPass(usuario,nuevo1)){
                    request.getSession().setAttribute("servletMsg", "MSG: Contraseña modificada");
                    request.getRequestDispatcher("WEB-INF/jsp/usuario/cambiopass.jsp").forward(request, response);
                }else{
                    request.getRequestDispatcher("WEB-INF/jsp/usuario/cambiopass.jsp").forward(request, response);
                }
            }else{
                request.getSession().setAttribute("servletMsg", "ERROR: La contraseña actual no es correcta");
                request.getRequestDispatcher("WEB-INF/jsp/usuario/cambiopass.jsp").forward(request, response);
            }
        }else{
            if(comparacion ==-1){
                request.getSession().setAttribute("servletMsg", "ERROR: Las contraseñas nuevas no coinciden"); 
            }else{
                request.getSession().setAttribute("servletMsg", null); 
            }
            request.getRequestDispatcher("WEB-INF/jsp/usuario/cambiopass.jsp").forward(request, response);
            
        }
        
        
  
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
