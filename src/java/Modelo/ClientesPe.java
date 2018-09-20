
package Modelo;

public class ClientesPe {
    String codigo;
    String ship_to;
    String nombre;
    String direccion;
    String ciudad;
    String provincia;
    String pais;

    public ClientesPe() {
        this.codigo = codigo;
        this.ship_to=ship_to;
        this.nombre = nombre;
        this.direccion = direccion;
        this.ciudad = ciudad;
        this.provincia = provincia;
        this.pais = pais;
    }

    public String getCodigo() {
        return codigo;
    }

    public String getShip_to() {
        return ship_to;
    }

    public void setShip_to(String ship_to) {
        this.ship_to = ship_to;
    }

    public String getNombre() {
        return nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public String getCiudad() {
        return ciudad;
    }

    public String getProvincia() {
        return provincia;
    }

    public String getPais() {
        return pais;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }
    
}
