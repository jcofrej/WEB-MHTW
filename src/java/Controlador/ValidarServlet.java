package Controlador;

import Modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "ValidarServlet", urlPatterns = {"/validarServlet.do"})
public class ValidarServlet extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String user,pass;
        
        user = request.getParameter("login").toUpperCase();
        pass = request.getParameter("psswd").toUpperCase();
        
        
        Consultas co = new Consultas();
        
        if(co.autenticacion(user, pass)){
            
            
            Usuario usu = new Usuario(user,pass);
            HttpSession session = request.getSession();
            //String idSesion=session.getId();
            //long horaInicio=session.getCreationTime();
            
            session.setAttribute("usuario", usu);
            
            request.getRequestDispatcher("WEB-INF/jsp/portada.jsp").forward(request, response);
            //request.getRequestDispatcher("WEB-INF/jsp/menu.jsp").forward(request, response);
        }else{
            //Error
            request.getSession().setAttribute("servletMsg", "ERROR: Usuario o contraseña no registrados");
            request.getRequestDispatcher("WEB-INF/jsp/login.jsp").forward(request, response);
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
