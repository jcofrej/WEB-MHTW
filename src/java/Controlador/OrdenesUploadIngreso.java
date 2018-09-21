package Controlador;


import java.io.File;
import java.io.IOException;
import static java.lang.System.out;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.FileItemFactory;    

import org.apache.commons.fileupload.servlet.ServletFileUpload; 
import org.apache.commons.fileupload.servlet.ServletRequestContext;

import org.apache.poi.hssf.usermodel.HSSFAnchor;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import Modelo.ProductosExcel;
import Modelo.Usuario;
import org.apache.poi.ss.usermodel.DateUtil;
import Controlador.ConsultasMnh;
import Modelo.Articulos;
import Modelo.Proveedores;

import java.text.SimpleDateFormat;
import java.util.LinkedList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@WebServlet(name = "OrdenesUploadIngreso", urlPatterns = {"/ordenesUploadIngreso.do"})
public class OrdenesUploadIngreso extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        String paginaprov="";
        ArrayList<ProductosExcel> ListaProductos=null;
       
       // if (request.getParameter("pagina")!=null){
            paginaprov= request.getParameter("pagina");
            request.getSession().setAttribute("pagina", paginaprov);
            
 
        //}
        
        //request.getContentType().startsWith("multipart/form-data");
        ServletRequestContext src = new ServletRequestContext(request);

        ListaProductos=CargarArchivo(src,request);

        request.getSession().setAttribute("ListadoArticulos", ListaProductos);

        //if(paginaprov.equals("CargandoArchivo"))
        //   {
        request.getRequestDispatcher("WEB-INF/jsp/entrada/uploadIngreso.jsp").forward(request, response);
        //   }

    }
    
    private ArrayList<ProductosExcel> CargarArchivo(ServletRequestContext src,HttpServletRequest request)
    {
        ArrayList<ProductosExcel> ListaProductos = new ArrayList<ProductosExcel>();
        Map<String,String> mp=new HashMap<String,String>();
        ConsultasMnh vrGetConsulta = new ConsultasMnh();
        LinkedList<Articulos> vrConsulta = new LinkedList<Articulos>();
        LinkedList<Proveedores> vrConsultaProv = new LinkedList<Proveedores>();
        String vrIdCliente = request.getSession().getAttribute("idcliente2").toString();
        String vrCheckCampo="";
        String Cells="";
        
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
                 int rows = sh.getPhysicalNumberOfRows();
                 int cells=0;
                
                 for (int r = 0; r < rows; r++)
                 {
                        // System.out.println("row " + r + '\t' );
                        HSSFRow row = sh.getRow(r);
 
                        if (r==0)
                        {
                            cells = row.getPhysicalNumberOfCells();
                        }
                        else{
                            
                            ProductosExcel vrProductos = new ProductosExcel();
                            int colcount=0;
                            String vrError="";
                            for (int c = 0; c < cells; c++)
                            {
                                    HSSFCell cell = row.getCell((short)c);
                                    String vrCampoTexto = "";
                                    String vrFecha=null;
                                    vrCheckCampo="";
                                   
                                    if (cell!=null)
                                    {
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
                                    }else
                                    {
                                         vrCampoTexto="";
                                         vrFecha="";
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
                                           vrCheckCampo="Cantidad";
                                        break;

                                   case 6:
                                            vrProductos.setLote(vrCampoTexto);
                                            vrCheckCampo="Lote";
                                        break;
                                   case 7:
                                            vrProductos.setFechaVencimiento(vrFecha);
                                            vrCheckCampo="FecVen";
                                        break;
                                   case 8:
                                            vrProductos.setUbicacion(vrCampoTexto);
                                            vrCheckCampo="Ubicacion";
                                        break;
                                    }
                             colcount++;
                            } //end for c
                            
                               String vrCodArt=vrProductos.getCodArt();
                               vrProductos.setCodCli(vrIdCliente);
                               /*
                              if (matchesPolicy(vrProductos.getCodProv().toString())==true)
                              {
                                vrError="El código de proveedor no es válido";
                              }

                              if (matchesPolicy(vrProductos.getCodSeg().toString())==true)
                              {
                                vrError="El código de seguimiento no es válido";
                              }
                              */
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

                             ListaProductos.add(vrProductos);
                        }
                } //end for
                 
                 
                 
                 /*
                 Iterator<Row> rowIterator = sh.rowIterator();
                 //Cells = rowIterator.
                 int rowcount=0;
                 while(rowIterator.hasNext()) {   
                    HSSFRow row = (HSSFRow) rowIterator.next();  
                    
                    if (rowcount>0)
                    {
                        ProductosExcel vrProductos = new ProductosExcel();

                        Iterator<Cell> cellIterator = row.cellIterator();
                    
                         int colcount=0;
                         
                         while(cellIterator.hasNext()) {
                             HSSFCell cell = (HSSFCell) cellIterator.next();


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
                            case Cell.CELL_TYPE_BLANK: 
                                vrCampoTexto="";
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
                                   vrCheckCampo="Cantidad";
                                break;
                               
                           case 6:
                                    vrProductos.setLote(vrCampoTexto);
                                    vrCheckCampo="Lote";
                                break;
                           case 7:
                                    vrProductos.setFechaVencimiento(vrFecha);
                                    vrCheckCampo="FecVen";
                                break;
                           case 8:
                                    vrProductos.setUbicacion(vrCampoTexto);
                                    vrCheckCampo="Ubicacion";
                                break;
                            }
                            
                             colcount++;
                         }
                         
                         if (colcount==6){ 
                             
                            vrProductos.setLote("");
                            vrProductos.setFechaVencimiento("");
                            vrProductos.setUbicacion("");
                            vrProductos.setCodCli(vrIdCliente);
                            
                            if (matchesPolicy(vrProductos.getCodProv().toString())==true)
                            {
                                vrError="El código de proveedor no es válido";
                            }
                            
                            if (matchesPolicy(vrProductos.getCodSeg().toString())==true)
                            {
                                vrError="El código de seguimiento no es válido";
                            }
                            
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
                              vrProductos.setFechaVencimiento("");
                              vrProductos.setUbicacion("");
                              String vrCodArt=vrProductos.getCodArt();

                              if (validarcacater(vrProductos.getCodProv().toString())==true)
                              {
                                vrError="El código de proveedor no es válido";
                              }

                              if (validarcacater(vrProductos.getCodSeg().toString())==true)
                              {
                                vrError="El código de seguimiento no es válido";
                              }
                              
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
                    rowcount++;
                 }            

                 workbook=null;
                 sh=null;
                 rowIterator=null;
                   */

            }
               
        
        return ListaProductos;
        
       }
        catch (Exception e){
            out.println("An exception occurred: " + e.getMessage());    
        }
        
        return null;
    }
    
    private boolean validarcacater(String vrCaracter)
    {
         boolean vrEstado=false;
        Pattern p = Pattern.compile("^\\.|@|$|#|&^"); 
        Matcher m = p.matcher(vrCaracter);   
        if(m.find()){ 
            vrEstado=true;
        }
        
        return vrEstado;
    }
    
    private boolean matchesPolicy(String pwd) {
        boolean vrEstado=false;
        int vrLargo=pwd.length();
        for (int x=0;x<=vrLargo-1;x++)
        {
            String vrCarac=pwd.substring(x, 1).toString();
            if (vrCarac.indexOf("/[%@$&^#*+{}'']/")>0)
                { vrEstado=true; break;}
        }
        
        return vrEstado;
    }
   
    public static boolean ValidaCaracterEspecial(String str){
        boolean respuesta = false;
        if (str.indexOf("([@#\\$%\\^&\\*\\?_~\\/\\''\\*]|\\-)+")>0) {
         respuesta = true;
        }
        return respuesta;
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

