
package cl.webmh.framework;


import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import javax.servlet.ServletException;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionServlet;

public class MhActionServlet extends ActionServlet
{
  private static final long serialVersionUID = -7158215801791830302L;
  static Logger fwlogger = Logger.getLogger(MhActionServlet.class);

  public void initOther()
    throws ServletException
  {
    super.initOther();
    try {
      MhConfiguracion.inicializar(this);
    } catch (ServletException e1) {
      if (fwlogger != null) {
        fwlogger.error(e1);
        fwlogger.error(getStack(e1));
      } else {
        System.out.println(e1);
        e1.printStackTrace();
      }
      throw e1;
    } catch (Exception e2) {
      if (fwlogger != null) {
        fwlogger.error(e2);
        fwlogger.error(getStack(e2));
      } else {
        System.out.println(e2);
        e2.printStackTrace();
      }
    }
  }

  public void destroy()
  {
    try {
      fwlogger.info("appConfig.finalizar()");
    }
    catch (Exception e) {
      if (fwlogger != null) {
        fwlogger.error(e);
        fwlogger.error(getStack(e));
      } else {
        System.out.println(e);
        e.printStackTrace();
      }
    }
  }

  public static String getStack(Throwable t) {
    String dump = null;
    try {
      ByteArrayOutputStream bs = new ByteArrayOutputStream();
      PrintStream ps = new PrintStream(bs, true);
      t.printStackTrace(ps);
      dump = bs.toString();
      ps.close();
      bs.close();
    }
    catch (IOException localIOException) {
    }
    return dump;
  }
}