
package cl.webmh.datos.cl.acceso;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;


public class DatosWeb {
    ResourceBundle rb = ResourceBundle.getBundle("cl.webmh.framework.ApplicationResources");
    private String userWeb=rb.getString("USER_WEB");
    private String passWeb=rb.getString("PASS_WEB");
    private String hostWeb=rb.getString("IP_WEB");
    //private String portWeb="62735";
    private String dbWeb=rb.getString("NAME_WEB");
    private String classNameWeb="com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private String urlWeb="jdbc:sqlserver://"+hostWeb+";databaseName="+dbWeb;        
    private Connection conWeb;
    
    public DatosWeb() {
    try{
        Class.forName(classNameWeb);
        conWeb=DriverManager.getConnection(urlWeb, userWeb, passWeb);
        
    }
    catch(ClassNotFoundException e){
        System.err.println("Error "+e);
    }   catch (SQLException e) {
            System.err.println("Error "+e);
        }

    }
    public Connection getDatosWeb(){
        return conWeb;
    }
    
    public static void main(String[] args){
    DatosWeb conn= new DatosWeb();
    }
}
