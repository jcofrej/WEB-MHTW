
package cl.webmh.datos.cl.acceso;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DatosWeb {
    private String userWeb="sa";
    private String passWeb="twl#123.";
    private String hostWeb="10.10.15.71";
    //private String portWeb="62735";
    private String dbWeb="WEB";
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
