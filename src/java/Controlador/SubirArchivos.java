
package Controlador;


import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.io.FileUtils;
 
import org.primefaces.model.UploadedFile;





public class SubirArchivos {
    private static String archivoUrl="I:\\TX_WEBMH\\";
    public static void subirFichero(String ruta,String archivo) throws IOException 
{
   
   File miArchivo = new File(ruta, archivo);
   
   FileOutputStream zos = null;
   ByteArrayInputStream bais = null;
        try {
            zos = new FileOutputStream(miArchivo);
        
        //try {
            bais = new ByteArrayInputStream(FileUtils.readFileToByteArray(miArchivo));
            byte[] buffer = new byte[2048];
            int leido = 0;
            while (0 < (leido = bais.read(buffer))) {
                zos.write(buffer, 0, leido);
            }

        } catch (IOException ex) {
            Logger.getLogger(DspMhServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            
            bais.close();
            zos.close();
        }
        
   /*try {
    inputStream = new FileInputStream(new File(ruta+"\\"+archivo)); //archivo.getInputstream(); //leemos el fichero local
    // write the inputStream to a FileOutputStream
    outputStream = new FileOutputStream(new File("C:\\input\\"+archivo));
 
    int read = 0;
    byte[] bytes = new byte[1024];
 
    while ((read = inputStream.read(bytes)) != -1) {
       outputStream.write(bytes, 0, read);
    }
 
   } finally {
        if (inputStream != null) {
       inputStream.close();
    }
    if (outputStream != null) {
       outputStream.close();
    }
   }*/
} 
    
}