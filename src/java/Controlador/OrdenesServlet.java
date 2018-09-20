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


@WebServlet(name = "OrdenesServlet", urlPatterns = {"/ordenesServlet.do"})
public class OrdenesServlet extends HttpServlet {

    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
     
        response.setContentType("text/html;charset=UTF-8");
        String paginaprov="",codOe="",codProv="", codArtProp="",codArt="",destino="",codSeguimiento="",proveedor="",comentario="";
        ArrayList<ArticulosOe> datosOe= (ArrayList<ArticulosOe>)request.getSession().getAttribute("datosOe");
        if (request.getParameter("pagina")!=null){
            paginaprov= request.getParameter("pagina");
            request.getSession().setAttribute("pagina", paginaprov);
        }
        request.getSession().removeAttribute("datosOe");
        if (request.getParameter("destino")!=null){
            destino= request.getParameter("destino");
        }
        if (request.getParameter("codSeguimiento")!=null){
            codSeguimiento = request.getParameter("codSeguimiento");
            request.getSession().setAttribute("codSeguimiento", codSeguimiento);
        }
        if (request.getParameter("proveedor")!=null){
            proveedor = request.getParameter("proveedor");
            request.getSession().setAttribute("proveedor", proveedor);
        }
        if (request.getParameter("comentario")!=null){
            comentario = request.getParameter("comentario");
            request.getSession().setAttribute("comentario", comentario);
        }
        codOe = request.getParameter("codigoOE");
        codArtProp = request.getParameter("codigoArticuloPropietario");
        codArt = request.getParameter("codigoArticulo");
        //System.out.println(paginaprov.equals("irProveedoresNOe"));
        //System.exit(0);
        

        //System.exit(0);
        
        if(codOe != null){
            request.getRequestDispatcher("WEB-INF/jsp/entrada/consultaOE3.jsp").forward(request, response);
        }else{
            if(paginaprov!=null){
                if(paginaprov.equals("irProveedores")){
                    request.getRequestDispatcher("WEB-INF/jsp/entrada/consultaOE2.jsp").forward(request, response);
                }else{
                    if(paginaprov.equals("nuevaoe")){
                        request.getRequestDispatcher("WEB-INF/jsp/entrada/altaOE1.jsp").forward(request, response);
                    }else{
                        if(paginaprov.equals("irProveedoresNOe")){
                            request.getRequestDispatcher("WEB-INF/jsp/entrada/consultaOE2.jsp").forward(request, response);
                        }else{
                            if(paginaprov.equals("uploading")){
                                request.getRequestDispatcher("WEB-INF/jsp/entrada/uploadIngreso.jsp").forward(request, response);
                            }
                            else{
                                request.getRequestDispatcher("WEB-INF/jsp/entrada/consultaOE1.jsp").forward(request, response);
                            }
                        }
                    }
                }
            
            }else{
                request.getRequestDispatcher("WEB-INF/jsp/entrada/consultaOE1.jsp").forward(request, response);
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
