 package cl.webmh.config;
 
 import org.apache.commons.logging.Log;
 import org.apache.commons.logging.LogFactory;
 import org.apache.log4j.Logger;
 
 public class WEBMHConfigApp
 {
   public static Logger logger = Logger.getLogger(WEBMHConfigApp.class);
 
   public static Log getLogger(Class c) {
     Log logger = LogFactory.getLog(c);
     return logger;
   }
 }
