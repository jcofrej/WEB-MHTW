/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelo.Articulos;
import Modelo.ClientesPe;
import Modelo.Pedidos;
import Modelo.Stock;
import Modelo.ProductosExcelPedido;
//import org.apache.poi.hssf.usermodel.HSSFCell;
//import org.apache.poi.hssf.usermodel.HSSFRow;
//import org.apache.poi.hssf.usermodel.HSSFSheet;
//import org.apache.poi.hssf.usermodel.HSSFWorkbook;
//import org.apache.poi.xssf.usermodel.XSSFCell;
//import org.apache.poi.xssf.usermodel.XSSFRow;
//import org.apache.poi.xssf.usermodel.XSSFSheet;
//import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import org.apache.poi.*;

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
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.servlet.ServletRequestContext;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.NumberToTextConverter;



@WebServlet(name = "PedidosUploadIngreso", urlPatterns = {"/PedidosUploadIngreso.do"})
public class PedidosUploadIngreso extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException  {
         //request.setCharacterEncoding("UTF-8");
         response.setContentType("text/html;charset=UTF-8");
        
         String VrNom="";
        if (request.getParameter("fichero")!=null){
            VrNom = request.getParameter("fichero");
        }
        String vrPagina="";
        if (request.getParameter("pagina")!=null){
            vrPagina = request.getParameter("pagina");
        }
        
        ArrayList<ProductosExcelPedido> ListaProductos=null;

        ServletRequestContext src = new ServletRequestContext(request);

        ListaProductos=ValidarArchivo(src,request);

        request.getSession().setAttribute("ListadoArticulos", ListaProductos);

        request.getRequestDispatcher("WEB-INF/jsp/salida/uploadPedido.jsp").forward(request, response);
 
    }
    
    private ArrayList<ProductosExcelPedido> CargarArchivoXLS(List<FileItem> multiparts,HttpServletRequest request)
    {
        ArrayList<ProductosExcelPedido> ListaProductos = new ArrayList<ProductosExcelPedido>();
        Map<String, ProductosExcelPedido> mapProductos = new HashMap <String, ProductosExcelPedido>();
        ConsultasMnh vrGetConsulta = new ConsultasMnh();
        LinkedList<Articulos> vrConsulta = new LinkedList<Articulos>();
        LinkedList<Stock> vrConsultaStock = new LinkedList<Stock>();
        LinkedList<ClientesPe> vrClientes = new LinkedList<ClientesPe>();
        LinkedList<Pedidos> vrPedidos = new LinkedList<Pedidos>();
        String vrIdCliente = request.getSession().getAttribute("idcliente2").toString();
        
        try{
                        
            //if(ServletFileUpload.isMultipartContent(src)){
           //     DiskFileItemFactory factory = new DiskFileItemFactory();

                // Sets the size threshold beyond which files are written directly to
                // disk.
           //     factory.setSizeThreshold(5000000);


                 //FileItemFactory factory = new DiskFileItemFactory();
              //   ServletFileUpload upload = new ServletFileUpload( factory );
                 //upload.setSizeMax(10000000); // 1024 x 300 = 307200 bytes = 300 Kb
                 
                // List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
          
                 FileItem item = (FileItem) multiparts.get(4);

                  //FileInputStream input_document = new FileInputStream(new File(item.getInputStream().toString())); //Read XLSX document - Office 2007, 2010 format     
                 
                //InputStream is=item.getInputStream();
                 //HSSFWorkbook workbook = new HSSFWorkbook(item.getInputStream()); //Read the Excel Workbook in a instance object    
                 org.apache.poi.hssf.usermodel.HSSFWorkbook workbook = new org.apache.poi.hssf.usermodel.HSSFWorkbook(item.getInputStream());

                 //HSSFSheet sh = workbook.getSheetAt(0);
                 org.apache.poi.hssf.usermodel.HSSFSheet sh = workbook.getSheetAt(0);
                 Iterator<Row> rowIterator = sh.rowIterator();
                 
                 while(rowIterator.hasNext()) {   
                    org.apache.poi.hssf.usermodel.HSSFRow row = (org.apache.poi.hssf.usermodel.HSSFRow) rowIterator.next(); 
                    if (row.getRowNum()==0)
                    {
                        row = (org.apache.poi.hssf.usermodel.HSSFRow) rowIterator.next(); 
                    }
                    
                    ProductosExcelPedido vrProductos = new ProductosExcelPedido();
                    String vrErrorCliente="";
                    String vrErrorPedido="";
                    String vrProdDup="";

                    Iterator<Cell> cellIterator = row.cellIterator();
                    vrProductos.setCodCli(vrIdCliente);
                    
                         int colcount=0;
                         String vrError="";
                         while(cellIterator.hasNext()) {
                             org.apache.poi.hssf.usermodel.HSSFCell cell = (org.apache.poi.hssf.usermodel.HSSFCell) cellIterator.next();
                                                   
                             String vrCampoTexto = "";
                             String vrFecha=null;

                            switch (cell.getCellType()) {
                            case 0:
                                    if (DateUtil.isCellDateFormatted(cell)) {
                                            //String vrFecActual;
                                            SimpleDateFormat parseador = new SimpleDateFormat("dd/MM/yyyy");
                                            // el que formatea
                                            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                                            vrFecha= formatter.format(cell.getDateCellValue());
                                            //Date date = cell.getDateCellValue();
                                            //vrFecha=parseador.parse(vrFecActual);
                                    } else {
                                        vrCampoTexto = NumberToTextConverter.toText(cell.getNumericCellValue());
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
                                    vrProductos.setNumPedido(vrCampoTexto);
                                break;
                                
                            case 1:
                                    vrProductos.setRutCliente(vrCampoTexto);
                                break;
                            case 2:
                                    vrProductos.setNomCliente(vrCampoTexto);
                                break;                                
                           case 3:
                                    vrProductos.setFechaEntrega(vrFecha);
                                break;         
                               
                           case 4:
                                    vrProductos.setCodArt(vrCampoTexto);
                                break;  
                               
                           case 5:
                                   vrProductos.setDescripcion(vrCampoTexto);
                                break;   
                               
                           case 6:
                                   vrProductos.setCantidad(Integer.parseInt(vrCampoTexto));
                                break;
                               
                           case 7:
                                    vrProductos.setLote(vrCampoTexto);
                                break;
                            }
                            
                             colcount++;
                         }
                         
                         if (colcount==7){ 
                             
                            vrProductos.setLote("");
                            String KeyProd = null;
                            KeyProd=vrProductos.getNumPedido()+vrProductos.getRutCliente()+vrProductos.getCodArt()+vrProductos.getLote();                         
                            
                            if (mapProductos.get(KeyProd)!=null)
                            {
                                 vrProdDup=",El Producto se encuentra duplicado";
                            }
                            
                            if (mapProductos.containsKey(KeyProd)==true)
                            {
                                vrProdDup=",El Producto se encuentra duplicado";
                            }

                            String vrRutCliente=vrProductos.getRutCliente();
                            vrRutCliente = vrRutCliente.replace("-", "");
                            
                            vrClientes=vrGetConsulta.getClientePropietario(vrIdCliente, vrRutCliente, "");
                            if (vrClientes!=null)
                            {
                                if(vrClientes.size()==0)
                                {
                                    vrErrorCliente=",El Cliente no Existe";
                                }
                            }
                            
                            String vrNumPedido=vrProductos.getNumPedido();
                            vrPedidos=vrGetConsulta.getPedidos(vrIdCliente, "", vrNumPedido, "", "", "");
                            if (vrPedidos!=null)
                            {
                                if (vrPedidos.size()>0)
                                {
                                        vrErrorPedido=",Error el número de pedido ya existe";
                                }
                            }
 
                            String vrCodArt=vrProductos.getCodArt();
                            String vrStock=Integer.toString(vrProductos.getCantidad());

                            vrConsulta=vrGetConsulta.getArticulos(vrIdCliente, vrCodArt, "", "");
                              
                            vrConsultaStock=vrGetConsulta.getStock(vrIdCliente, vrCodArt, "", "", vrStock, "");  //.getProveedor(vrIdCliente, vrProveedor, "");
                            if (vrConsultaStock!=null)
                            {
                                if (vrConsultaStock.size()==0){
                                    vrError=",La Cantidad del Pedido es Mayor al Stock";
                                }
                            
                                if (vrConsultaStock.size()>0){
                                    if (Integer.parseInt(vrConsultaStock.get(0).getCantidad())<Integer.parseInt(vrStock))
                                    {
                                        vrError=",La Cantidad del Pedido es Mayor al Stock de "+vrConsultaStock.get(0).getCantidad();
                                    }
                                }
                            }
                              
                            if (vrConsulta!=null)
                            {
                              if (vrConsulta.size()==0){ 
                                  vrProductos.setObservacion("Articulo no Existe" + vrErrorCliente.toString()+vrErrorPedido.toString()+vrProdDup.toString());
                              }
                              else{
                                vrProductos.setObservacion("OK"+vrError.toString() + " " + vrErrorCliente.toString() + vrErrorPedido.toString()+vrProdDup.toString());
                              }
                            }
                            else
                            {
                                vrProductos.setObservacion("Articulo no Existe" + vrErrorCliente.toString() + vrErrorPedido.toString()+vrProdDup.toString());
                            }
                            
                            mapProductos.put(KeyProd, vrProductos);
                            KeyProd=null;
                         }
                         
                          if (colcount==8){ 
                                                            
                              String KeyProd = null;
                              KeyProd=vrProductos.getNumPedido()+vrProductos.getRutCliente()+vrProductos.getCodArt()+vrProductos.getLote();
                              
                              if (mapProductos.get(KeyProd)!=null)
                              {
                                     vrProdDup=",El Producto se encuentra duplicado";
                              }
                               
                              if (mapProductos.containsKey(KeyProd)==true)
                              {
                                  vrProdDup=",El Producto se encuentra duplicado";
                              }
                              
                              String vrRutCliente=vrProductos.getRutCliente();
                              vrRutCliente = vrRutCliente.replace("-", "");

                              vrClientes=vrGetConsulta.getClientePropietario(vrIdCliente, vrRutCliente, "");
                              if (vrClientes!=null)
                              {
                                if(vrClientes.size()==0)
                                {
                                    vrErrorCliente=",El Cliente no Existe";
                                }
                              }
                              
                              String vrNumPedido=vrProductos.getNumPedido();
                              vrPedidos=vrGetConsulta.getPedidos(vrIdCliente, "", vrNumPedido, "", "", "");
                              if (vrPedidos!=null)
                              {
                                  if (vrPedidos.size()>1)
                                  {
                                          vrErrorPedido=",Error el número de pedido ya existe";
                                  }
                              }
                              
                              String vrCodArt=vrProductos.getCodArt();
                              String vrStock=Integer.toString(vrProductos.getCantidad());

                              vrConsulta=vrGetConsulta.getArticulos(vrIdCliente, vrCodArt, "", "");

                              vrConsultaStock=vrGetConsulta.getStock(vrIdCliente, vrCodArt, "", "", vrStock, "");
                              if (vrConsultaStock!=null)
                              {
                                if (vrConsultaStock.size()==0)
                                {
                                    vrError=",La Cantidad Pedido es Mayor al Stock";
                                }
                                
                                if (vrConsultaStock.size()>0){
                                    if (Integer.parseInt(vrConsultaStock.get(0).getCantidad())<Integer.parseInt(vrStock))
                                    {
                                        vrError=",La Cantidad del Pedido es Mayor al Stock de " + Integer.parseInt(vrStock);
                                    }
                                }
                              }
                              
                              if (vrConsulta!=null)
                              {
                                if (vrConsulta.size()==0){ 
                                    vrProductos.setObservacion("Articulo no Existe" + vrErrorCliente.toString() + vrErrorPedido.toString()+vrProdDup.toString());
                                }
                                else{
                                  vrProductos.setObservacion("OK"+vrError.toString() + vrErrorCliente.toString() + vrErrorPedido.toString()+vrProdDup.toString());
                                }
                              }
                              else
                              {
                                  vrProductos.setObservacion("Articulo no Existe" + vrErrorCliente.toString() + vrErrorPedido.toString()+vrProdDup.toString());
                              }

                              mapProductos.put(KeyProd, vrProductos);
                              KeyProd=null;
                          }

                          ListaProductos.add(vrProductos);
                          vrPedidos.clear();
                          
                 }            

                 workbook=null;
                 sh=null;
                 rowIterator=null;

            //}
           
        return ListaProductos;
        
       }
        catch (Exception e){
            out.println("An exception occurred: " + e.getMessage());    
        }
        
        return null;
    }
    
    private ArrayList<ProductosExcelPedido> ValidarArchivo(ServletRequestContext src,HttpServletRequest request)
    {
        
        try{
                ArrayList<ProductosExcelPedido> ListadoFinal=null;
                if(ServletFileUpload.isMultipartContent(src)){
                    DiskFileItemFactory factor = new DiskFileItemFactory();

                    // Sets the size threshold beyond which files are written directly to
                    // disk.
                    factor.setSizeThreshold(5000000);


                     //FileItemFactory factory = new DiskFileItemFactory();
                     ServletFileUpload upload = new ServletFileUpload( factor );
                     upload.setSizeMax(10000000); // 1024 x 300 = 307200 bytes = 300 Kb

                     List<FileItem> multipartes = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);

                     FileItem items = (FileItem) multipartes.get(4);
                     
                     String vrNomArchivo=items.getName();
                     String extension = vrNomArchivo.substring(vrNomArchivo.indexOf(".")+1);
                     
                     if (extension.equals("xlsx"))
                     {
                        ListadoFinal=CargarArchivoXLSX(multipartes,request);
                     }
                     
                     if (extension.equals("xls"))
                     {
                        ListadoFinal=CargarArchivoXLS(multipartes,request);
                     }
                     //item.delete();
                     //multiparts.clear();
                     
                     return ListadoFinal;
                }
        }catch (Exception e){
            out.println("An exception occurred: " + e.getMessage());    
           
        }
        
        return null;
    }

    private ArrayList<ProductosExcelPedido> CargarArchivoXLSX(List<FileItem> multiparts,HttpServletRequest request)
    {
        ArrayList<ProductosExcelPedido> ListaProductos = new ArrayList<ProductosExcelPedido>();
        Map<String, ProductosExcelPedido> mapProductos = new HashMap <String, ProductosExcelPedido>();
        ConsultasMnh vrGetConsulta = new ConsultasMnh();
        LinkedList<Articulos> vrConsulta = new LinkedList<Articulos>();
        LinkedList<Stock> vrConsultaStock = new LinkedList<Stock>();
        LinkedList<ClientesPe> vrClientes = new LinkedList<ClientesPe>();
        LinkedList<Pedidos> vrPedidos = new LinkedList<Pedidos>();
        String vrIdCliente = request.getSession().getAttribute("idcliente2").toString();
        
        try{
                        
            //if(ServletFileUpload.isMultipartContent(src)){
               // DiskFileItemFactory factory = new DiskFileItemFactory();

                // Sets the size threshold beyond which files are written directly to
                // disk.
               // factory.setSizeThreshold(5000000);


                 //FileItemFactory factory = new DiskFileItemFactory();
                 //ServletFileUpload upload = new ServletFileUpload( factory );
                // upload.setSizeMax(10000000); // 1024 x 300 = 307200 bytes = 300 Kb
                 
                 //List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
          
                 FileItem item = (FileItem) multiparts.get(4);
                 
                 
                  //FileInputStream input_document = new FileInputStream(new File(item.getInputStream().toString())); //Read XLSX document - Office 2007, 2010 format     
                 
                //InputStream is=item.getInputStream();
                 org.apache.poi.xssf.usermodel.XSSFWorkbook workbook = new org.apache.poi.xssf.usermodel.XSSFWorkbook(item.getInputStream()); //Read the Excel Workbook in a instance object    
                 //HSSFWorkbook workbook = new HSSFWorkbook(item.getInputStream());

                 org.apache.poi.xssf.usermodel.XSSFSheet sh = workbook.getSheetAt(0);
                 //HSSFSheet sh = workbook.getSheetAt(0);
                 Iterator<Row> rowIterator = sh.rowIterator();
                 
                 while(rowIterator.hasNext()) {   
                    org.apache.poi.xssf.usermodel.XSSFRow row = (org.apache.poi.xssf.usermodel.XSSFRow) rowIterator.next(); 
                    if (row.getRowNum()==0)
                    {
                        row = (org.apache.poi.xssf.usermodel.XSSFRow) rowIterator.next(); 
                    }
                    
                    ProductosExcelPedido vrProductos = new ProductosExcelPedido();
                    String vrErrorCliente="";
                    String vrErrorPedido="";
                    String vrProdDup="";

                    Iterator<Cell> cellIterator = row.cellIterator();
                    vrProductos.setCodCli(vrIdCliente);
                    
                         int colcount=0;
                         String vrError="";
                         while(cellIterator.hasNext()) {
                             org.apache.poi.xssf.usermodel.XSSFCell cell = (org.apache.poi.xssf.usermodel.XSSFCell) cellIterator.next();
                                                   
                             String vrCampoTexto = "";
                             String vrFecha=null;

                            switch (cell.getCellType()) {
                            case 0:
                                    if (DateUtil.isCellDateFormatted(cell)) {
                                            //String vrFecActual;
                                            SimpleDateFormat parseador = new SimpleDateFormat("dd/MM/yyyy");
                                            // el que formatea
                                            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                                            vrFecha= formatter.format(cell.getDateCellValue());
                                            //Date date = cell.getDateCellValue();
                                            //vrFecha=parseador.parse(vrFecActual);
                                    } else {
                                        vrCampoTexto = NumberToTextConverter.toText(cell.getNumericCellValue());
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
                                    vrProductos.setNumPedido(vrCampoTexto);
                                break;
                                
                            case 1:
                                    vrProductos.setRutCliente(vrCampoTexto);
                                break;
                            case 2:
                                    vrProductos.setNomCliente(vrCampoTexto);
                                break;                                
                           case 3:
                                    vrProductos.setFechaEntrega(vrFecha);
                                break;         
                               
                           case 4:
                                    vrProductos.setCodArt(vrCampoTexto);
                                break;  
                               
                           case 5:
                                   vrProductos.setDescripcion(vrCampoTexto);
                                break;   
                               
                           case 6:
                                   vrProductos.setCantidad(Integer.parseInt(vrCampoTexto));
                                break;
                               
                           case 7:
                                    vrProductos.setLote(vrCampoTexto);
                                break;
                            }
                            
                             colcount++;
                         }
                         
                         if (colcount==7){ 
                             
                            vrProductos.setLote("");
                            String KeyProd = null;
                            KeyProd=vrProductos.getNumPedido()+vrProductos.getRutCliente()+vrProductos.getCodArt()+vrProductos.getLote();                         
                            
                            if (mapProductos.get(KeyProd)!=null)
                            {
                                 vrProdDup=",El Producto se encuentra duplicado";
                            }
                            
                            if (mapProductos.containsKey(KeyProd)==true)
                            {
                                vrProdDup=",El Producto se encuentra duplicado";
                            }

                            String vrRutCliente=vrProductos.getRutCliente();
                            vrRutCliente = vrRutCliente.replace("-", "");
                            
                            vrClientes=vrGetConsulta.getClientePropietario(vrIdCliente, vrRutCliente, "");
                            if (vrClientes!=null)
                            {
                                if(vrClientes.size()==0)
                                {
                                    vrErrorCliente=",El Cliente no Existe";
                                }
                            }
                            
                            String vrNumPedido=vrProductos.getNumPedido();
                            vrPedidos=vrGetConsulta.getPedidos(vrIdCliente, "", vrNumPedido, "", "", "");
                            if (vrPedidos!=null)
                            {
                                if (vrPedidos.size()>0)
                                {
                                        vrErrorPedido=",Error el número de pedido ya existe";
                                }
                            }
 
                            String vrCodArt=vrProductos.getCodArt();
                            String vrStock=Integer.toString(vrProductos.getCantidad());

                            vrConsulta=vrGetConsulta.getArticulos(vrIdCliente, vrCodArt, "", "");
                              
                            vrConsultaStock=vrGetConsulta.getStock(vrIdCliente, vrCodArt, "", "", vrStock, "");  //.getProveedor(vrIdCliente, vrProveedor, "");
                            if (vrConsultaStock!=null)
                            {
                                if (vrConsultaStock.size()==0){
                                    vrError=",La Cantidad del Pedido es Mayor al Stock";
                                }
                            
                                if (vrConsultaStock.size()>0){
                                    if (Integer.parseInt(vrConsultaStock.get(0).getCantidad())<Integer.parseInt(vrStock))
                                    {
                                        vrError=",La Cantidad del Pedido es Mayor al Stock de "+vrConsultaStock.get(0).getCantidad();
                                    }
                                }
                            }
                              
                            if (vrConsulta!=null)
                            {
                              if (vrConsulta.size()==0){ 
                                  vrProductos.setObservacion("Articulo no Existe" + vrErrorCliente.toString()+vrErrorPedido.toString()+vrProdDup.toString());
                              }
                              else{
                                vrProductos.setObservacion("OK"+vrError.toString() + " " + vrErrorCliente.toString() + vrErrorPedido.toString()+vrProdDup.toString());
                              }
                            }
                            else
                            {
                                vrProductos.setObservacion("Articulo no Existe" + vrErrorCliente.toString() + vrErrorPedido.toString()+vrProdDup.toString());
                            }
                            
                            mapProductos.put(KeyProd, vrProductos);
                            KeyProd=null;
                         }
                         
                          if (colcount==8){ 
                                                            
                              String KeyProd = null;
                              
                              
                              KeyProd=vrProductos.getNumPedido()+vrProductos.getRutCliente()+vrProductos.getCodArt()+vrProductos.getLote();
                              
                              if (mapProductos.get(KeyProd)!=null)
                              {
                                     vrProdDup=",El Producto se encuentra duplicado";
                              }
                               
                              if (mapProductos.containsKey(KeyProd)==true)
                              {
                                  vrProdDup=",El Producto se encuentra duplicado";
                              }
                              
                              String vrRutCliente=vrProductos.getRutCliente();
                              vrRutCliente = vrRutCliente.replace("-", "");

                              vrClientes=vrGetConsulta.getClientePropietario(vrIdCliente, vrRutCliente, "");
                              if (vrClientes!=null)
                              {
                                if(vrClientes.size()==0)
                                {
                                    vrErrorCliente=",El Cliente no Existe";
                                }
                              }
                              
                              String vrNumPedido=vrProductos.getNumPedido();
                              vrPedidos=vrGetConsulta.getPedidos(vrIdCliente, "", vrNumPedido, "", "", "");
                              if (vrPedidos!=null)
                              {
                                  if (vrPedidos.size()>1)
                                  {
                                          vrErrorPedido=",Error el número de pedido ya existe";
                                  }
                              }
                              
                              String vrCodArt=vrProductos.getCodArt();
                              String vrStock=Integer.toString(vrProductos.getCantidad());

                              vrConsulta=vrGetConsulta.getArticulos(vrIdCliente, vrCodArt, "", "");

                              vrConsultaStock=vrGetConsulta.getStock(vrIdCliente, vrCodArt, "", "", vrStock, "");
                              if (vrConsultaStock!=null)
                              {
                                if (vrConsultaStock.size()==0)
                                {
                                    vrError=",La Cantidad Pedido es Mayor al Stock";
                                }
                                
                                if (vrConsultaStock.size()>0){
                                    if (Integer.parseInt(vrConsultaStock.get(0).getCantidad())<Integer.parseInt(vrStock))
                                    {
                                        vrError=",La Cantidad del Pedido es Mayor al Stock de " + Integer.parseInt(vrStock);
                                    }
                                }
                              }
                              
                              if (vrConsulta!=null)
                              {
                                if (vrConsulta.size()==0){ 
                                    vrProductos.setObservacion("Articulo no Existe" + vrErrorCliente.toString() + vrErrorPedido.toString()+vrProdDup.toString());
                                }
                                else{
                                  vrProductos.setObservacion("OK"+vrError.toString() + vrErrorCliente.toString() + vrErrorPedido.toString()+vrProdDup.toString());
                                }
                              }
                              else
                              {
                                  vrProductos.setObservacion("Articulo no Existe" + vrErrorCliente.toString() + vrErrorPedido.toString()+vrProdDup.toString());
                              }

                              mapProductos.put(KeyProd, vrProductos);
                              KeyProd=null;
                          }

                          ListaProductos.add(vrProductos);
                          vrPedidos.clear();
                          
                // }            

            }
            
            workbook=null;
            sh=null;
            rowIterator=null;

           
        return ListaProductos;
        
       }
        catch (Exception e){
            out.println("An exception occurred: " + e.getMessage());    
        }
        
        return null;
    }

    public static boolean ValidaCaracterEspecial(String str){
        boolean respuesta = false;
        if ((str).matches("([@#\\$%\\^&\\*\\?_~\\/\\''\\*]|\\-)+")) {
         respuesta = true;
        }
        return respuesta;
    } 
    private boolean matchesPolicy(String pwd) {
        boolean vrEstado=false;
        if (pwd.matches("/[%@$&^#*+{}'']/"))
            { vrEstado=true; }
        
    return vrEstado;
}
 
    
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
