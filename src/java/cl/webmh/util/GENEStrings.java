 package cl.webmh.util;
 
 import java.util.ArrayList;
 
 public class GENEStrings
 {
   public static boolean isVacio(String cadena)
   {
     if ((cadena == null) || (cadena.trim().equals(""))) {
       return true;
     }
     return false;
   }
 
   public static boolean isOpcionVacia(String id)
   {
     if ((id == null) || (id.trim().equals("-1"))) {
       return true;
     }
     return false;
   }
 
   public static boolean contieneCadena(String texto, String cadena)
   {
     int resultado = texto.indexOf(cadena);
     if (resultado == -1) {
       return false;
     }
     return true;
   }
 
   public static String truncarCadena(String cadena, int maximo)
   {
     if ((cadena != null) && (cadena.length() > maximo)) {
       return cadena.substring(0, maximo) + "...";
     }
     return cadena;
   }
 
   public static ArrayList ObtenerCamposSeparados(String texto, String separador)
   {
     ArrayList valoresSeparados = new ArrayList();
 
     String valor = "";
     String resto = texto;
     int posicionPuntoComa = texto.indexOf(separador);
 
     while (posicionPuntoComa >= 0) {
       valor = resto.substring(0, posicionPuntoComa);
       resto = resto.substring(posicionPuntoComa + 1);
       posicionPuntoComa = resto.indexOf(separador);
 
       valoresSeparados.add(valor);
     }
 
     if (resto.length() > 0) {
       valoresSeparados.add(resto);
     }
     return valoresSeparados;
   }
 
   public static ArrayList ObtenerCamposSeparadosNumero(String texto, String separador)
   {
     ArrayList valoresSeparados = new ArrayList();
 
     String valor = "";
     String resto = texto;
     int posicionPuntoComa = texto.indexOf(separador);
 
     while (posicionPuntoComa >= 0) {
       valor = resto.substring(0, posicionPuntoComa);
       resto = resto.substring(posicionPuntoComa + 1);
       posicionPuntoComa = resto.indexOf(separador);
       valoresSeparados.add(valor);
       valoresSeparados.add(resto);
     }
     return valoresSeparados;
   }
 
   public static String quitarParteDecimalCero(String numero)
   {
     String resultado = numero;
 
     int i = numero.indexOf('.');
     Integer.parseInt(numero.substring(0, i));
     int parteFraccion = Integer.parseInt(numero.substring(i + 1));
     if (parteFraccion == 0) {
       resultado = numero.substring(0, i);
     }
 
     return resultado;
   }
 
   public static String rellenarIzquierda(String cadena, char caracterRelleno, int longitudTotal)
   {
     String retorno = "";
 
     if ((!isOpcionVacia(cadena)) && (cadena.length() < longitudTotal)) {
       char[] arrChar = { caracterRelleno };
       String relleno = new String(arrChar);
       for (int i = 0; i < longitudTotal - cadena.length(); i++) {
         retorno = retorno + relleno;
       }
     }
     retorno = retorno + cadena;
 
     return retorno;
   }
 
   public static String rellenarDerecha(String cadena, char caracterRelleno, int longitudTotal) {
     String retorno = "";
 
     if ((!isOpcionVacia(cadena)) && (cadena.length() < longitudTotal)) {
       char[] arrChar = { caracterRelleno };
       String relleno = new String(arrChar);
       for (int i = 0; i < longitudTotal - cadena.length(); i++) {
         retorno = retorno + relleno;
       }
     }
     retorno = cadena + retorno;
 
     return retorno;
   }
 
   public static boolean contieneElemento(String[] listado, String elemento)
   {
     boolean encontrado = false;
 
     for (int i = 0; (i < listado.length) && (!encontrado); i++) {
       if (listado[i].equals(elemento)) {
         encontrado = true;
       }
     }
 
     return encontrado;
   }
 }
