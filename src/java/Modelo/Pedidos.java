
package Modelo;

public class Pedidos {
    String codSeguimiento;
    String codOE;
    String fechaAlta;
    String tipo;
    String fechaCaducidad;
    String estado;
    String proveedor;
    String comentario;   

    public Pedidos() {
        this.codSeguimiento = codSeguimiento;
        this.codOE = codOE;
        this.fechaAlta = fechaAlta;
        this.tipo = tipo;
        this.fechaCaducidad = fechaCaducidad;
        this.estado = estado;
        this.proveedor = proveedor;
        this.comentario = comentario;
    }

    public String getCodSeguimiento() {
        return codSeguimiento;
    }

    public String getCodOE() {
        return codOE;
    }

    public String getFechaAlta() {
        return fechaAlta;
    }

    public String getTipo() {
        return tipo;
    }

    public String getFechaCaducidad() {
        return fechaCaducidad;
    }

    public String getEstado() {
        return estado;
    }

    public String getProveedor() {
        return proveedor;
    }

    public String getComentario() {
        return comentario;
    }

    public void setCodSeguimiento(String codSeguimiento) {
        this.codSeguimiento = codSeguimiento;
    }

    public void setCodOE(String codOE) {
        this.codOE = codOE;
    }

    public void setFechaAlta(String fechaAlta) {
        this.fechaAlta = fechaAlta;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public void setFechaCaducidad(String fechaCaducidad) {
        this.fechaCaducidad = fechaCaducidad;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public void setProveedor(String proveedor) {
        this.proveedor = proveedor;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }
            
}
