
package Modelo;

public class DetallePedidos {
    String numLinea;
    String codClte;
    String codMh;
    String descripcion;
    String lote;
    String vencimiento;
    String cantidad;
    String cantidadRecep;

    public void setNumLinea(String numLinea) {
        this.numLinea = numLinea;
    }

    public void setCodClte(String codClte) {
        this.codClte = codClte;
    }

    public void setCodMh(String codMh) {
        this.codMh = codMh;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public void setLote(String lote) {
        this.lote = lote;
    }

    public void setVencimiento(String vencimiento) {
        this.vencimiento = vencimiento;
    }

    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
    }

    public void setCantidadRecep(String cantidadRecep) {
        this.cantidadRecep = cantidadRecep;
    }

    public String getNumLinea() {
        return numLinea;
    }

    public String getCodClte() {
        return codClte;
    }

    public String getCodMh() {
        return codMh;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public String getLote() {
        return lote;
    }

    public String getVencimiento() {
        return vencimiento;
    }

    public String getCantidad() {
        return cantidad;
    }

    public String getCantidadRecep() {
        return cantidadRecep;
    }

    public DetallePedidos() {
        this.numLinea = numLinea;
        this.codClte = codClte;
        this.codMh = codMh;
        this.descripcion = descripcion;
        this.lote = lote;
        this.vencimiento = vencimiento;
        this.cantidad = cantidad;
        this.cantidadRecep = cantidadRecep;
    }
}
