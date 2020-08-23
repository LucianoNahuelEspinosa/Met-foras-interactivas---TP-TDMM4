/*

 Desarrollado por: Espinosa, Luciano Nahuel.
 Diseñado por: Chazarreta, Joaquin - Di Loreto Lautaro - Malanchino, Facundo - Villareal, Andrea Belen.
 Agosto 2020.
 
 */

import fisica.*;
FWorld mundo;

Acoso acoso;
Alienacion alienacion;
Desarraigo desarraigo;
Desigualdad desigualdad;
Desinteres desinteres;
Enfermedad enfermedad;
Extranjerizacion extranjerizacion;
Individualismo individualismo;
Liderazgo liderazgo;
Mediacion mediacion;
Vanidad vanidad;
Xenofobia xenofobia;

int cantI = 3;
int cantJ = 4;
int tamGrillaAc = 430;
int tamGrillaAl = 180;
boolean [][] mouseSeleccionando = new boolean[cantI][cantJ];
float alphaMenu;

PImage fondo, menuImg, FV;

String estado = "menu";

void setup() {
  size(1280, 720);
  smooth();

  Fisica.init(this);
  mundo = new FWorld();

  acoso = new Acoso(75, 110);
  alienacion = new Alienacion(70, 82, 80);
  desarraigo = new Desarraigo(70, 80);
  desigualdad = new Desigualdad(85);
  desinteres = new Desinteres(60, 125);
  enfermedad = new Enfermedad(70);
  extranjerizacion = new Extranjerizacion(80, 75);
  individualismo = new Individualismo(65);
  liderazgo = new Liderazgo(90, 60);
  mediacion = new Mediacion(90, 110);
  vanidad = new Vanidad(80);
  xenofobia = new Xenofobia(65, 80, 5);

  fondo = loadImage("Fondo.jpg");
  menuImg = loadImage("menu.jpg");
  FV = loadImage("volver.png");
}

void draw() {
  background(fondo);

  if ( estado.equals("menu") ) {
    menu();
  } else if ( estado.equals("Xenofobia" ) ) {
    xenofobia.dibujar();
  } else if ( estado.equals("Liderazgo") ) {
    liderazgo.dibujar();
  } else if ( estado.equals("Acoso") ) {
    acoso.dibujar();
  } else if ( estado.equals("Desinteres") ) {
    desinteres.dibujar();
  } else if ( estado.equals("Individualismo") ) {
    individualismo.dibujar();
  } else if ( estado.equals("Mediacion") ) {
    mediacion.dibujar();
  } else if ( estado.equals("Desigualdad") ) {
    desigualdad.dibujar();
  } else if ( estado.equals("Alienacion") ) {
    alienacion.dibujar();
  } else if ( estado.equals("Desarraigo") ) {
    desarraigo.dibujar();
  } else if ( estado.equals("Extranjerizacion") ) {
    extranjerizacion.dibujar();
  } else if ( estado.equals("Vanidad") ) {
    vanidad.dibujar();
  } else {
    enfermedad.dibujar();
  }

  mundo.step();
  mundo.draw();

  println(frameRate);
}

void menu() {
  pushStyle();
  image(menuImg, 0, 0);
  for (int i = 0; i<cantI; i++) {
    for (int j = 0; j<cantJ; j++) {
      if ( mouseX > i*tamGrillaAc && mouseX < i*tamGrillaAc+tamGrillaAc && mouseY > j*tamGrillaAl && mouseY < j*tamGrillaAl+tamGrillaAl ) {
        mouseSeleccionando[i][j] = true;
      } else {
        mouseSeleccionando[i][j] = false;
      }

      if ( mouseSeleccionando[i][j] ) {
        alphaMenu = 75;
      } else {
        alphaMenu = 0;
      }

      fill(225, alphaMenu);
      rect(i*tamGrillaAc, j*tamGrillaAl, tamGrillaAc, tamGrillaAl);
    }
  }
  popStyle();
}

void mouseClicked() {
  for ( int i=0; i<cantI; i++) {
    for ( int j=0; j<cantJ; j++) {
      if ( mouseX > i*tamGrillaAc && mouseX < i*tamGrillaAc+tamGrillaAc && mouseY > j*tamGrillaAl && mouseY < j*tamGrillaAl+tamGrillaAl && estado.equals("menu") ) {

        if ( i == 0 && j == 0 ) {
          estado = "Acoso";
        }

        if ( i == 1 && j == 0 ) {
          estado = "Alienacion";
        }

        if ( i == 2 && j == 0 ) {
          estado = "Desarraigo";
        }

        if ( i == 0 && j == 1 ) {
          estado = "Desigualdad";
        }

        if ( i == 1 && j == 1 ) {
          estado = "Desinteres";
        }

        if ( i == 2 && j == 1 ) {
          estado = "Enfermedad";
        }

        if ( i == 0 && j == 2 ) {
          estado = "Extranjerizacion";
        }

        if ( i == 1 && j == 2 ) {
          estado = "Individualismo";
        }

        if ( i == 2 && j == 2 ) {
          estado = "Liderazgo";
        }

        if ( i == 0 && j == 3 ) {
          estado = "Mediacion";
        }

        if ( i == 1 && j == 3 ) {
          estado = "Vanidad";
        }

        if ( i == 2 && j == 3 ) {
          estado = "Xenofobia";
        }
      }
    }
  }

  xenofobia.clicVolver();
  liderazgo.clicVolver();
  acoso.clicVolver();
  desinteres.clicVolver();
  individualismo.clicVolver();
  mediacion.clicVolver();
  desigualdad.clicVolver();
  alienacion.clicVolver();
  extranjerizacion.clicVolver();
  vanidad.clicVolver();
  desarraigo.clicVolver();
  enfermedad.clicVolver();
}

void mouseMoved() {
  if ( estado.equals("Individualismo") ) {
    individualismo.libertadDelRebelde();
  }
  if ( estado.equals("Liderazgo") ) {
    liderazgo.lidera();
  }
  if ( estado.equals("Desarraigo") ) {
    desarraigo.estaMoviendo();
  }
}
