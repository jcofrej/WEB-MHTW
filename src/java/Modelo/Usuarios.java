
package Modelo;

public class Usuarios {
    public String IdUsuario;
    public String Nombre;
    public String Password;
    public String Descripcion;
    public String Bloqueo;
    public String IdCliente;
    public String TipoUsuario;
    
    public Usuarios(String IdUsuario,String Nombre, String Password, String Descripcion, String Bloqueo, String IdCliente,String TipoUsuario) {
        this.IdUsuario = IdUsuario;
        this.Nombre = Nombre;
        this.Password = Password;
        this.Descripcion = Descripcion;
        this.Bloqueo = Bloqueo;
        this.IdCliente=IdCliente;
        this.TipoUsuario = TipoUsuario;
    }

    public String getIdUsuario() {
        return IdUsuario;
    }
    
    public void setIdUsuario(String IdUsuario) {
        this.IdUsuario = IdUsuario;
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

    public String getDescripcion() {
        return Descripcion;
    }

    public void setDescripcion(String Descripcion) {
        this.Descripcion = Descripcion;
    }

    public String getBloqueo() {
        return Bloqueo;
    }

    public void setBloqueo(String Bloqueo) {
        this.Bloqueo = Bloqueo;
    }
        
    public String getIdCliente() {
        return IdCliente;
    }

    public void setIdCliente(String IdCliente) {
        this.IdCliente = IdCliente;
    }

    public String getTipoUsuario() {
        return TipoUsuario;
    }

    public void setTipoUsuario(String TipoUsuario) {
        this.TipoUsuario = TipoUsuario;
    }
    
}
