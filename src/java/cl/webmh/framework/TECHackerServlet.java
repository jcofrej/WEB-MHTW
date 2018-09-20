/*    */ package cl.webmh.framework;
/*    */ 
/*    */ import java.io.IOException;
/*    */ import javax.servlet.ServletException;
/*    */ import javax.servlet.http.HttpServlet;
/*    */ import javax.servlet.http.HttpServletRequest;
/*    */ import javax.servlet.http.HttpServletResponse;
/*    */ 
/*    */ public class TECHackerServlet extends HttpServlet
/*    */ {
/*    */   private static final long serialVersionUID = 1L;
/*    */ 
/*    */   protected void doGet(HttpServletRequest request, HttpServletResponse response)
/*    */     throws ServletException, IOException
/*    */   {
/* 27 */     sirve(request, response);
/*    */   }
/*    */ 
/*    */   protected void doPost(HttpServletRequest request, HttpServletResponse response)
/*    */     throws ServletException, IOException
/*    */   {
/* 34 */     sirve(request, response);
/*    */   }
/*    */ 
/*    */   protected void sirve(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
/* 38 */     response.sendRedirect("/WEB-INF/jsp/error.jsp");
/*    */   }
/*    */ }
