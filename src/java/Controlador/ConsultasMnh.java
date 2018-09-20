
package Controlador;

import cl.webmh.datos.cl.acceso.DatosManh;
import Modelo.Articulos;
import Modelo.ClientesPe;
import Modelo.DetalleOrdenEntrada;
import Modelo.DetallePedidos;
import Modelo.DetalleStock;
import Modelo.OrdenesEntrada;
import Modelo.Pedidos;
import Modelo.Proveedores;
import Modelo.Stock;
import Modelo.Usuario;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
import static cl.webmh.util.GENEFechas.*;

public class ConsultasMnh extends DatosManh {
    public LinkedList<Articulos> getArticulos(String cliente,String codArtClte,String codMh, String descripcion ){
        LinkedList<Articulos> listaArticulos = new LinkedList<Articulos>();
        PreparedStatement pst = null;
        ResultSet rs=null;
        try{
            
            if(codMh.length()>0){
                if (getDatosMh().isClosed()==true)
                {
                    getConectar();
                    getDatosMh();
                }
                String consulta="SELECT * FROM ITEM WHERE COMPANY=? AND INTERNAL_ITEM_NUM LIKE ?";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1,cliente);
                pst.setString(2,codMh);
            }
            
            if(descripcion.length()>0){
                if (getDatosMh().isClosed()==true)
                {
                    getConectar();
                    getDatosMh();
                }
                String consulta="SELECT * FROM ITEM WHERE COMPANY=? AND DESCRIPTION LIKE ?";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1,cliente);
                pst.setString(2,descripcion);
            }
            
            if(codArtClte.length()>0){
                if (getDatosMh().isClosed()==true)
                {
                    getConectar();
                    getDatosMh();
                }
                String consulta="SELECT * FROM ITEM WHERE COMPANY=? AND ITEM LIKE ?";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1,cliente);
                pst.setString(2,codArtClte);
            }
            
            rs=pst.executeQuery();
            
            while (rs.next()) {
                Articulos art = new Articulos(); 
                art.setCodArt(rs.getString("ITEM"));
                art.setCodMh(rs.getString("INTERNAL_ITEM_NUM"));
                art.setDescripcion(rs.getString("DESCRIPTION"));
                art.setCategoria(rs.getString("USER_DEF1"));
                listaArticulos.add(art);
            }
            return listaArticulos;
            
        }catch(Exception e){
            System.err.println("Error "+e);
        }finally{
            try {
                if(getDatosMh()!= null){
                    getDatosMh().close();
                }
                if(pst!=null){ 
                    pst.close();
                }
                if(rs!=null) {
                    rs.close();
                }
            } catch (Exception e) {
                System.err.println("Error "+e);
                
            }
        }    
        
        return null;
    }
    public LinkedList<Stock> getStock(String cliente,String codArtClte,String codMh, String descripcion, String cantidad, String lote ){
        LinkedList<Stock> listaStock = new LinkedList<Stock>();
        PreparedStatement pst = null;
        ResultSet rs=null;
        try{
            if(codArtClte.length()>0){
                if (getDatosMh().isClosed()==true)
                {
                    getConectar();
                    getDatosMh();
                }
                String consulta="SELECT CODIGOP=I.ITEM,CODIGO=INTERNAL_ITEM_NUM,DESCRIPCION=DESCRIPTION,CANTIDAD=CAST(SUM(ON_HAND_QTY) AS INT) " +
                                "FROM LOCATION_INVENTORY LI LEFT JOIN ITEM I ON LI.ITEM=I.ITEM WHERE LI.COMPANY= ? " +
                                "AND I.ITEM LIKE ? AND I.COMPANY = ? GROUP BY I.ITEM,INTERNAL_ITEM_NUM,DESCRIPTION";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1,cliente);
                pst.setString(2,codArtClte);
                pst.setString(3,cliente);
            }
            if(codMh.length()>0){
                if (getDatosMh().isClosed()==true)
                {
                    getConectar();
                    getDatosMh();
                }                
                String consulta="SELECT CODIGOP=I.ITEM,CODIGO=INTERNAL_ITEM_NUM,DESCRIPCION=DESCRIPTION,CANTIDAD=CAST(SUM(ON_HAND_QTY) AS INT) " +
                                "FROM LOCATION_INVENTORY LI LEFT JOIN ITEM I ON LI.ITEM=I.ITEM WHERE LI.COMPANY= ? " +
                                "AND INTERNAL_ITEM_NUM LIKE ? AND I.COMPANY = ? GROUP BY I.ITEM,INTERNAL_ITEM_NUM,DESCRIPTION";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1,cliente);
                pst.setString(2,codMh);
                pst.setString(3,cliente);
            }
            if(descripcion.length()>0){
                if (getDatosMh().isClosed()==true)
                {
                    getConectar();
                    getDatosMh();
                }                
                String consulta="SELECT CODIGOP=I.ITEM,CODIGO=INTERNAL_ITEM_NUM,DESCRIPCION=DESCRIPTION,CANTIDAD=CAST(SUM(ON_HAND_QTY) AS INT) " +
                                "FROM LOCATION_INVENTORY LI LEFT JOIN ITEM I ON LI.ITEM=I.ITEM WHERE LI.COMPANY = ? " +
                                "AND DESCRIPTION LIKE ? AND I.COMPANY = ? GROUP BY I.ITEM,INTERNAL_ITEM_NUM,DESCRIPTION";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1,cliente);
                pst.setString(2,descripcion);
                pst.setString(3,cliente);
            }
            if(lote.length()>0){
                if (getDatosMh().isClosed()==true)
                {
                    getConectar();
                    getDatosMh();
                }                
                String consulta="SELECT CODIGOP=I.ITEM,CODIGO=INTERNAL_ITEM_NUM,DESCRIPCION=DESCRIPTION,CANTIDAD=CAST(SUM(ON_HAND_QTY) AS INT) " +
                                " FROM LOCATION_INVENTORY LI LEFT JOIN ITEM I ON LI.ITEM=I.ITEM WHERE LI.COMPANY = ? AND LI.LOT LIKE ? AND I.COMPANY = ?" +
                                " GROUP BY I.ITEM,INTERNAL_ITEM_NUM,DESCRIPTION,LI.LOT";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1,cliente);
                pst.setString(2,lote);
                pst.setString(3,cliente);
                //System.err.println(consulta);
            }
            rs=pst.executeQuery();
            
            while (rs.next()) {
                Stock stc = new Stock(); 
                stc.setCodArt(rs.getString("CODIGOP"));
                stc.setCodMh(rs.getString("CODIGO"));
                stc.setDescripcion(rs.getString("DESCRIPCION"));
                stc.setCantidad(rs.getString("CANTIDAD"));
                listaStock.add(stc);
            }
            return listaStock;
            
        }catch(Exception e){
            System.err.println("Error "+e);
        }finally{
            try {
                if(getDatosMh()!= null)getDatosMh().close();
                if(pst!=null)pst.close();
                if(rs!=null)rs.close();
            } catch (Exception e) {
                System.err.println("Error "+e);
                
            }
        }    
        
        return null;
    }
    public  LinkedList<DetalleStock> getDetalleStock(String cliente, String codArt) {
        LinkedList<DetalleStock> listaDetalleStock = new LinkedList<DetalleStock>();
        String consulta ="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {

            if (getDatosMh().isClosed()==true)
            {
                getConectar();
                getDatosMh();
            }  
            if (codArt!=""){
            
                consulta = "SELECT CODIGOP=I.ITEM,CODIGO=INTERNAL_ITEM_NUM,DESCRIPTION,LOT,VENCIMIENTO=EXPIRATION_DATE, " +
                            " CANTIDAD=SUM(CAST(ON_HAND_QTY AS INT)),ESTADO=INVENTORY_STS " +
                            " FROM LOCATION_INVENTORY LI LEFT JOIN ITEM I ON LI.ITEM=I.ITEM WHERE LI.COMPANY= ? AND I.ITEM= ? AND I.COMPANY = ? "+
                            " GROUP BY I.ITEM,INTERNAL_ITEM_NUM,DESCRIPTION,LOT,EXPIRATION_DATE,INVENTORY_STS";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, cliente);
                pst.setString(2, codArt);
                pst.setString(3, cliente); 
                
            }

            rs = pst.executeQuery();
            while (rs.next()) {
                DetalleStock ds = new DetalleStock(); 
                ds.setCodArt(rs.getString("CODIGOP"));
                ds.setCodMh(rs.getString("CODIGO"));
                ds.setDescripcion(rs.getString("DESCRIPTION"));
                ds.setLote(rs.getString("LOT"));
                ds.setVencimiento(fromFechaHoraMhtoWEBMh(rs.getString("VENCIMIENTO")));
                ds.setCantidad(rs.getString("CANTIDAD"));
                ds.setEstado(rs.getString("ESTADO"));

                listaDetalleStock.add(ds);
                
            }
            

        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            try {
                if(getDatosMh()!= null)getDatosMh().close();
                if(pst!=null)pst.close();
                if(rs!=null)rs.close();
            } catch (Exception e) {
                e.printStackTrace();
                
            }
            
        }
        
        return listaDetalleStock;
    }
    

    public LinkedList<OrdenesEntrada> getOrdenesEntrada(String cliente,String codSeg, String codOE,String fechaIn, String fechaFn,String codProv){
        LinkedList<OrdenesEntrada> listaOrdenesEntrada = new LinkedList<OrdenesEntrada>();
        PreparedStatement pst = null;
        ResultSet rs=null;
        String consulta="";
        String fechaIni=toFechaMh(fechaIn,true);
        String fechaFin=toFechaMh(fechaFn,false);

        try{
            
            if(codSeg.length()>0){
                consulta="SELECT * FROM RECEIPT_HEADER WHERE COMPANY=? AND ERP_ORDER_NUM LIKE ? ORDER BY CREATION_DATE_TIME_STAMP DESC";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, cliente);
                pst.setString(2, codSeg);
                
            }
            if(codOE.length()>0){
                consulta="SELECT * FROM RECEIPT_HEADER WHERE COMPANY=? AND INTERNAL_RECEIPT_NUM LIKE ? ORDER BY CREATION_DATE_TIME_STAMP DESC";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, cliente);
                pst.setString(2, codOE);
                
            }
            if(fechaIni.length()>0 && fechaFin.length()>2){
                consulta="SELECT * FROM RECEIPT_HEADER WHERE COMPANY=? AND CREATION_DATE_TIME_STAMP BETWEEN ? AND ? ORDER BY CREATION_DATE_TIME_STAMP DESC";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, cliente);
                pst.setString(2, fechaIni);
                pst.setString(3, fechaFin);
                
            }
            if(codProv.length()>0){
                consulta="SELECT * FROM RECEIPT_HEADER WHERE COMPANY=? AND SHIP_FROM LIKE ? ORDER BY CREATION_DATE_TIME_STAMP DESC";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, cliente);
                pst.setString(2, codProv);
                
            }
            
            
            rs=pst.executeQuery();
            while (rs.next()) {
                OrdenesEntrada oe = new OrdenesEntrada(); 
                oe.setCodOE(rs.getString("INTERNAL_RECEIPT_NUM"));
                oe.setCodIdOE(rs.getString("RECEIPT_ID"));
                oe.setCodSeguimiento(rs.getString("ERP_ORDER_NUM"));
                oe.setComentario(rs.getString("RECEIPT_TYPE"));
                oe.setEstado(rs.getString("LEADING_STS"));
                oe.setFechaAlta(fromFechaHoraMhtoWEBMh(rs.getString("CREATION_DATE_TIME_STAMP")));
                oe.setFechaCaducidad(fromFechaHoraMhtoWEBMh(rs.getString("LEADING_STS_DATE")));
                oe.setProveedor(rs.getString("SHIP_FROM"));
                oe.setTipo(rs.getString("RECEIPT_ID_TYPE"));
                listaOrdenesEntrada.add(oe);
                
            }
        }catch(Exception e){
            System.err.println("Error "+e);
        }finally{
            try {
                if(getDatosMh()!= null)getDatosMh().close();
                if(pst!=null)pst.close();
                if(rs!=null)rs.close();
            } catch (Exception e) {
                System.err.println("Error "+e);
                
            }
            
        }
        return listaOrdenesEntrada;
    }
    
   
    public LinkedList<Pedidos> getPedidos(String cliente,String codSeg, String codOE,String fechaIn, String fechaFn,String codProv){
        LinkedList<Pedidos> listaPedidos = new LinkedList<Pedidos>();
        PreparedStatement pst = null;
        ResultSet rs=null;
        String consulta="";
        String fechaIni=toFechaMh(fechaIn,true);
        String fechaFin=toFechaMh(fechaFn,false);

        try{
            
             if (getDatosMh().isClosed()==true)
             {
                getConectar();
                getDatosMh();
             } 
            if(codSeg.length()>0){
                consulta="SELECT ESTADO=CASE WHEN TRAILING_STS=100 THEN 'En Grupo' WHEN TRAILING_STS=200 THEN 'En Ola' WHEN TRAILING_STS=300 THEN 'Pcking Pendiente' " +
                         " WHEN TRAILING_STS=301 THEN 'En Picking' WHEN TRAILING_STS=400 THEN 'En Picking' WHEN TRAILING_STS=401 THEN 'En Picking' " +
                         " WHEN TRAILING_STS=700 THEN 'Envio Pendiente' WHEN TRAILING_STS=900 THEN 'Cerrado' END,* "+
                         " FROM SHIPMENT_HEADER WHERE COMPANY=? AND ERP_ORDER LIKE ? ORDER BY DATE_TIME_STAMP DESC";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, cliente);
                pst.setString(2, codSeg);
                
            }
            if(codOE.length()>0){
                consulta="SELECT ESTADO=CASE WHEN TRAILING_STS=100 THEN 'En Grupo' WHEN TRAILING_STS=200 THEN 'En Ola' WHEN TRAILING_STS=300 THEN 'Pcking Pendiente' " +
                         " WHEN TRAILING_STS=301 THEN 'En Picking' WHEN TRAILING_STS=400 THEN 'En Picking' WHEN TRAILING_STS=401 THEN 'En Picking' " +
                         " WHEN TRAILING_STS=700 THEN 'Envio Pendiente' WHEN TRAILING_STS=900 THEN 'Cerrado' END,* " +
                         " FROM SHIPMENT_HEADER WHERE COMPANY=? AND INTERNAL_SHIPMENT_NUM LIKE ? ORDER BY DATE_TIME_STAMP DESC";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, cliente);
                pst.setString(2, codOE);
                
            }
            if(fechaIni.length()>0 && fechaFin.length()>2){
                consulta="SELECT ESTADO=CASE WHEN TRAILING_STS=100 THEN 'En Grupo' WHEN TRAILING_STS=200 THEN 'En Ola' WHEN TRAILING_STS=300 THEN 'Pcking Pendiente' " +
                         " WHEN TRAILING_STS=301 THEN 'En Picking' WHEN TRAILING_STS=400 THEN 'En Picking' WHEN TRAILING_STS=401 THEN 'En Picking' " +
                         " WHEN TRAILING_STS=700 THEN 'Envio Pendiente' WHEN TRAILING_STS=900 THEN 'Cerrado' END,* " +
                         " FROM SHIPMENT_HEADER WHERE COMPANY=? AND TRAILING_STS_DATE BETWEEN ? AND ? ORDER BY DATE_TIME_STAMP DESC";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, cliente);
                pst.setString(2, fechaIni);
                pst.setString(3, fechaFin);
                
            }
            if(codProv.length()>0){
                consulta="SELECT ESTADO=CASE WHEN TRAILING_STS=100 THEN 'En Grupo' WHEN TRAILING_STS=200 THEN 'En Ola' WHEN TRAILING_STS=300 THEN 'Pcking Pendiente' " +
                         " WHEN TRAILING_STS=301 THEN 'En Picking' WHEN TRAILING_STS=400 THEN 'En Picking' WHEN TRAILING_STS=401 THEN 'En Picking' " +
                         " WHEN TRAILING_STS=700 THEN 'Envio Pendiente' WHEN TRAILING_STS=900 THEN 'Cerrado' END,* " +
                         " FROM SHIPMENT_HEADER WHERE COMPANY=? AND SHIP_TO LIKE ? ORDER BY DATE_TIME_STAMP DESC";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, cliente);
                pst.setString(2, codProv);
                
            }
            
            
            rs=pst.executeQuery();
            while (rs.next()) {
                Pedidos ep = new Pedidos(); 
                ep.setCodOE(rs.getString("INTERNAL_SHIPMENT_NUM"));
                ep.setCodSeguimiento(rs.getString("ERP_ORDER"));
                ep.setComentario(rs.getString("PARTIES"));
                ep.setEstado(rs.getString("ESTADO"));
                ep.setFechaAlta(fromFechaHoraMhtoWEBMh(rs.getString("TRAILING_STS_DATE")));
                ep.setFechaCaducidad(fromFechaHoraMhtoWEBMh(rs.getString("LEADING_STS_DATE")));
                ep.setProveedor(rs.getString("SHIP_TO"));
                ep.setTipo(rs.getString("ORDER_TYPE"));
                listaPedidos.add(ep);
                
            }
        }catch(Exception e){
            System.err.println("Error "+e);
        }finally{
            try {
                if(getDatosMh()!= null)getDatosMh().close();
                if(pst!=null)pst.close();
                if(rs!=null)rs.close();
            } catch (Exception e) {
                System.err.println("Error "+e);
                
            }
            
        }
        return listaPedidos;
    }
    public boolean Clientes(String cliente){
        PreparedStatement pst = null;
        ResultSet rs=null;
        try{
            String consulta="SELECT * FROM CUSTOMER WHERE COMPANY=?";
            pst = getDatosMh().prepareStatement(consulta);
            pst.setString(1, cliente);
            
            rs=pst.executeQuery();
            if(rs.absolute(1)){
                return true;
            }
        }catch(Exception e){
            System.err.println("Error "+e);
        }finally{
            try {
                if(getDatosMh()!= null)getDatosMh().close();
                if(pst!=null)pst.close();
                if(rs!=null)rs.close();
            } catch (Exception e) {
                System.err.println("Error "+e);
                
            }
            
        }
        return false;
    }
    public String getWarehouse(String cliente){
        String Warehouse="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            
            if (getDatosMh().isClosed()==true)
             {
                getConectar();
                getDatosMh();
             } 
            
            String consulta = "SELECT WAREHOUSE FROM LOCATION_INVENTORY LI LEFT JOIN ITEM I " +
                              "ON LI.ITEM=I.ITEM WHERE LI.COMPANY=? GROUP BY WAREHOUSE ";
            pst = getDatosMh().prepareStatement(consulta);
            pst.setString(1, cliente);
            
            rs = pst.executeQuery();
            while (rs.next()) {
                Warehouse=rs.getString("WAREHOUSE");
            }
            
            return Warehouse;
            
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                if (getDatosMh() != null) {
                    getDatosMh().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {
                System.err.println("Error " + e);

            }

        }
        
        return null;
    }
    public  LinkedList<Proveedores> getProveedor(String cliente, String codigo, String nombre) {
        LinkedList<Proveedores> listaProveedor = new LinkedList<Proveedores>();
        String consulta ="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            
            if (codigo.equals("") && nombre!=""){
              if (getDatosMh().isClosed()==true)
                {
                    getConectar();
                    getDatosMh();
                }
                consulta = "SELECT * FROM VENDOR WHERE COMPANY = ? AND  VENDOR_NAME LIKE  ? AND VENDOR_NAME_INHERITED='Y' ";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, cliente);
                pst.setString(2, nombre);
            }
            if (codigo!="" && nombre.equals("")){
            
                if (getDatosMh().isClosed()==true)
                {
                    getConectar();
                    getDatosMh();
                }
                consulta = "SELECT * FROM VENDOR WHERE COMPANY = ? AND  VENDOR LIKE  ? AND VENDOR_NAME_INHERITED='Y' ";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, cliente);
                pst.setString(2, codigo);
            }
           
  
            
            rs = pst.executeQuery();
            while (rs.next()) {
                Proveedores prov = new Proveedores(); 
                prov.setCodigo(rs.getString("VENDOR"));
                prov.setNombre(rs.getString("VENDOR_NAME"));
                prov.setDireccion(rs.getString("ADDRESS1"));
                prov.setCiudad(rs.getString("CITY"));
                prov.setProvincia(rs.getString("ADDRESS2"));
                prov.setPais(rs.getString("COUNTRY"));
                listaProveedor.add(prov);
                
            }
            

        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            try {
                if(getDatosMh()!= null)getDatosMh().close();
                if(pst!=null)pst.close();
                if(rs!=null)rs.close();
            } catch (Exception e) {
                e.printStackTrace();
                
            }
            
        }
        
        return listaProveedor;
    }
    public  LinkedList<ClientesPe> getCliente(String cliente, String codigo, String nombre) {
        LinkedList<ClientesPe> listaClientes = new LinkedList<ClientesPe>();
        String consulta ="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            if (getDatosMh().isClosed()==true)
            {
                getConectar();
                getDatosMh();
            }
            
            if (codigo.equals("") && nombre!=""){
            
                consulta = "SELECT * FROM CUSTOMER WHERE COMPANY = ? AND  NAME LIKE  ? AND (SHIP_TO IS NOT NULL) ";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, cliente);
                pst.setString(2, nombre);
            }
            if (codigo!="" && nombre.equals("")){
            
                consulta = "SELECT * FROM CUSTOMER WHERE COMPANY = ? AND  SHIP_TO LIKE  ?  AND (SHIP_TO IS NOT NULL) ";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, cliente);
                pst.setString(2, codigo);
            }
           
  
            
            rs = pst.executeQuery();
            while (rs.next()) {
                ClientesPe prov = new ClientesPe(); 
                prov.setCodigo(rs.getString("CUSTOMER"));
                prov.setShip_to(rs.getString("SHIP_TO"));
                prov.setNombre(rs.getString("NAME"));
                prov.setDireccion(rs.getString("ADDRESS1"));
                prov.setCiudad(rs.getString("CITY"));
                prov.setProvincia(rs.getString("ADDRESS2"));
                prov.setPais(rs.getString("COUNTRY"));
                listaClientes.add(prov);
                
            }
            

        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            try {
                if(getDatosMh()!= null)getDatosMh().close();
                if(pst!=null)pst.close();
                if(rs!=null)rs.close();
            } catch (Exception e) {
                e.printStackTrace();
                
            }
            
        }
        
        return listaClientes;
    }
    
    public  LinkedList<ClientesPe> getClientes() {
        LinkedList<ClientesPe> listaClientes = new LinkedList<ClientesPe>();
        String consulta ="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            if (getDatosMh().isClosed()==true)
            {
                getConectar();
                getDatosMh();
            }
            
            consulta = "SELECT COMPANY,NAME FROM COMPANY WHERE ACTIVE = 'Y' ";
            pst = getDatosMh().prepareStatement(consulta);
            
            rs = pst.executeQuery();
            while (rs.next()) {
                ClientesPe prov = new ClientesPe(); 
                prov.setCodigo(rs.getString("COMPANY"));
                prov.setNombre(rs.getString("NAME"));
                listaClientes.add(prov);
                
            }
            

        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            try {
                if(getDatosMh()!= null)getDatosMh().close();
                if(pst!=null)pst.close();
                if(rs!=null)rs.close();
            } catch (Exception e) {
                e.printStackTrace();
                
            }
            
        }
        
        return listaClientes;
    }
    
    public  LinkedList<ClientesPe> getClientePropietario(String cliente, String codigo, String nombre) {
        LinkedList<ClientesPe> listaClientes = new LinkedList<ClientesPe>();
        String consulta ="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            
            if (getDatosMh().isClosed()==true)
            {
                getConectar();
                getDatosMh();
            }
            
            if (codigo.equals("") && nombre!=""){
            
                consulta = "SELECT * FROM CUSTOMER WHERE COMPANY = ? AND  NAME LIKE  ? AND PARENT='Y' ";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, cliente);
                pst.setString(2, nombre);
            }
            
            if (codigo!="" && nombre.equals("")){
            
                consulta = "SELECT * FROM CUSTOMER WHERE COMPANY = ? AND  SHIP_TO LIKE  ? AND (SHIP_TO IS NOT NULL)";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, cliente);
                pst.setString(2, codigo);
            }
           
            rs = pst.executeQuery();
            while (rs.next()) {
                ClientesPe prov = new ClientesPe(); 
                prov.setCodigo(rs.getString("CUSTOMER"));
                prov.setShip_to(rs.getString("SHIP_TO"));
                prov.setNombre(rs.getString("NAME"));
                prov.setDireccion(rs.getString("ADDRESS1"));
                prov.setCiudad(rs.getString("CITY"));
                prov.setProvincia(rs.getString("ADDRESS2"));
                prov.setPais(rs.getString("COUNTRY"));
                listaClientes.add(prov);
                
            }
            

        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            try {
                if(getDatosMh()!= null)getDatosMh().close();
                if(pst!=null)pst.close();
                if(rs!=null)rs.close();
            } catch (Exception e) {
                e.printStackTrace();
                
            }
            
        }
        
        return listaClientes;
    }
    
    
    public  LinkedList<DetalleOrdenEntrada> getDetalleOrdenEntrada(String codOE) {
        LinkedList<DetalleOrdenEntrada> listaDetalleOe = new LinkedList<DetalleOrdenEntrada>();
        String consulta ="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            
            if (codOE!=""){
            
                consulta = "SELECT * FROM RECEIPT_DETAIL RD LEFT JOIN ITEM I ON RD.ITEM=I.ITEM WHERE INTERNAL_RECEIPT_NUM =  ? ";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, codOE);
                
            }

            rs = pst.executeQuery();
            while (rs.next()) {
                DetalleOrdenEntrada oe = new DetalleOrdenEntrada(); 
                oe.setNumLinea(rs.getString("ERP_ORDER_LINE_NUM"));
                oe.setCodClte(rs.getString("INTERNAL_ITEM_NUM"));
                oe.setCodMh(rs.getString("ITEM"));
                oe.setDescripcion(rs.getString("ITEM_DESC"));
                oe.setLote(rs.getString("LOT"));
                oe.setVencimiento(fromFechaHoraMhtoWEBMh(rs.getString("EXPIRATION_DATE_TIME")));
                oe.setCantidad(rs.getString("TOTAL_QTY"));
                oe.setCantidadRecep(rs.getString("ORIGINAL_TOTAL_QUANTITY"));
                listaDetalleOe.add(oe);
                
            }
            

        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            try {
                if(getDatosMh()!= null)getDatosMh().close();
                if(pst!=null)pst.close();
                if(rs!=null)rs.close();
            } catch (Exception e) {
                e.printStackTrace();
                
            }
            
        }
        
        return listaDetalleOe;
    }
    public  LinkedList<DetallePedidos> getDetallePedidos(String codOE) {
        LinkedList<DetallePedidos> listaPedidos = new LinkedList<DetallePedidos>();
        String consulta ="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            
            if (codOE!=""){
            
                consulta = "SELECT * FROM SHIPMENT_DETAIL  WHERE INTERNAL_SHIPMENT_NUM =  ? ";
                pst = getDatosMh().prepareStatement(consulta);
                pst.setString(1, codOE);
                
            }

            rs = pst.executeQuery();
            while (rs.next()) {
                DetallePedidos dep = new DetallePedidos(); 
                dep.setNumLinea(rs.getString("ERP_ORDER_LINE_NUM"));
                dep.setCodClte(rs.getString("ORIGINAL_ITEM_ORDERED"));
                dep.setCodMh(rs.getString("ITEM"));
                dep.setDescripcion(rs.getString("ITEM_DESC"));
                dep.setLote(rs.getString("LOT"));
                dep.setVencimiento(fromFechaHoraMhtoWEBMh(rs.getString("DATE_TIME_STAMP")));
                dep.setCantidad(rs.getString("TOTAL_QTY"));
                dep.setCantidadRecep(rs.getString("QUANTITY_AT_STS1"));
                listaPedidos.add(dep);
                
            }
            

        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            try {
                if(getDatosMh()!= null)getDatosMh().close();
                if(pst!=null)pst.close();
                if(rs!=null)rs.close();
            } catch (Exception e) {
                e.printStackTrace();
                
            }
            
        }
        
        return listaPedidos;
    }

}
