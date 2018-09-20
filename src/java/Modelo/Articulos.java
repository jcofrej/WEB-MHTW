
package Modelo;

public class Articulos {
  String codArt;
  String codMh;
  String descripcion;
  String categoria;

    public Articulos() {
        this.codArt = codArt;
        this.codMh = codMh;
        this.descripcion = descripcion;
        this.categoria = categoria;
    }

    public String getCodArt() {
        return codArt;
    }

    public void setCodArt(String codArt) {
        this.codArt = codArt;
    }

    public void setCodMh(String codMh) {
        this.codMh = codMh;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getCodMh() {
        return codMh;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public String getCategoria() {
        return categoria;
    }
  
}
