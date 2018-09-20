
package cl.webmh.datos.cl.acceso;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DatosWeb2 {
    private String userWeb2="root";
    private String passWeb2="webmh";
    private String hostWeb2="localhost";
    private String portWeb2="3306";
    private String dbWeb2="web";
    private String classNameWeb2="com.mysql.jdbc.Driver";
    private String urlWeb2="jdbc:mysql://"+hostWeb2+":"+portWeb2+"/"+dbWeb2+"";        
    private Connection conWeb2;
    
    public DatosWeb2() {
    try{
        Class.forName(classNameWeb2);
        conWeb2=DriverManager.getConnection(urlWeb2, userWeb2, passWeb2);
        
    }
    catch(ClassNotFoundException e){
        System.err.println("Error "+e);
    }   catch (SQLException e) {
            System.err.println("Error "+e);
        }

    }
    public Connection getDatosWeb2(){
        return conWeb2;
    }
    
    public static void main(String[] args){
    DatosWeb2 conn2= new DatosWeb2();
    }
}
