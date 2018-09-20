
package Controlador;


import Modelo.DetalleStock;
import Modelo.Stock;
import java.io.IOException;
import java.util.LinkedList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "StockServlet", urlPatterns = {"/stockServlet.do"})
public class StockServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        Consultas co = new Consultas();
        ConsultasMnh con = new ConsultasMnh();
        String codArtClte = "";
        String codArtClteD = "";
        String codArt = "";
        String descripcion = "";
        String cantidad="";
        String usuario="",pagina="",origen="",lote="";
        LinkedList<Stock> sts=null;
        LinkedList<DetalleStock> dsts=null;
        
        if (request.getParameter("codigoArticuloPropietario")!=null){
            codArtClte = request.getParameter("codigoArticuloPropietario");
        }
        if (request.getParameter("codArtPropietarioDetalle")!=null){
            codArtClteD = request.getParameter("codArtPropietarioDetalle");
        }
        
        if (request.getParameter("cantidad")!=null){
            cantidad = request.getParameter("cantidad");
        }
        if (request.getParameter("lote")!=null){
            lote = request.getParameter("lote");
        }
        if (request.getParameter("pagina")!=null){
            pagina = request.getParameter("pagina");
        }
        if(request.getParameter("codigoArticulo")!=null){
            codArt = request.getParameter("codigoArticulo");
        }
        if(request.getParameter("descripcion")!=null){
            descripcion = request.getParameter("descripcion");
        }
        if(request.getParameter("usuario")!=null){
            usuario = request.getParameter("usuario");
        }
        if(request.getParameter("origen")!=null){
            origen=request.getParameter("origen");
        }
        
        String cliente = co.getUsuarioWeb(usuario);
        if(cantidad.equals("")){
            if(!codArtClte.equals("") || !codArt.equals("") || !descripcion.equals("") || !lote.equals("")){


                sts= con.getStock(cliente,codArtClte,codArt,descripcion,cantidad,lote);
                if(sts.size()==0){
                    request.getSession().setAttribute("msgArticulo", "Cliente sin stock para criterio requerido.");
                }else{
                    request.getSession().setAttribute("stock", sts);
                }
            }
        }
        if(origen.equals("detalleStock")){
            //buscamos el stock detallado codArtClteD, cliente
            dsts= con.getDetalleStock(cliente,codArtClteD);
            request.getSession().setAttribute("cantidad", cantidad);
            if(dsts.size()==0){
                    request.getSession().setAttribute("msgArticulo", "Cliente sin stock");
                }else{
                    request.getSession().setAttribute("detalleStock", dsts);
                }
            request.getRequestDispatcher("WEB-INF/jsp/Stock/detalleStock.jsp").forward(request, response);
        }else{
            request.getRequestDispatcher("WEB-INF/jsp/Stock/consultaS1.jsp").forward(request, response);
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
