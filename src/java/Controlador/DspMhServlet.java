
package Controlador;

import static Controlador.SubirArchivos.subirFichero;
import Modelo.ArticulosOe;
import Modelo.ClientesPe;
import Modelo.cabeceraDespacho;
import Modelo.detalleDespacho;
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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "DsMhServlet", urlPatterns = {"/dspMhServlet.do"})
public class DspMhServlet extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        String coment="",codSeg="",idProv="",idCustom="";
        if(request.getParameter("codigoSeguimiento")!=null){
        codSeg=request.getParameter("codigoSeguimiento");
        
    }
    if(request.getParameter("proveedor")!=null){
       idProv=request.getParameter("proveedor");
    }
    if(request.getParameter("comentario")!=null){
       coment=request.getParameter("comentario");
       
    }
    if(codSeg.equals("")){
        request.getSession().setAttribute("proveedor", idProv);
        request.getSession().setAttribute("comentario", coment);
        request.getSession().setAttribute("msgError", "Debe ingresar código de seguimiento.");
        request.getRequestDispatcher("WEB-INF/jsp/salida/altaE.jsp").forward(request, response);

    }
    if(idProv.equals("")){
        request.getSession().setAttribute("codigoSeguimiento", codSeg);
        request.getSession().setAttribute("comentario", coment);
        request.getSession().setAttribute("msgError", "Debe ingresar un cliente.");
        request.getRequestDispatcher("WEB-INF/jsp/salida/altaE.jsp").forward(request, response);

    }
        ArrayList<ArticulosOe> datosOe = (ArrayList<ArticulosOe>) request.getSession().getAttribute("datosOe");
        LinkedList<ClientesPe> datosClie =null;
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
            
            //String entrada="C:\\input\\";
            File archivoEP=new File("E:\\temp\\");
            
            PrintWriter salArch;
            
            datosClie=co.getCliente(cliente, idProv, "");
            if (datosClie.size()>0)
            {
                idCustom=datosClie.get(0).getCodigo();
            }
            
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
            salArch.print(cabeceraDespacho.dataMap());
            salArch.print(cabeceraDespacho.codeErp(codSeg));
            salArch.print(cabeceraDespacho.interfaceActionCode(fechaActual+horaActual.trim()));
            salArch.print(cabeceraDespacho.orden(fechaActual+horaActual.trim()));
            salArch.print(cabeceraDespacho.tipoOrden());
            //validaDatos customer = new validaDatos();
            salArch.print(cabeceraDespacho.codigoCliente(idCustom));
            //validaDatos shipTo = new validaDatos();
            salArch.print(cabeceraDespacho.codigoDireccionEntrega(idProv));
            salArch.print(cabeceraDespacho.codigoCompañia(cliente));
            salArch.print(cabeceraDespacho.carrier());
            salArch.print(cabeceraDespacho.fechaTransmision(fechaActual));
            salArch.print(cabeceraDespacho.fechaOrdenDesp(fechaActual));
            String Warehouse=co.getWarehouse(cliente);
            salArch.print(cabeceraDespacho.almacen(Warehouse));
            salArch.println();

            int fila=0;

            fila=datosOe.size();
            for (int f =0; f<fila; f++)
            {
                String numLineaF=String.format("%05d", f+1);
                salArch.print(detalleDespacho.dataMap());
                salArch.print(detalleDespacho.interfaceActionCode(fechaActual+horaActual.trim(),numLineaF));
                salArch.print(detalleDespacho.interfaceLinkId(fechaActual+horaActual.trim()));
                salArch.print(detalleDespacho.orden(fechaActual+horaActual.trim()));
                salArch.print(detalleDespacho.lineaOrden(numLineaF));
                salArch.print(detalleDespacho.codigoItem(datosOe.get(f).getArticuloPropietario()));
                salArch.print(detalleDespacho.lote(datosOe.get(f).getLote()));
                salArch.print(detalleDespacho.precio(""));
                salArch.print(detalleDespacho.cantidadOrdenada(datosOe.get(f).getCantidad()));
                salArch.print(detalleDespacho.fechaOrden(fechaActual.trim()));
                salArch.print(detalleDespacho.company(datosOe.get(f).getCliente()));
                salArch.println();

            }
            //Armamos la linea
            salArch.close();
     
            request.getSession().setAttribute("msg", "Pedido creado correctamente.., Espere un momento, será procesado en Manhattan. " + 
                    "Si no aparece comuniquese con el encargado de cuenta");
            request.getRequestDispatcher("WEB-INF/jsp/salida/consultaE1.jsp").forward(request, response);
         }else
         {
             //retorna sin datos
             request.getSession().setAttribute("codigoSeguimiento", codSeg);
             request.getSession().setAttribute("proveedor", idProv);
             request.getSession().setAttribute("comentario", coment);
             request.getSession().setAttribute("msgError", "Debe ingresar artículos para el pedido.");
             request.getRequestDispatcher("WEB-INF/jsp/salida/altaE.jsp").forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(DspMhServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(DspMhServlet.class.getName()).log(Level.SEVERE, null, ex);
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
    }// </editor-fold>t

   
}
