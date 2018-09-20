
package Controlador;

import Modelo.Articulos;
import Modelo.ProductosExcel;
import Modelo.Proveedores;
import java.io.IOException;
import static java.lang.System.out;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.servlet.ServletRequestContext;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;


@WebServlet(name = "UploadEntregas", urlPatterns = {"/uploadEntregas.do"})
public class UploadEntregas extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
           
            String paginaprov="";
            ArrayList<ProductosExcel> ListaProductos=null;
       
            paginaprov= request.getParameter("pagina");
            request.getSession().setAttribute("pagina", paginaprov);
            
            ServletRequestContext src = new ServletRequestContext(request);

            ListaProductos=CargarArchivo(src,request);

            request.getSession().setAttribute("ListadoArticulos", ListaProductos);

            request.getRequestDispatcher("WEB-INF/jsp/entrada/uploadIngreso.jsp").forward(request, response);

 
        } finally {
            
        }
    }

     ArrayList<ProductosExcel> CargarArchivo(ServletRequestContext src,HttpServletRequest request)
    {
        ArrayList<ProductosExcel> ListaProductos = new ArrayList<ProductosExcel>();
        Map<String,String> mp=new HashMap<String,String>();
        ConsultasMnh vrGetConsulta = new ConsultasMnh();
        LinkedList<Articulos> vrConsulta = new LinkedList<Articulos>();
        LinkedList<Proveedores> vrConsultaProv = new LinkedList<Proveedores>();
        String vrIdCliente = request.getSession().getAttribute("idcliente2").toString();
        
        try{
            
            if(ServletFileUpload.isMultipartContent(src)){
                DiskFileItemFactory factory = new DiskFileItemFactory();

                // Sets the size threshold beyond which files are written directly to
                // disk.
                factory.setSizeThreshold(5000000);

                 //FileItemFactory factory = new DiskFileItemFactory();
                 ServletFileUpload upload = new ServletFileUpload( factory );
                 upload.setSizeMax(10000000); // 1024 x 300 = 307200 bytes = 300 Kb
                 
                 List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
          
                 FileItem item = (FileItem) multiparts.get(3);

                //InputStream is=item.getInputStream();
                 HSSFWorkbook workbook = new HSSFWorkbook(item.getInputStream());

                 HSSFSheet sh = (HSSFSheet) workbook.getSheetAt(0);
                 Iterator<Row> rowIterator = sh.rowIterator();

                 int colcount=0;
                 while(rowIterator.hasNext()) {   
                    HSSFRow row = (HSSFRow) rowIterator.next();       
                    ProductosExcel vrProductos = new ProductosExcel();

                    Iterator<Cell> cellIterator = row.cellIterator();
                    

                         String vrError="";
                         while(cellIterator.hasNext()) {
                             HSSFCell cell = (HSSFCell) cellIterator.next();
                             String vrCampoTexto = "";
                             String vrFecha=null;

                            switch (cell.getCellType()) {
                            case 0:
                                    if (DateUtil.isCellDateFormatted(cell)) {
                                            String vrFecActual;
                                            SimpleDateFormat parseador = new SimpleDateFormat("dd/MM/yyyy");
                                            // el que formatea
                                            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                                            vrFecha= formatter.format(cell.getDateCellValue());
                                            //Date date = cell.getDateCellValue();
                                            //vrFecha=parseador.parse(vrFecActual);
                                    } else {
                                        vrCampoTexto = String.valueOf(cell.getNumericCellValue());
                                        vrCampoTexto = vrCampoTexto.replace(".0","");
                                    }
                                break;
                            case 1:
                                vrCampoTexto += cell.getStringCellValue();
                                break;
                            case 2:         
                                break;                          
                            }

                            switch (colcount) {
                            case 0:                                   
                                    vrProductos.setCodProv(vrCampoTexto);
                                break;
                                
                            case 1:
                                    vrProductos.setCodSeg(vrCampoTexto);
                                break;
                                
                           case 2:
                                    vrProductos.setFechaIngreso(vrFecha);
                                break;         
                               
                           case 3:
                                    vrProductos.setCodArt(vrCampoTexto);
                                break;  
                               
                           case 4:
                                   vrProductos.setDescripcion(vrCampoTexto);
                                break;   
                               
                           case 5:
                                   vrProductos.setCantidad(Integer.parseInt(vrCampoTexto));
                                break;
                               
                           case 6:
                                    vrProductos.setLote(vrCampoTexto);
                                break;
                            }
                            
                             colcount++;
                         }
                         
                         if (colcount==6){ 
                             
                            vrProductos.setLote("");
                            vrProductos.setCodCli(vrIdCliente);
                            
                            String vrCodArt=vrProductos.getCodArt();

                            vrConsulta=vrGetConsulta.getArticulos(vrIdCliente, vrCodArt, "", "");
                              
                            String vrProveedor=vrProductos.getCodProv();
                            vrConsultaProv=vrGetConsulta.getProveedor(vrIdCliente, vrProveedor, "");
                            if (vrConsultaProv!=null)
                            {
                                if (vrConsultaProv.size()==0)
                                    vrError=",No Existe el Proveedor";
                                }
                            }
                              
                            if (vrConsulta!=null)
                            {
                              if (vrConsulta.size()==0){ 
                                  vrProductos.setObservacion("Articulo no Existe");
                              }
                              else{
                                vrProductos.setObservacion("OK"+vrError.toString());
                              }
                            }
                            else
                            {
                                vrProductos.setObservacion("Articulo no Existe");
                            }
                         
                          if (colcount==7){ 
                              
                              vrProductos.setCodCli(vrIdCliente);
                              String vrCodArt=vrProductos.getCodArt();

                              vrConsulta=vrGetConsulta.getArticulos(vrIdCliente, vrCodArt, "", "");
                              
                              String vrProveedor=vrProductos.getCodProv();
                              vrConsultaProv=vrGetConsulta.getProveedor(vrIdCliente, vrProveedor, "");
                              if (vrConsultaProv!=null)
                              {
                                if (vrConsultaProv.size()==0)
                                {
                                    vrError=",No Existe el Proveedor";
                                }
                              }
                              
                              if (vrConsulta!=null)
                              {
                                if (vrConsulta.size()==0){ 
                                    vrProductos.setObservacion("Articulo no Existe");
                                }
                                else{
                                  vrProductos.setObservacion("OK"+vrError.toString());
                                }
                              }
                              else
                              {
                                  vrProductos.setObservacion("Articulo no Existe");
                              }

                          }

                          ListaProductos.add(vrProductos);
                 }            

                 workbook=null;
                 sh=null;
                 rowIterator=null;

            }
        
        return ListaProductos;
        
       }
        catch (Exception e){
            out.println("An exception occurred: " + e.getMessage());    
        }
        
        return null;
    }

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
