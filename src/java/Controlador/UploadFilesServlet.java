
package Controlador;

import java.io.File;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author jcofre
 */
@WebServlet(name = "UploadFilesServlet", urlPatterns = {"/uploadFilesServlet.do"})
public class UploadFilesServlet extends HttpServlet {
    private final String archivoUrl="I:\\TX_WEBMH\\";
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
            throws ServletException, IOException, FileUploadException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Frameset//EN\" \"http://www.w3.org/TR/REC-html40/frameset.dtd\">");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet vista</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<form name='upload' method='POST' action='uploadFilesServlet.do' enctype='multipart/form-data'>");
            out.println("<input type='file' name='file' size='50' />");
            out.println("</form>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
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
        //processRequest(request, response);
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
        
        DiskFileItemFactory factory = new DiskFileItemFactory(); 
        factory.setSizeThreshold(1024); 
        String nombreArchivo =  (String)request.getAttribute("nombreArchivo");
        factory.setRepository(new File(archivoUrl+"\\"+nombreArchivo)); 
        //String nombreArchivo =  (String)request.getAttribute("nombreArchivo");
        ServletFileUpload upload = new ServletFileUpload(factory); 
        File archivo = new File(nombreArchivo);
        try{ 
            List<FileItem> partes = upload.parseRequest(request); 

            for(FileItem item:partes){ 
                File file=new File(archivoUrl+"\\"+nombreArchivo,item.getName()); 
                item.write(file); 
            }
            request.getRequestDispatcher("WEB-INF/jsp/salida/consultaE1.jsp").forward(request, response);
            //out.println("#Subido correctamente"); 
        }catch(FileUploadException e){ 
                //"#error al subir archivo" + e); 
        } catch (Exception ex) {
            
            Logger.getLogger(SubirArchivos.class.getName()).log(Level.SEVERE, null, ex);
            request.getRequestDispatcher("WEB-INF/jsp/salida/altaE.jsp").forward(request, response);
        }
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
