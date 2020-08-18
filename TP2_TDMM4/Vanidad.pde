class Vanidad {

  float xJ, yJ, t, tI, tF;
  boolean sePuedeMover;

  int cantTri = 3;
  /*Triangulo [] triangulos = new Triangulo[cantTri];
   float [] x = new float[cantTri]; 
   float [] y = new float[cantTri]; 
   float [] x2 = new float[cantTri]; 
   float [] y2 = new float[cantTri]; 
   float [] x3 = new float[cantTri]; 
   float [] y3 = new float[cantTri];*/
  float [] ang = new float[cantTri];

  PImage star, spec;
  Imagen [] trians = new Imagen[cantTri];

  float vX, vY, vTam;

  Vanidad(float tamC) {
    xJ = 100;
    yJ = height/2-200;

    t = tamC;
    tI = t;
    tF = 80;

    star = loadImage("CirR.png");
    spec = loadImage("TriA.png");

    for ( int i = 0; i<cantTri; i++ ) {
      /*x[i] = 40;
       y[i] = 40;
       x2[i] = 0;
       y2[i] = 55;
       x3[i] = 40;
       y3[i] = 40;
       
       triangulos[i] = new Triangulo(x[i], y[i], x2[i], y2[i], x3[i], y3[i]);*/

      trians[i] = new Imagen(spec);
    }

    ang[0] = 90;
    ang[1] = -90;
    ang[2] = -120;

    vX = 25;
    vY = 25;
    vTam = 25;
  }

  void dibujar() {
    famoso();
    losLosers();
    volverMenu();

    if ( estaEnZona() ) {
      if ( t < tI+tF ) {
        t ++;
      }

      for ( int i = 0; i<cantTri; i++ ) {
        float a = map(xJ, width/2-300, width/2+300, -30, 30);
        ang[i] = a;
      }
    } else {
      if ( t > tI ) {
        t --;
      }

      if ( ang[0] < 90 ) {
        ang[0] ++;
      }
      if ( ang[1] > -90 ) {
        ang[1] --;
      }
      if ( ang[2] > -120 ) {
        ang[2] --;
      }
    }
  }

  void famoso() {
    pushStyle();
    imageMode(CENTER);
    //fill(255, 0, 0);
    moverJugador();
    if ( sePuedeMover ) {
      xJ = mouseX;
      yJ = mouseY;
    }
    //ellipse(xJ, yJ, t, t);
    image(star, xJ, yJ, t, t);
    popStyle();
  }

  void losLosers() {
    pushStyle();
    fill(0, 255, 0);
    for ( int i = 0; i<cantTri; i++ ) {
      //triangulos[i].dibujar(i*200+(width/2-200), height-150, ang[i]);
      trians[i].dibujar(i*200+(width/2-200), height-150, radians(ang[i]));
    }
    popStyle();
  }

  boolean estaEnZona() {
    return xJ > width/2-300 && xJ < width/2+300;
  }

  void moverJugador() {
    if ( mouseX >= xJ && mouseX <= xJ + t && mouseY >= yJ && mouseY <= yJ + t ) {
      sePuedeMover = true;
    }
  }

  void volverMenu() {
    pushStyle();
    FV.resize(int(vTam), int(vTam));
    image(FV, vX, vY);
    popStyle();
  }

  boolean puedeVolver() {
    if ( mouseX >= vX && mouseX <= vX + vTam && mouseY >= vY && mouseY <= vY + vTam ) {
      return true;
    } else {
      return false;
    }
  }

  void clicVolver() {
    if (puedeVolver()) {
      sePuedeMover = false;
      ang[0] = 90;
      ang[1] = -90;
      ang[2] = -120;
      xJ = 100;
      yJ = height/2-200;
      estado = "menu";
    }
  }
}
