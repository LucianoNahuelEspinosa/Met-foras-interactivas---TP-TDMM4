//Fisica
String darNombre( FBody cuerpo ) {
  String nombre = "nada";

  if ( cuerpo != null ) {
    String esteNombre = cuerpo.getName();
    if ( esteNombre != null ) {
      nombre = esteNombre;
    }
  }

  return nombre;
}
