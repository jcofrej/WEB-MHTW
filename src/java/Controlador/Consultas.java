package Controlador;

import cl.webmh.datos.cl.acceso.DatosWeb;
import Modelo.Usuario;
import Modelo.Usuarios;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Consultas extends DatosWeb {

    public boolean autenticacion(String usuario, String password) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "SELECT * FROM USUARIOS WHERE NOMBRE =? AND PASSWORD=?";
            pst = getDatosWeb().prepareStatement(consulta);
            pst.setString(1, usuario);
            pst.setString(2, password);
            rs = pst.executeQuery();
            while (rs.next()) {

                return true;
            }
        } catch (Exception e) {
            System.err.println("Error " + e);
        } finally {
            try {
                if (getDatosWeb() != null) {
                    getDatosWeb().close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                System.err.println("Error " + e);

            }

        }
        return false;
    }
    public boolean cambioPass(String usuario, String password) {
        PreparedStatement pstup = null;
        
        try {
            String update = "UPDATE USUARIOS SET PASSWORD= ?  WHERE NOMBRE =? ";
            pstup = getDatosWeb().prepareStatement(update);
            pstup.setString(1, password);
            pstup.setString(2, usuario);
            if (pstup.executeUpdate() == 1) {
                return true;
            }
          
        } catch (Exception e) {
            System.err.println("Error " + e);
        } finally {
            try {
                if (getDatosWeb() != null) {
                    getDatosWeb().close();
                }
                if (pstup != null) {
                    pstup.close();
                }

            } catch (Exception e) {
                System.err.println("Error " + e);

            }

        }
        return false;
    }
    public boolean Registrar(String usuario, String password, String nombre, Integer bloqueo, String id_cliente, String tipo_usuario) {
        PreparedStatement pst = null;
        try {
            String consulta = "INSERT INTO USUARIOS (nombre,password,descripcion,bloqueo,id_cliente,tipo_usuario) VALUES (?,?,?,?,?,?)";
            pst = getDatosWeb().prepareStatement(consulta);
            pst.setString(1, usuario);
            pst.setString(2, password);
            pst.setString(3, nombre);
            pst.setInt(4, bloqueo);
            pst.setString(5, id_cliente);
            pst.setString(6, tipo_usuario);

            if (pst.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception e) {
            System.err.println("Error " + e);
        } finally {
            try {
                if (getDatosWeb() != null) {
                    getDatosWeb().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {
                System.err.println("Error " + e);

            }

        }
        return false;
    }

    public String getUsuarioWeb(String usuario){
        String id_cliente="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            
            
            String consulta = "SELECT * FROM USUARIOS WHERE NOMBRE =? ";
            pst = getDatosWeb().prepareStatement(consulta);
            pst.setString(1, usuario);
            
            rs = pst.executeQuery();
            while (rs.next()) {
                id_cliente=rs.getString("ID_CLIENTE");
            }
            
            return id_cliente;
            
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                if (getDatosWeb() != null) {
                    getDatosWeb().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {
                System.err.println("Error " + e);

            }

        }
        
        return null;
    }
    
    public  LinkedList<Usuarios> getListadoUsuariosWeb(){
        PreparedStatement pst = null;
        ResultSet rs = null;
        LinkedList<Usuarios> vrLstUsuario = null;
        Usuarios vrUsuario=null;
        try {
            
            
            String consulta = "SELECT * FROM USUARIOS WHERE BLOQUEO=0 ";
            pst = getDatosWeb().prepareStatement(consulta);
            
            rs = pst.executeQuery();
            while (rs.next()) {
                
                vrUsuario.setNombre(rs.getString("NOMBRE"));
                vrUsuario.setDescripcion(rs.getString("DESCRIPCION"));
                vrUsuario.setIdCliente(rs.getString("ID_CLIENTE"));
                vrUsuario.setTipoUsuario(rs.getString("TIPO_USUARIO"));
                
                vrLstUsuario.add(vrUsuario);
            }
            
            return vrLstUsuario;
            
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                if (getDatosWeb() != null) {
                    getDatosWeb().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {
                System.err.println("Error " + e);

            }

        }
        
        return null;
    }
   
    public String getUsuarioMenu(String usuario){
        String tipo_usuario="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            
            
            String consulta = "SELECT * FROM USUARIOS WHERE NOMBRE =? ";
            pst = getDatosWeb().prepareStatement(consulta);
            pst.setString(1, usuario);
            
            rs = pst.executeQuery();
            while (rs.next()) {
                tipo_usuario=rs.getString("TIPO_USUARIO");
            }
            
            return tipo_usuario;
            
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                if (getDatosWeb() != null) {
                    getDatosWeb().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {
                System.err.println("Error " + e);

            }

        }
        
        return null;
    }
}
