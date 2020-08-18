class Extranjerizacion {

  float xJ, yJ, t;
  boolean sePuedeMover;

  float [] posXC = new float[3];
  float [] posYC = new float[3];
  float [] posXIC = new float[3];
  float [] posYIC = new float[3];
  float [] posXT = new float[3];
  float [] posYT = new float[3];
  float [] posXIT = new float[3];
  float [] posYIT = new float[3];
  boolean [] volverC = new boolean[3];
  boolean [] volverT = new boolean[3];

  int cantColores = 3;
  color [] colores = new color[cantColores];
  float alpha;

  int secuencia;
  PImage [] cir = new PImage[3];
  int tO;
  PImage cua, tri;

  float zonaX = 350;

  float vX, vY, vTam;

  Extranjerizacion(float tamC, int tamO) {
    xJ = 150;
    yJ = height/2;

    posXC[0] = width/2-200;
    posYC[0] = 100;
    posXC[1] = width/2-100;
    posYC[1] = height/2;
    posXC[2] = width/2-250;
    posYC[2] = height-100;
    posXT[0] = width/2+225;
    posYT[0] = 150;
    posXT[1] = width/2+100;
    posYT[1] = height/2-50;
    posXT[2] = width/2+175;
    posYT[2] = height-150;

    for ( int i = 0; i<3; i++ ) {
      posXIC[i] = posXC[i];
      posYIC[i] = posYC[i];
      posXIT[i] = posXT[i];
      posYIT[i] = posYT[i];
      volverC[i] = false;
      volverT[i] = false;
    }

    t = tamC;
    tO = tamO; 

    colores[0] = color(255, 0, 0);
    colores[1] = color(255, 255, 0);
    colores[2] = color(0, 255, 255);
    alpha = 10;

    cir[0] = loadImage("CirR.png");
    cir[1] = loadImage("CirA.png");
    cir[2] = loadImage("CirC.png");
    cua = loadImage("CuaA.png");
    tri = loadImage("TriC.png");

    vX = 25;
    vY = 25;
    vTam = 25;
  }

  void dibujar() {
    //zonas(zonaX, colores[0], colores[1], colores[2], alpha);
    circulo();
    objetos(50);
    volverMenu();

    if ( xJ < width/2-zonaX || xJ > width/2+zonaX ) {
      secuencia = 0;
    } else if ( xJ > width/2-zonaX && xJ < width/2 ) {
      secuencia = 1;
    } else {
      secuencia = 2;
    }
  }

  void circulo() {
    pushStyle();
    imageMode(CENTER);
    mover();
    if ( sePuedeMover ) {
      xJ = mouseX;
      yJ = mouseY;
    }
    /*if ( secuencia == 0 ) {
     fill(255, 0, 0);
     } else if ( secuencia == 1 ) {
     fill(0, 255, 0);
     } else {
     fill(0, 0, 255);
     }
     ellipse(xJ, yJ, t, t);*/
    cir[secuencia].resize(int(t), int(t));
    image(cir[secuencia], xJ, yJ);
    popStyle();
  }

  void mover() {
    if ( mouseX >= xJ && mouseX <= xJ + t && mouseY >= yJ && mouseY <= yJ + t ) {
      sePuedeMover = true;
    }
  }

  void objetos(float cantRecorrido) {
    pushStyle();
    imageMode(CENTER);
    cua.resize(tO, tO);
    tri.resize(tO, tO);

    for ( int i = 0; i<3; i++ ) {
      image(cua, posXC[i], posYC[i]);
      image(tri, posXT[i], posYT[i]);

      if ( volverC[i] ) {
        posYC[i] ++;
        if ( posYC[i] > height-cantRecorrido ) {
          volverC[i] = false;
        }
      } else {
        posYC[i] --;
        if ( posYC[i] < cantRecorrido ) {
          volverC[i] = true;
        }
      }

      if ( volverT[i] ) {
        posYT[i] --;
        if ( posYT[i] < cantRecorrido ) {
          volverT[i] = false;
        }
      } else {
        posYT[i] ++;
        if ( posYT[i] > height-cantRecorrido ) {
          volverT[i] = true;
        }
      }
    }
    popStyle();
  }

  void zonas(float x, color r, color g, color b, float a) {
    pushStyle();
    noStroke();

    fill(r, a);
    rect(0, 0, width/2-x, height);

    fill(g, a);
    rect(width/2-x, 0, x, height);

    fill(b, a);
    rect(width/2, 0, x, height);

    fill(r, a);
    rect(width/2+x, 0, width/2-x, height);

    popStyle();
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
      posXC[0] = width/2-200;
      posYC[0] = 100;
      posXC[1] = width/2-100;
      posYC[1] = height/2;
      posXC[2] = width/2-250;
      posYC[2] = height-100;
      posXT[0] = width/2+225;
      posYT[0] = 150;
      posXT[1] = width/2+100;
      posYT[1] = height/2-50;
      posXT[2] = width/2+175;
      posYT[2] = height-150;
      sePuedeMover = false;
      xJ = 150;
      yJ = height/2;
      estado = "menu";
    }
  }
}
