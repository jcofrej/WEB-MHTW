/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelo.ArticulosOe;
import Modelo.ClientesPe;
import Modelo.ProductosExcel;
import Modelo.ProductosExcelPedido;
import Modelo.Proveedores;
import Modelo.cabeceraDespacho;
import Modelo.cabeceraRecepcion;
import Modelo.detalleDespacho;
import Modelo.detalleRecepcion;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author gcardenas
 */
@WebServlet(name = "ProcesarTablaPedido", urlPatterns = {"/procesarTablaPedido.do"})
public class ProcesarTablaPedido extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

            ArrayList<ProductosExcelPedido> ListaProductos=null; 
            ArrayList<ArticulosOe> ListaFinal=null;
            HashMap <String, ProductosExcelPedido> mapProductos = new HashMap <String, ProductosExcelPedido>();
            
            boolean vrEstado=true;
            
            ListaProductos = (ArrayList<ProductosExcelPedido>)request.getSession().getAttribute("ListadoArticulos");
            
            ListaFinal=IngresarArticulos(ListaProductos);
            
            if (vrEstado==false)
            {
                request.getSession().setAttribute("CargaArticulos", "NO");
                request.getSession(false).removeAttribute("ListadoArticulos");
                request.getRequestDispatcher("WEB-INF/jsp/salida/uploadPediodo.jsp").forward(request, response);
            }
            
             if (vrEstado==true)
            {
                request.getSession().setAttribute("datosOe", ListaFinal);
                String vrObserva="";

                vrObserva=ListaProductos.get(0).getObservacion();
                    
                //String vrNumPed=ListaProductos.get(0).getNumPedido();
                //String vrRutCli=ListaProductos.get(0).getRutCliente();
                String vrFechaEnt=ListaProductos.get(0).getFechaEntrega();

                CrearArchivoDSP(request,response,vrFechaEnt,"");
                
            }
    }
    
    private ArrayList<ArticulosOe> IngresarArticulos(ArrayList<ProductosExcelPedido> ListaProductos)
    {

        ArrayList<ArticulosOe> datosOe= new ArrayList<ArticulosOe>();
        
         for(int i=0;i<ListaProductos.size();i++){
             String vrObserva=ListaProductos.get(i).getObservacion().trim();
             if (vrObserva.equals("OK"))
             {
                 String vrNumPed=ListaProductos.get(i).getNumPedido();
                 String vrCodArticulo=ListaProductos.get(i).getCodArt();
                 String vrDescrip=ListaProductos.get(i).getDescripcion();
                 String vrCantidad=Integer.toString(ListaProductos.get(i).getCantidad());
                 String vrCliente=ListaProductos.get(i).getCodCli();
                 String vrLote=ListaProductos.get(i).getLote();
                 String vrIdProv=ListaProductos.get(i).getRutCliente();
                 
                 ArticulosOe vrArticulos= new ArticulosOe(vrCodArticulo, vrNumPed, vrDescrip, vrCantidad, vrIdProv, vrCliente,vrLote);
                 datosOe.add(vrArticulos);               
             }            
         }
         
         return datosOe;
    }
     
    void CrearArchivoDSP(HttpServletRequest request, HttpServletResponse response,String vrFechaEntrega,String coment)  throws ServletException, IOException 
    {
      String idProv="";
      String vrHoraFinal="";
      LinkedList<ClientesPe> datosClie =null;
      ArrayList<ArticulosOe> datosOe = (ArrayList<ArticulosOe>) request.getSession().getAttribute("datosOe");
      
         if(datosOe!=null){
             //Aqui creamos el archivo MH
            ConsultasMnh co = new ConsultasMnh();
            Calendar fecha = new GregorianCalendar();
            int año = fecha.get(Calendar.YEAR);
            int mes = fecha.get(Calendar.MONTH);
            int dia = fecha.get(Calendar.DAY_OF_MONTH);
            int hora = fecha.get(Calendar.HOUR_OF_DAY);
            int minuto = fecha.get(Calendar.MINUTE);
            int segundo = fecha.get(Calendar.SECOND);
            String fechaActual= String.format("%02d%02d%02d",dia,(mes+1),año);
            String horaActual=String.format("%02d%02d%02d",hora,minuto,segundo);
            String cliente = datosOe.get(0).getCliente();
            //Creamos el archivo para MH
            String nombreArchivo= "SO_"+cliente+"_"+fechaActual+"_"+horaActual+".dsp"; // Aqui se le asigna el nombre y
            FileWriter fw = null; 
            // la extension al archivo
            
            try
            {
               
                    //String entrada="C:\\input\\";
                    File archivoEP=new File("E:\\temp\\");

                    PrintWriter salArch;

                    //System.out.println(archivoEP);
                    //Ingresamo los datos en el archivo genrado
                    if(archivoEP.exists()){
                        fw = new FileWriter(archivoEP+"\\"+nombreArchivo);
                    }else{
                        archivoEP.mkdir();
                        fw = new FileWriter(archivoEP+"\\"+nombreArchivo);
                    }

                    BufferedWriter bw = new BufferedWriter(fw);
                    salArch = new PrintWriter(bw);    
                    
                    int fila=0;
                    int vrCont=0;
                    String vrNumPed="";
                    fila=datosOe.size();
                    for (int f =0; f<fila; f++)
                    {
                        String idCustom="";
           
                        if (!vrNumPed.equals(datosOe.get(f).getArticuloMh()))
                        {
                            vrNumPed=datosOe.get(f).getArticuloMh();
                            Calendar fechaFinal = new GregorianCalendar();
                            int horaFinal = fechaFinal.get(Calendar.HOUR_OF_DAY);
                            int minutoFinal = fechaFinal.get(Calendar.MINUTE);
                            int segundoFinal = fechaFinal.get(Calendar.SECOND);
                            vrHoraFinal=String.format("%02d%02d%02d",horaFinal,minutoFinal,segundoFinal);
                            idProv=datosOe.get(f).getUsuario();
                            datosClie=co.getCliente(cliente, idProv, "");
                            if (datosClie.size()>0)
                            {
                                idCustom=datosClie.get(0).getCodigo();
                            }
                            salArch.print(cabeceraDespacho.dataMap());
                            salArch.print(cabeceraDespacho.codeErp(vrNumPed));
                            salArch.print(cabeceraDespacho.interfaceActionCode(vrNumPed));
                            salArch.print(cabeceraDespacho.orden(vrNumPed));
                            salArch.print(cabeceraDespacho.tipoOrden());
                            //validaDatos customer = new validaDatos();
                            salArch.print(cabeceraDespacho.codigoCliente(idCustom));
                            //validaDatos shipTo = new validaDatos();
                            salArch.print(cabeceraDespacho.codigoDireccionEntrega(idProv));
                            salArch.print(cabeceraDespacho.codigoCompañia(cliente));
                            salArch.print(cabeceraDespacho.carrier());
                            salArch.print(cabeceraDespacho.fechaTransmision(fechaActual));
                            salArch.print(cabeceraDespacho.fechaOrdenDesp(vrFechaEntrega));
                            String Warehouse=co.getWarehouse(cliente);
                            salArch.print(cabeceraDespacho.almacen(Warehouse));
                            salArch.println();
                            vrCont=1;
                        }
                            
                        String numLineaF=String.format("%05d", vrCont);
                        salArch.print(detalleDespacho.dataMap());
                        salArch.print(detalleDespacho.interfaceActionCode(vrNumPed,numLineaF));
                        salArch.print(detalleDespacho.interfaceLinkId(vrNumPed));
                        salArch.print(detalleDespacho.orden(vrNumPed));
                        salArch.print(detalleDespacho.lineaOrden(numLineaF));
                        salArch.print(detalleDespacho.codigoItem(datosOe.get(f).getArticuloPropietario()));
                        salArch.print(detalleDespacho.lote(datosOe.get(f).getLote()));
                        salArch.print(detalleDespacho.precio(""));
                        salArch.print(detalleDespacho.cantidadOrdenada(datosOe.get(f).getCantidad()));
                        salArch.print(detalleDespacho.fechaOrden(fechaActual.trim()));
                        salArch.print(detalleDespacho.company(datosOe.get(f).getCliente()));
                        salArch.println();
                        vrCont++;
                    }
                    //Armamos la linea
                    salArch.close();

                    request.getSession(false).removeAttribute("ListadoArticulos");
                    request.getSession().setAttribute("msg", "Pedido creado correctamente.., Espere un momento, será procesado en Manhattan. " + 
                            "Si no aparece comuniquese con el encargado de cuenta");
                    request.getRequestDispatcher("WEB-INF/jsp/salida/uploadPedido.jsp").forward(request, response);
            
            }catch(Exception e)
                    {
                        
                    }
         }else
         {
             //retorna sin datos
             //request.getSession().setAttribute("codigoSeguimiento", codSeg);
             request.getSession().setAttribute("proveedor", idProv);
             request.getSession().setAttribute("comentario", coment);
             request.getSession().setAttribute("msgError", "Debe ingresar artículos para el pedido.");
             request.getRequestDispatcher("WEB-INF/jsp/salida/uploadPedido.jsp").forward(request, response);
         }
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
