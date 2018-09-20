
package Modelo;

public class DetalleStock {
    String codArt;
    String codMh;
    String descripcion;
    String cantidad;
    String lote;
    String vencimiento;
    String estado;

    public DetalleStock() {
        this.codArt = codArt;
        this.codMh = codMh;
        this.descripcion = descripcion;
        this.cantidad = cantidad;
        this.lote = lote;
        this.vencimiento = vencimiento;
        this.estado = estado;
    }

    public String getCodArt() {
        return codArt;
    }

    public void setCodArt(String codArt) {
        this.codArt = codArt;
    }

    public String getCodMh() {
        return codMh;
    }

    public void setCodMh(String codMh) {
        this.codMh = codMh;
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

    public String getLote() {
        return lote;
    }

    public void setLote(String lote) {
        this.lote = lote;
    }

    public String getVencimiento() {
        return vencimiento;
    }

    public void setVencimiento(String vencimiento) {
        this.vencimiento = vencimiento;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}
