
package Controlador;

import Modelo.Articulos;
import Modelo.ArticulosOe;
import Modelo.ClientesPe;
import Modelo.ProductosExcel;
import Modelo.Proveedores;
import Modelo.cabeceraRecepcion;
import Modelo.detalleRecepcion;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ProcesarTablaIngreso", urlPatterns = {"/procesarTablaIngreso.do"})
public class ProcesarTablaIngreso extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException  {
            response.setContentType("text/html;charset=UTF-8");

            ArrayList<ProductosExcel> ListaProductos=null; 
            ArrayList<ArticulosOe> ListaFinal=null;
            //ArrayList<cabeceraRecepcion> LstCabecera = new ArrayList<cabeceraRecepcion>();
            boolean vrEstado=true;
            
            ListaProductos = (ArrayList<ProductosExcel>)request.getSession().getAttribute("ListadoArticulos");
            
            ListaFinal=IngresarArticulos(ListaProductos);
            
            if (vrEstado==false)
            {
                request.getSession().setAttribute("CargaArticulos", "NO");
                request.getSession(false).removeAttribute("ListadoArticulos");
                request.getRequestDispatcher("WEB-INF/jsp/entrada/uploadIngreso.jsp").forward(request, response);
            }
            
             if (vrEstado==true)
            {
                request.getSession().setAttribute("datosOe", ListaFinal);
                String vrCodSeg="";
                String vrCodProv="";
                String vrObserva="";
                String vrCodSeg2="";
                String vrCodProv2="";
                for (int x=0;x<=ListaProductos.size();x++)
                {
                    vrCodSeg=ListaProductos.get(x).getCodSeg();
                    vrCodProv=ListaProductos.get(x).getCodProv();
                    vrObserva=ListaProductos.get(x).getObservacion();
                    if (vrCodSeg!=vrCodSeg2 && vrCodProv!=vrCodProv2 && vrObserva.equals("OK"))
                    {
                        vrCodSeg2=vrCodSeg;
                        vrCodProv2=vrCodProv;
                        CrearArchivoRCP(request,response,vrCodSeg,"");
                    }
                }
            }
    }
    
    ArrayList<ArticulosOe> IngresarArticulos(ArrayList<ProductosExcel> ListaProductos)
    {
        ConsultasMnh vrGetConsulta = new ConsultasMnh();
        LinkedList<Proveedores> vrConsultaProv = new LinkedList<Proveedores>();
        ArrayList<ArticulosOe> datosOe= new ArrayList<ArticulosOe>();
        
         for(int i=0;i<ListaProductos.size();i++){
             String vrObserva=ListaProductos.get(i).getObservacion();
             if (vrObserva.equals("OK"))
             {
                 String vrCodArticulo=ListaProductos.get(i).getCodArt();
                 String vrDescrip=ListaProductos.get(i).getDescripcion();
                 String vrCantidad=Integer.toString(ListaProductos.get(i).getCantidad());
                 String vrCliente=ListaProductos.get(i).getCodCli();
                 String vrLote=ListaProductos.get(i).getLote();
                 
                 
                 ArticulosOe vrArticulos= new ArticulosOe(vrCodArticulo, "", vrDescrip, vrCantidad, "", vrCliente,vrLote);
                 datosOe= new ArrayList<ArticulosOe>();
                 datosOe.add(vrArticulos);               
             }            
         }
         
         return datosOe;
    }
    
    void CrearArchivoRCP(HttpServletRequest request, HttpServletResponse response,String codSeg,String coment)  throws ServletException, IOException 
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
            String nombreArchivo= "SO_"+cliente+"_"+fechaActual+"_"+horaActual+".rcp"; // Aqui se le asigna el nombre y
            FileWriter fw = null; 
            // la extension al archivo
            
            try {
                
                String entrada="E:\\temp\\"+nombreArchivo;
                File archivoEP=new File(entrada);
                PrintWriter salArch;
                //System.out.println(archivoEP);
                //Ingresamo los datos en el archivo genrado
                fw = new FileWriter(archivoEP);
                BufferedWriter bw = new BufferedWriter(fw);
                salArch = new PrintWriter(bw);                                    
               
                int fila=0;
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
                        /*
                        datosClie=co.getCliente(cliente, idProv, "");
                        if (datosClie.size()>0)
                        {
                            idCustom=datosClie.get(0).getCodigo();
                        }
                        */
                        salArch.print(cabeceraRecepcion.dataMap());
                        salArch.print(cabeceraRecepcion.interfaceActionCode(fechaActual+horaActual.trim()));
                        salArch.print(cabeceraRecepcion.orden(fechaActual+horaActual.trim()));
                        salArch.print(cabeceraRecepcion.codigoDireccionOrigen(cliente));
                        salArch.print(cabeceraRecepcion.codigoCompañia(cliente));
                        salArch.print(cabeceraRecepcion.referenciaOrden(codSeg));
                        salArch.print(cabeceraRecepcion.fechaTransmision(fechaActual.trim()));
                        salArch.print(cabeceraRecepcion.fechaOrden(fechaActual.trim()));
                        salArch.print(cabeceraRecepcion.tipoOrden());
                        String Warehouse=co.getWarehouse(cliente);
                        salArch.print(cabeceraRecepcion.almacen(Warehouse));
                        salArch.print(cabeceraRecepcion.user1(coment));

                        salArch.println();
                    }
                    
                    
                    
                    String numLineaF=String.format("%05d", f+1);
                    salArch.print(detalleRecepcion.dataMap());
                    salArch.print(detalleRecepcion.interfaceActionCode(fechaActual+horaActual.trim(),numLineaF));
                    salArch.print(detalleRecepcion.interfaceLinkId(fechaActual+horaActual.trim()));
                    salArch.print(detalleRecepcion.orden(fechaActual+horaActual.trim()));
                    salArch.print(detalleRecepcion.lineaOrden(numLineaF));
                    salArch.print(detalleRecepcion.codigoItem(datosOe.get(f).getArticuloPropietario()));
                    salArch.print(detalleRecepcion.lote(""));
                    salArch.print(detalleRecepcion.cantidadOrdenada(datosOe.get(f).getCantidad()));
                    salArch.print(detalleRecepcion.fechaOrden(fechaActual.trim()));
                    salArch.print(detalleRecepcion.company(datosOe.get(f).getCliente()));                                       
                    salArch.println();
                }

                salArch.close();

                //request.getSession().setAttribute("CargaArticulos", "NO");
                request.getSession(false).removeAttribute("ListadoArticulos");
                request.getSession().setAttribute("msg", "Orden creada correctamente.., Espere un momento, será procesada en Manhattan. " + 
                        "Si no aparece comuniquese con el encargado de cuenta");
                request.getRequestDispatcher("WEB-INF/jsp/entrada/uploadIngreso.jsp").forward(request, response);
                
             }catch(Exception e)
            {
                
            }
         }else{
             request.getSession().setAttribute("codigoSeguimiento", codSeg);
             request.getSession().setAttribute("proveedor", idProv);
             request.getSession().setAttribute("comentario", coment);
             request.getSession().setAttribute("msgError", "Debe ingresar artículos para la orden.");
             request.getRequestDispatcher("WEB-INF/jsp/entrada/uploadIngreso.jsp").forward(request, response);
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
