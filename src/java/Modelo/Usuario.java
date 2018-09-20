
package Modelo;


public class Usuario {
    public String Nombre;
    public String Password;
    public String Sesion;
    public String Cliente;

    public Usuario(String Nombre, String Password) {
        this.Nombre = Nombre;
        this.Password = Password;
    }  

    public void setSesion(String Sesion) {
        this.Sesion = Sesion;
    }

    public void setCliente(String Cliente) {
        this.Cliente = Cliente;
    }

    public String getSesion() {
        return Sesion;
    }

    public String getCliente() {
        return Cliente;
    }

    public String getNombre() {
        return Nombre;
    }
        
    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }


    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }
}
