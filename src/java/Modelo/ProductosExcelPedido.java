/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/**
 *
 * @author gcardenas
 */
public class ProductosExcelPedido {
         String NumPedido;
         String CodCli;
         String RutCliente;
         String NomCliente;
         String FechaEntrega;
         String CodArt;
         String Descripcion;
         int Cantidad;
         String Lote;
         String Observacion;

        private ProductosExcelPedido(String _NumPedido, String _CodCli, String _RutCliente, String _NomCliente,String _FechaEntrega, String _CodArt, String _Descripcion, int _Cantidad, String _Lote,String _Observacion) {
            NumPedido = _NumPedido;
            CodCli =_CodCli;
            RutCliente =_RutCliente;
            NomCliente = _NomCliente;
            FechaEntrega = _FechaEntrega;   
            CodArt = _CodArt;
            Descripcion = _Descripcion;
            Cantidad = _Cantidad;
            Lote = _Lote;
            Observacion = _Observacion;
        }    

     public String getNumPedido() {
        return NumPedido;
     }

     public String getCodCli() {
        return CodCli;
     }
          
     public String getRutCliente() {
        return RutCliente;
     }

     public String getNomCliente() {
        return NomCliente;
     }
          
     public String getFechaEntrega() {
            return FechaEntrega;
        }
     
     public String getCodArt() {
            return CodArt;
        }
       
        public String getDescripcion() {
            return Descripcion;
        }
 
        public int getCantidad() {
            return Cantidad;
        }
 
        public String getLote() {
            return Lote;
        }
        
        public String getObservacion() {
            return Observacion;
        }
 
        public void setNumPedido(String _NumPedido) {
            this.NumPedido = _NumPedido;
        }  
 
        public void setCodCli(String _CodCli) {
            this.CodCli = _CodCli;
        }  
        
        public void setRutCliente(String _RutCliente) {
            this.RutCliente = _RutCliente;
        }  
        
        public void setNomCliente(String _NomCliente) {
            this.NomCliente = _NomCliente;
        }  
                
        public void setFechaEntrega(String _FechaEntrega) {
            this.FechaEntrega = _FechaEntrega;
        }   
       
        public void setCodArt(String _CodArt) {
            this.CodArt = _CodArt;
        }
     
        public void setDescripcion(String _Descripcion) {
            this.Descripcion = _Descripcion;
        }
                
        public void setLote(String _Lote) {
            this.Lote = _Lote;
        }
 
        public void setCantidad(int _Cantidad) {
            this.Cantidad = _Cantidad;
        }
    
        public void setObservacion(String _Observacion) {
            this.Observacion = _Observacion;
        }
 
        public ProductosExcelPedido() {
            this.NumPedido = NumPedido;
            this.RutCliente = RutCliente;
            this.NomCliente = NomCliente;
            this.FechaEntrega = FechaEntrega;
            this.CodArt = CodArt;
            this.Lote = Lote;
            this.Descripcion = Descripcion;
            this.Cantidad = Cantidad;
            this.Observacion = Observacion;
    }
}
