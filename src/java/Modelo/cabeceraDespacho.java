
package Modelo;

import java.text.ParseException;
import java.text.SimpleDateFormat;


public class cabeceraDespacho {
    
    public cabeceraDespacho()
    {
    }
        public static String dataMap()
        {
            String datamap="WEBDSPC";
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
        public static String codeErp(String cadena){
            int largo =15;
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
        public static String interfaceActionCode(String cadena){
            int largo =15;
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
        public static String orden(String cadena){
            int largo =15;
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
        
        public static String tipoOrden()
        {
            String datamap="DSP";
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
        public static String referenciaOrden(String cadena){
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
        public static String codigoCliente(String cadena){
            int largo =20;
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
        public static String codigoDireccionEntrega(String cadena){
            int largo =15;
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
        public static String codigoCompañia(String cadena){
            int largo =10;
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
        public static String carrier(){
            int largo =10;
            String cadena="001";
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
        public static String fechaTransmision(String cadena) throws ParseException{
            int largo =14;
            String retorno;
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
        public static String fechaOrdenDesp(String cadena) throws ParseException{
            int largo =14;
            String retorno;
            cadena=cadena.replace("-", "");
            cadena=cadena.replace("/", "");
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
        public static String parties(String cadena){
            int largo =100;
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
        public static String almacen(String cadena){
            int largo =25;
            //String cadena="CD Peralillo";
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
        public static String shipToName(String cadena){
            int largo =50;
           
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
