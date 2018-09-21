package Controlador;

import Modelo.Articulos;
import Modelo.ArticulosOe;
import Modelo.DetalleStock;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ArticulosServlet", urlPatterns = {"/articulosServlet.do"})
public class ArticulosServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Consultas co = new Consultas();
        ConsultasMnh con = new ConsultasMnh();
        ConsultasMnh conds = new ConsultasMnh();
        
        LinkedList<DetalleStock> dsts=null;
        String codArtClte = "";
        String codArt = "";
        String descripcion = "";
        String cantidad="";
        String cantidadm="";
        String vraccion="";
        int articuloSelec=0;
        String usuario="",pagina="",origen="",lote="",codSeguimiento="",proveedor="",comentario="";
        
        if (request.getParameter("codigoArticuloPropietario")!=null){
            codArtClte = request.getParameter("codigoArticuloPropietario");
        }
        if (request.getParameter("lineaArticuloOT.codigoArticuloPropietario")!=null){
            codArtClte = request.getParameter("lineaArticuloOT.codigoArticuloPropietario");
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
        
        if (request.getParameter("cantidad")!=null){
            cantidad = request.getParameter("cantidad");
        }
        
        if (request.getParameter("cantidadm")!=null){
                cantidad = request.getParameter("cantidadm"); 
        }
                
        if (request.getParameter("lote")!=null){
            lote = request.getParameter("lote");
        }
        
        if (lote.equals(""))
        {
            if (request.getParameter("lotem")!=null){
                lote = request.getParameter("lotem"); 
            }
        }
        
        if (lote.equals(""))
            {
                if (request.getParameter("lotep")!=null)
                {
                    lote = request.getParameter("lotep"); 
                }
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

        if(request.getParameter("accion")!=null){
            vraccion=request.getParameter("accion");
        }
        
        if(vraccion.equals("modificar"))
        {            
            if (request.getParameter("articuloSelec")!=null){
                if (!request.getParameter("articuloSelec").equals(""))
                {
                    articuloSelec = Integer.parseInt(request.getParameter("articuloSelec"));
                }
            }          
        }
                
        String cliente = co.getUsuarioWeb(usuario);
        if(cantidad.equals("")){
            if(!codArtClte.equals("") || !codArt.equals("") || !descripcion.equals("")){
                
                LinkedList<Articulos> art= con.getArticulos(cliente,codArtClte,codArt,descripcion);
                if(art.size()==0){
                    request.getSession().setAttribute("msgArticulo", "Artículo inexistente.");
                }else{
                    request.getSession().setAttribute("articulos", art);
                }
            }
        }else{
            ArticulosOe artOe= new ArticulosOe(codArtClte, codArt, descripcion, cantidad, usuario, cliente,lote,"","");
            int repetido=0;
            ArrayList<ArticulosOe> datosOe = (ArrayList<ArticulosOe>) request.getSession().getAttribute("datosOe");
            //Validar artículo repetido
            if(datosOe!=null){
                for(int i=0;i<datosOe.size();i++){
                    if(datosOe.get(i).getArticuloPropietario().equals(codArtClte) && datosOe.get(i).getLote().equals(lote)){
                         request.getSession().setAttribute("msgArticulo", "Artículo duplicado.");
                         repetido=1;
                    }
                }
            }
            
            if(datosOe==null)
            {
                 if(vraccion.equals("agregar"))
                {
                    datosOe= new ArrayList<ArticulosOe>();
                    datosOe.add(artOe);
                    request.getSession().setAttribute("datosOe", datosOe);
                }
            }
            else
            {
                if(vraccion.equals("modificar"))
                {
                     datosOe.get(articuloSelec-1).setLote(lote);
                     datosOe.get(articuloSelec-1).setCantidad(cantidad);
                }
                
                if(vraccion.equals("agregar"))
                {
                    if(repetido!=1){
                        datosOe.add(artOe);
                        request.getSession().setAttribute("msgArtculo", "Artículo se encuentra registrado en la lista.");
                    }
                }
            }         
            
        }
        if(origen.equals("irArticuloNEp")){
            if(pagina.equals("irArticuloNEp")){
                if(!codArtClte.equals("")){
                    dsts= conds.getDetalleStock(cliente,codArtClte);
                    request.getSession().setAttribute("detalleStock", dsts);
                }
                request.getRequestDispatcher("WEB-INF/jsp/salida/altaE.jsp").forward(request, response);
            }else{
                
                request.getRequestDispatcher("WEB-INF/jsp/comun/consultaArticulosEp.jsp").forward(request, response);
            }
        }
        if(origen.equals("irArticuloNOe")){
            if(pagina.equals("irArticuloNOe")){
                request.getRequestDispatcher("WEB-INF/jsp/entrada/altaOE1.jsp").forward(request, response);
            }else{
                
                request.getRequestDispatcher("WEB-INF/jsp/comun/consultaArticulos.jsp").forward(request, response);
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
