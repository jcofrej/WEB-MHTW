/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelo.ArticulosOe;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author jcofre
 */
@WebServlet(name = "ModificaEliminaOeServlet", urlPatterns = {"/meoeServlet.do"})
public class ModificaEliminaOeServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        //Aqui modificamos o eliminamos lineas de la OE en pantalla.
        int articuloSelec=0;
        String accion="",codSeguimiento="",proveedor="",comentario="",vrcantidad="",vrpagina="";
        if (request.getParameter("articuloSelec")!=null){
            articuloSelec = Integer.parseInt(request.getParameter("articuloSelec"));
        }
        if (request.getParameter("accion")!=null){
            accion = request.getParameter("accion");
        }
        if (request.getParameter("pagina")!=null){
            vrpagina = request.getParameter("pagina");
        }
        if (request.getParameter("codSeguimiento")!=null){
            codSeguimiento = request.getParameter("codSeguimiento");
        }
        if (request.getParameter("proveedor")!=null){
            proveedor = request.getParameter("proveedor");
        }
        if (request.getParameter("comentario")!=null){
            comentario = request.getParameter("comentario");
        }
        if (request.getParameter("cantidadm")!=null){
            vrcantidad = request.getParameter("cantidadm");
        }
        
        ArrayList<ArticulosOe> datosOe = (ArrayList<ArticulosOe>) request.getSession().getAttribute("datosOe");
        if(datosOe!=null){
            //datosOe.get(articuloSelec).getArticuloPropietario();
            if(accion.equals("elimina")){
                datosOe.remove(articuloSelec-1);
            }
            
            if(accion.equals("modificar")){
                datosOe.get(articuloSelec-1).setCantidad(vrcantidad);
            }
            
            request.getSession().setAttribute("accion", accion);
            request.getSession().setAttribute("proveedor", proveedor);
            request.getSession().setAttribute("comentario", comentario);
            request.getSession().setAttribute("codSeguimiento", codSeguimiento);
            if (vrpagina.equals("Pedidos"))
            {
                //request.getRequestDispatcher("WEB-INF/jsp/entrada/altaOE1.jsp").forward(request, response);
                request.getRequestDispatcher("WEB-INF/jsp/salida/altaE.jsp").forward(request, response);
            }else
            {
               if (vrpagina.equals("Entrega"))
                {
                    request.getRequestDispatcher("WEB-INF/jsp/entrada/altaOE1.jsp").forward(request, response);
                }
            }
        }
        
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
