/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelo.Pedidos;
import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

/**
 *
 * @author gcardenas
 */
@WebServlet(name = "CreacionArchivosExcel", urlPatterns = {"/creacionArchivosExcel.do"})
public class CreacionArchivosExcel extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, FileUploadException, Exception {
           
        try {
              response.setContentType("text/html;charset=UTF-8");
            //response.setContentType("application/vnd.ms-excel");
           // response.setHeader("Content-Disposition", "attachment; filename=filename.xls");

            String vrPagina="";
            if (request.getParameter("pagina")!=null){
                vrPagina = request.getParameter("pagina");
            }
            
            if (vrPagina.equals("crearExcel"))
            {
                
            
            response.setHeader("Content-Disposition", "attachment; filename=filename.xls");
            
            ArrayList<Pedidos> Oe = (ArrayList<Pedidos>) request.getSession().getAttribute("LitadoPedidos");
            
            //ExportarExcel(Oe,response);
            
            request.getRequestDispatcher("WEB-INF/jsp/salida/consultaE1.jsp").forward(request, response);
            }

        } finally {
          
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
