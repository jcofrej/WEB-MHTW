
package cl.webmh.framework;

import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;
import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import org.apache.log4j.Logger;

public class MhConfiguracion {

  public static final String SEPARADOR = File.separator;
  private static ServletConfig servletConfig;
  static Logger fwlogger = Logger.getLogger(MhConfiguracion.class);

  private static Properties prop = null;

  public static String getValor(String propiedad)
  {
    prop = new Properties();
    String rutaRealRoot = servletConfig.getServletContext().getRealPath(SEPARADOR + "WEB-INF" + SEPARADOR + "config" + SEPARADOR + "app-config.properties");
    FileInputStream fis = null;
    try {
      fis = new FileInputStream(rutaRealRoot);
      prop.load(fis);
    } catch (Exception ex) {
      ex.printStackTrace();

      if (fis != null)
        try {
          fis.close();
        } catch (Exception ex2) {
          ex2.printStackTrace();
        }
    }
    finally
    {
      if (fis != null) {
        try {
          fis.close();
        } catch (Exception ex2) {
          ex2.printStackTrace();
        }
      }
    }

    String res = prop.getProperty(propiedad);

    return res;
  }

  public static final ServletConfig getServletConfig()
  {
    return servletConfig;
  }

  public static void inicializar(Servlet servlet)
    throws Exception
  {
    servletConfig = servlet.getServletConfig();

    if (servletConfig == null) {
      throw new Exception("ERROR: al arrancar la aplicacion no existe servlet de inicialización");
    }

    ServletContext application = servletConfig.getServletContext();

    fwlogger.info("inicializando log y properties");
    prop = new Properties();
    String rutaRealRoot = application.getRealPath("/WEB-INF/config/app-config.properties");
    FileInputStream fis = null;
    try {
      fis = new FileInputStream(rutaRealRoot);
      prop.load(fis);
    } catch (Exception ex) {
      ex.printStackTrace();

      if (fis != null)
        try {
          fis.close();
        } catch (Exception ex2) {
          ex2.printStackTrace();
        }
    }
    finally
    {
      if (fis != null)
        try {
          fis.close();
        } catch (Exception ex2) {
          ex2.printStackTrace();
        }
    }
  }
}    

