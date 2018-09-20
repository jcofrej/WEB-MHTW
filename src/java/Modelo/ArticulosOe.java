
package Modelo;

public class ArticulosOe {
    private String articuloPropietario;
    private String articuloMh;
    private String descripcion;
    private String cantidad;
    private String usuario;
    private String cliente;
    private String lote;

    public ArticulosOe(String articuloPropietario, String articuloMh, String descripcion, String cantidad, String usuario, String cliente, String lote) {
        
        this.articuloPropietario = articuloPropietario;
        this.articuloMh = articuloMh;
        this.descripcion = descripcion;
        this.cantidad = cantidad;
        this.usuario = usuario;
        this.cliente = cliente;
        this.lote = lote;
    }

    public String getLote() {
        return lote;
    }

    public void setLote(String lote) {
        this.lote = lote;
    }

    public String getArticuloPropietario() {
        return articuloPropietario;
    }

    public void setArticuloPropietario(String articuloPropietario) {
        this.articuloPropietario = articuloPropietario;
    }

    public String getArticuloMh() {
        return articuloMh;
    }

    public void setArticuloMh(String articuloMh) {
        this.articuloMh = articuloMh;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getCantidad() {
        return cantidad;
    }

    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getCliente() {
        return cliente;
    }

    public void setCliente(String cliente) {
        this.cliente = cliente;
    }
    
}
