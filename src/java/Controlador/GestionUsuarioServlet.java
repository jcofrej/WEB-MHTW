/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Controlador.Consultas;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author jcofre
 */
@WebServlet(name = "GestionUsuarioServlet", urlPatterns = {"/gestionUsuarioServlet.do"})
public class GestionUsuarioServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String vrPagina="";
        if (request.getParameter("pagina")!=null){
            vrPagina= request.getParameter("pagina");
        }
        
        String vrNombre="";
        if (request.getParameter("pagina")!=null){
            vrPagina= request.getParameter("pagina");
        }
        try {
        
            if (vrPagina.equals(""))
            {
                request.getRequestDispatcher("WEB-INF/jsp/usuario/gestionusuarios.jsp").forward(request, response);
            }
            else
            {
                if (vrPagina.equals("NuevoUsuario"))
                {
                    request.getRequestDispatcher("WEB-INF/jsp/usuario/nuevousuario.jsp").forward(request, response);
                }else
                {
                    if (vrPagina.equals("GuardarUsuario"))
                   {
    
                       if (RegistroUsuario(request,response)==true)
                       {
                           request.getSession().setAttribute("msg", "Usuario creado correctamente");
                           request.getRequestDispatcher("WEB-INF/jsp/usuario/gestionusuarios.jsp").forward(request, response);
                       }else
                       {
                           request.getSession().setAttribute("msgError", "Error al grabar el usuario.");
                           request.getRequestDispatcher("WEB-INF/jsp/usuario/nuevousuario.jsp").forward(request, response);
                       }
                       
                       
                   }   
                }
            }

        } finally {
          
        }
    }
    
    private boolean RegistroUsuario(HttpServletRequest request, HttpServletResponse response)
    {
        boolean vrEstado=false;
        
        Consultas vrman = new Consultas();
        String vrNomUsuario="";
        String vrPass="";
        String vrNombre="";
        String vrIdCliente="";
        String vrTipoUsuario="";
        
        if (request.getParameter("nusuario")!=null){
            vrNomUsuario = request.getParameter("nusuario").toUpperCase();
        }
        
        if (request.getParameter("pass")!=null){
            vrPass = request.getParameter("pass");
        }
        
        if (request.getParameter("nombre")!=null){
            vrNombre = request.getParameter("nombre").toUpperCase();
        }
        
        if (request.getParameter("idcliente")!=null){
            vrIdCliente = request.getParameter("idcliente");
        }
        
        if (request.getParameter("tipo_Usuario")!=null){
            vrTipoUsuario = request.getParameter("tipo_Usuario");
        }
        
        if (ValidarUsuario(vrNomUsuario)==true)
        {
            vrEstado=vrman.Registrar(vrNomUsuario, vrPass, vrNombre, 0,vrIdCliente,vrTipoUsuario);
        }
        
        return vrEstado;
    }
    
    private boolean ValidarUsuario(String vrNomUsuario)
    {
        boolean vrEstado=false;
        String vrIdCliente="";
        
        Consultas vrman = new Consultas();

        vrIdCliente=vrman.getUsuarioWeb(vrNomUsuario);
        
        if (vrIdCliente.equals(""))
        {
            vrEstado=true;
        }
        
        return vrEstado;
    }
   
    private String LimpiarTexto(String texto) {
        String original = "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýÿ";
        // Cadena de caracteres ASCII que reemplazarán los originales.
        String ascii = "AAAAAAACEEEEIIIIDNOOOOOOUUUUYBaaaaaaaceeeeiiiionoooooouuuuyy";
        String output = texto;
        for (int i=0; i<original.length(); i++) {
        // Reemplazamos los caracteres especiales.

            output = output.replace(original.charAt(i), ascii.charAt(i));

        }//for i
        
        return output;
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
