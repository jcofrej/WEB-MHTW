 package cl.webmh.util;
 
 import cl.webmh.config.WEBMHConfigApp;
 import java.util.List;
 import org.apache.log4j.Logger;
 
 public class Pager
 {
   public static final String ULTIMO = "ULTIMO";
   public static final String PRIMERO = "PRIMERO";
   protected Integer rows = Integer.valueOf(0);
 
   protected String pageCurrent = "1";
 
   protected String totalPag = "0";
 
   public Pager(Integer rows, String page, String totalPag, Integer records)
   {
     this.rows = rows;
     this.pageCurrent = page;
     this.totalPag = totalPag;
   }
 
   public Pager()
   {
   }
 
   public Pager(Integer rows, String stNumPagPorPag, String pageCurrent)
   {
     this.rows = rows;
     this.totalPag = calculaTotalPag(stNumPagPorPag);
     calculaPageCurrent(this.totalPag, pageCurrent);
   }
 
   public Pager(Integer rows, String stNumPagPorPag) {
     this.rows = rows;
     this.totalPag = calculaTotalPag(stNumPagPorPag);
     this.pageCurrent = "1";
   }
 
   public Pager(List<?> listado, String stNumPagPorPag) {
     this.pageCurrent = "1";
     this.rows = Integer.valueOf(listado.size());
     this.totalPag = calculaTotalPag(stNumPagPorPag);
   }
 
   public Integer getRows() {
     return this.rows;
   }
 
   public void setRows(Integer rows) {
     this.rows = rows;
   }
 
   public String getPageCurrent() {
     return this.pageCurrent;
   }
 
   public void setPageCurrent(String page) {
     this.pageCurrent = page;
   }
 
   public String getTotalPag() {
     return this.totalPag;
   }
 
   public void calculaPageCurrent(String totalPage, String newPageCurrent) {
     try {
       if (newPageCurrent.equals("ULTIMO"))
         this.pageCurrent = this.totalPag;
       else if ((newPageCurrent.equals("PRIMERO")) || (newPageCurrent.equals("")))
         this.pageCurrent = "1";
       else {
         this.pageCurrent = newPageCurrent;
       }
       if (new Integer(this.pageCurrent).intValue() > new Integer(this.totalPag).intValue())
         this.pageCurrent = this.totalPag;
     }
     catch (Exception ex) {
       WEBMHConfigApp.logger.error("Error en actualizaPageCurrent:" + ex.getMessage());
       this.pageCurrent = "1";
     }
   }
 
   public String calculaTotalPag(String stNunPagPorTabla)
   {
     int numPaginas = 0;
     try
     {
       int iNumPagPorPag = new Integer(stNunPagPorTabla).intValue();
       if (this.rows.intValue() % iNumPagPorPag > 0)
         numPaginas = this.rows.intValue() / iNumPagPorPag + 1;
       else
         numPaginas = this.rows.intValue() / iNumPagPorPag;
     }
     catch (Exception ex) {
       WEBMHConfigApp.logger.error("error:" + ex.getMessage());
       numPaginas = 0;
     }
 
     return String.valueOf(numPaginas);
   }
 
   public void setTotalPag(String totalPag) {
     this.totalPag = totalPag;
   }
 
   public String toString()
   {
     return "Pager [rows=" + this.rows + ", pageCurrent=" + this.pageCurrent + ", totalPag=" + this.totalPag + "]";
   }
 }
