
package Modelo;

public class Stock {
  String codArt;
  String codMh;
  String descripcion;
  String cantidad;

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

    public Stock() {
        this.codArt = codArt;
        this.codMh = codMh;
        this.descripcion = descripcion;
        this.cantidad = cantidad;
    }
    
}
