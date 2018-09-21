
package Modelo;

import static cl.webmh.util.GENEFechas.FechaSinSeparacion;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;


public class detalleDespacho {
    
    public detalleDespacho()
    {
    }
        public static String dataMap()
        {
            String datamap="WEBDSPD";
            int largo=10;
            if(datamap.length()>largo)
            {
                
            }
            else
            {
                while (datamap.length()<largo)
                {
                    datamap+=" ";
                }
            
            }
            return datamap;
        }
        public static String interfaceActionCode(String cadena,String linea){
            int largo =20, largol=4;
            String dato="";
            //if (linea.length()>largol){}else{while (linea.length()>largol){String.format("%04d",linea);}}
            if(cadena.length()>largo){ }else{dato=String.format("%04d",Integer.parseInt(linea))+cadena; while (dato.length()<largo){(dato)+=" ";}}
            return dato;
        }
        public static String interfaceLinkId(String cadena){
            int largo =15;
            if(cadena.length()>largo)
            {}else{
                while (cadena.length()<largo){
                    cadena+=" ";
                }
            }
            return cadena;
        }
        public static String orden(String cadena){
            int largo =15;
            if(cadena.length()>largo)
            {}else{
                while (cadena.length()<largo){
                    cadena+=" ";
                }
            }
            return cadena;
        }
        public static String lineaOrden(String cadena)
        {
            //String datamap="DSP";
            int largo=6;
            if(cadena.length()>largo)
            {
                
            }
            else
            {
                while (cadena.length()<largo)
                {
                    cadena+=" ";
                }
            
            }
            return cadena;
        }
        public static String codigoItem(String cadena){
            int largo =25;
            if(cadena.length()>largo)
            {
                
            }
            else
            {
                while (cadena.length()<largo)
                {
                    cadena+=" ";
                }
            
            }
            return cadena;
        }
        public static String lote(String cadena){
            int largo =25;
            if(cadena.length()>largo)
            {
                
            }
            else
            {
                while (cadena.length()<largo)
                {
                    cadena+=" ";
                }
            
            }
            return cadena;
        }
        public static String precio(String cadena){
            int largo =12;
            if(cadena.length()>largo)
            {
                
            }
            else
            {
                while (cadena.length()<largo)
                {
                    cadena+=" ";
                }
            
            }
            return cadena;
        }
        public static String cantidadOrdenada(String cadena){
            int largo =17;
            cadena=cadena.replace(".","");
            
            if(cadena.length()>largo)
            {
                
            }
            else
            {
                while (cadena.length()<largo)
                {
                    cadena+=" ";
                }
            
            }
            return cadena;
        }
        public static String fechaOrden(String cadena) throws ParseException{
            int largo =14;
            String retorno;
            cadena=FechaSinSeparacion(cadena);
            SimpleDateFormat formateador = new SimpleDateFormat("ddMMyyyy");
            SimpleDateFormat formato = new SimpleDateFormat("yyyyMMdd");
            retorno = formato.format(formateador.parse(cadena));
            if(retorno.length()>largo)
            {
                
            }
            else
            {
                while (retorno.length()<largo)
                {
                    retorno+="0";
                }
            
            }
            return retorno;
        }
        public static String company(String cadena){
            int largo =25;
            if(cadena.length()>largo)
            {
                
            }
            else
            {
                while (cadena.length()<largo)
                {
                    cadena+=" ";
                }
            
            }
            return cadena;
        }
}
