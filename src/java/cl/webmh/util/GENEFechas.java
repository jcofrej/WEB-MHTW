package cl.webmh.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class GENEFechas
{
  private static final String DATE_FORMAT_MWEB = "dd/MM/yyyy";
  private static final String DATE_HOUR_FORMAT_MWEB = "dd/MM/yyyy HH:mm:ss";
  private static final String DATE_FORMAT_SEGA = "yyyy/MM/dd";
  private static final String DATE_HOUR_FORMAT_SEGA = "yyyy/MM/dd HH:mm:ss";
  private static final String HORA_INICIAL = "00:00:01";
  private static final String HORA_FINAL = "23:59:59";
  private static final String SEPARADOR_FECHA_HORA = " ";
  private static final String DATE_FORMAT_GIM = "yyyyMMdd";
  private static final String HORA_FORMAT_GIM = "kkmmss";

  public static boolean esFecha1MenorIgualFecha2(String fecha1, String fecha2)
  {
    if ((!GENEStrings.isVacio(fecha1)) && (!GENEStrings.isVacio(fecha2))) {
      SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy");
      try
      {
        Date date1 = formateador.parse(fecha1);
        Date date2 = formateador.parse(fecha2);
        return (date1.before(date2)) || (date1.equals(date2));
      } catch (ParseException e) {
        e.printStackTrace();
        return false;
      }
    }

    return false;
  }

  public static boolean esFechaCorrecta(String fecha)
  {
    if (!GENEStrings.isVacio(fecha)) {
      SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy");
      try {
        formateador.parse(fecha);

        String dia = fecha.substring(0, 2);
        String mes = fecha.substring(3, 5);
        String anno = fecha.substring(6, 10);

        Calendar calendar = Calendar.getInstance();
        calendar.clear();
        calendar.setLenient(false);
        calendar.set(Integer.parseInt(anno), Integer.parseInt(mes) - 1, Integer.parseInt(dia));
        calendar.getTime();

        return true;
      } catch (Exception e) {
        e.printStackTrace();
        return false;
      }
    }

    return false;
  }

  public static String toFechaMh(String fecha, boolean isFechaInicial)
  {
    String fechaMweb = "";
    if (!GENEStrings.isVacio(fecha)) {
      SimpleDateFormat formateadorMweb = new SimpleDateFormat("dd/MM/yyyy");
      SimpleDateFormat formateadorSega = new SimpleDateFormat("yyyy-MM-dd");
      try
      {
        Date date = formateadorMweb.parse(fecha);
        fechaMweb = formateadorSega.format(date);
        if (isFechaInicial)
          fechaMweb = fechaMweb + " 00:00:00";
        else
          fechaMweb = fechaMweb + " 23:59:59";
      }
      catch (ParseException e) {
        e.printStackTrace();
      }
    }
    return fechaMweb;
  }

  public static Date fromFechaManDate(String fechaString)
  {
    Date retorno = null;
    try
    {
      SimpleDateFormat formateador = new SimpleDateFormat("yyyy/MM/dd");
      retorno = formateador.parse(fechaString);
    } catch (Exception ex) {
      ex.printStackTrace();
    }

    return retorno;
  }

  public static Date fromFechaHoraSegaDate(String fechaHoraString)
  {
    Date retorno = null;
    try
    {
      SimpleDateFormat formateador = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
      retorno = formateador.parse(fechaHoraString);
    } catch (Exception ex) {
      ex.printStackTrace();
    }

    return retorno;
  }

  public static String fromFechaMhoWEBMh(String fechaString)
  {
    String retorno = "";

    if (!GENEStrings.isVacio(fechaString)) {
      try
      {
        SimpleDateFormat formateadorSega = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formateadorMWEB = new SimpleDateFormat("dd/MM/yyyy");
        retorno = formateadorMWEB.format(formateadorSega.parse(fechaString));
      } catch (Exception ex) {
        ex.printStackTrace();
      }

    }

    return retorno;
  }

  public static String fromFechaHoraMhtoWEBMh(String fechaHoraString)
  {
    String retorno = "";

    if (!GENEStrings.isVacio(fechaHoraString)) {
      try
      {
        SimpleDateFormat formateadorSega = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat formateadorMWEB = new SimpleDateFormat("dd/MM/yyyy");
        retorno = formateadorMWEB.format(formateadorSega.parse(fechaHoraString));
      } catch (Exception ex) {
        ex.printStackTrace();
      }

    }

    return retorno;
  }

  public static String fromFechaHoraSegatoFechaHoraMWEB(String fechaHoraString)
  {
    String retorno = "";

    if (!GENEStrings.isVacio(fechaHoraString)) {
      try
      {
        SimpleDateFormat formateadorSega = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        SimpleDateFormat formateadorMWEB = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        retorno = formateadorMWEB.format(formateadorSega.parse(fechaHoraString));
      } catch (Exception ex) {
        ex.printStackTrace();
      }

    }

    return retorno;
  }

  public static String toFechaGIM(Date fecha)
  {
    String retorno = "";

    if (fecha != null) {
      try
      {
        SimpleDateFormat formateador = new SimpleDateFormat("yyyyMMdd");
        retorno = formateador.format(fecha);
      } catch (Exception ex) {
        ex.printStackTrace();
      }

    }

    return retorno;
  }

  public static String toHoraGIM(Date fecha)
  {
    String retorno = "";

    if (fecha != null) {
      try
      {
        SimpleDateFormat formateador = new SimpleDateFormat("kkmmss");
        retorno = formateador.format(fecha);
      } catch (Exception ex) {
        ex.printStackTrace();
      }

    }

    return retorno;
  }

  public static String fromFechaMWEBToGIM(String fechaLiteral)
  {
    String retorno = "";

    if (!GENEStrings.isVacio(fechaLiteral)) {
      try
      {
        SimpleDateFormat parseadorMWEB = new SimpleDateFormat("dd/MM/yyyy");
        Date fecha = parseadorMWEB.parse(fechaLiteral);
        SimpleDateFormat formateadorGIM = new SimpleDateFormat("yyyyMMdd");
        retorno = formateadorGIM.format(fecha);
      }
      catch (Exception ex) {
        ex.printStackTrace();
      }

    }

    return retorno;
  }

  public static String toFechaMWEB(Date fecha)
  {
    String retorno = "";

    if (fecha != null) {
      try
      {
        SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy");
        retorno = formateador.format(fecha);
      } catch (Exception ex) {
        ex.printStackTrace();
      }

    }

    return retorno;
  }

  public static Date sumarDias(Date fecha, int numeroDias)
  {
    Calendar calendario = Calendar.getInstance();
    calendario.setTime(fecha);

    int diaDelAnyo = calendario.get(6);

    calendario.set(6, diaDelAnyo + numeroDias);

    return calendario.getTime();
  }
}
