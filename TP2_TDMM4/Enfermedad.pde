class Enfermedad {

  float xJ, yJ;
  PImage cir;
  int t;

  int cantI = 2;
  PImage [] c = new PImage[cantI];
  PImage [] tr = new PImage[cantI];
  float [] xC = new float[cantI];
  float [] yC = new float[cantI];
  float [] xT = new float[cantI];
  float [] yT = new float[cantI];

  int [] iC = new int[cantI];
  int [] iT = new int[cantI];
  boolean [] estaContagiadoC = new boolean[cantI];
  boolean [] estaContagiadoT = new boolean[cantI];
  float [] timeC = new float[cantI];
  float [] timeT = new float[cantI];

  boolean [] volverC = new boolean[cantI];
  boolean [] volverT = new boolean[cantI];
  float [] xCI = new float[cantI];
  float [] xTI = new float[cantI];
  float [] velC = new float[cantI];
  float [] velT = new float[cantI];

  int [] numCC = new int[cantI];
  int [] numCT = new int[cantI];

  float vX, vY, vTam;

  Enfermedad(int tam) {
    t = tam;

    cir = loadImage("CirR.png");
    c[0] = loadImage("CuaA.png");
    c[1] = loadImage("CuaR.png");
    tr[0] = loadImage("TriC.png");
    tr[1] = loadImage("TriR.png");

    xC[0] = 400;
    yC[0] = 200;
    xC[1] = width-200;
    yC[1] = height-200;
    xT[0] = width/2;
    yT[0] = height/2;
    xT[1] = 800;
    yT[1] = height/2-300;

    for ( int i = 0; i<cantI; i++ ) {
      iC[i] = 0;
      iT[i] = 0;
      estaContagiadoC[i] = false;
      timeC[i] = 0;
      estaContagiadoT[i] = false;
      timeT[i] = 0;
      volverC[i] = false;
      volverT[i] = false;
      xCI[i] = xC[i];
      xTI[i] = xT[i];
      velC[i] = 2;
      velT[i] = velC[i];
      numCC[i] = 255;
      numCT[i] = 255;
    }

    vX = 25;
    vY = 25;
    vTam = 25;
  }

  void dibujar() {
    cuadrados(50);
    triangulos(40);
    enfermo();
    volverMenu();

    for ( int i = 0; i<cantI; i++ ) {
      if ( dist(xJ, yJ, xC[i], yC[i]) < t ) {
        estaContagiadoC[i] = true;
        timeC[i] = 0;
        if ( frameCount % 5 == 0 ) {
          if ( numCC[i] > 0 ) {
            numCC[i] -= 3;
          }
          if ( velC[i] > 0.3 ) {
            velC[i] -= 0.03;
          } else {
            velC[i] = 0;
          }
        }
      }
      if ( dist(xJ, yJ, xT[i], yT[i]) < t ) {
        estaContagiadoT[i] = true;
        timeT[i] = 0;
        if ( frameCount % 5 == 0 ) {
          if ( numCT[i] > 0 ) {
            numCT[i] -= 3;
          }
          if ( velT[i] > 0.3 ) {
            velT[i] -= 0.03;
          } else {
            velT[i] = 0;
          }
        }
      }
    }

    tiempo(5);
  }

  void enfermo() {
    xJ = mouseX;
    yJ = mouseY;

    pushStyle();
    imageMode(CENTER);
    tint(210);
    cir.resize(t, t);
    image(cir, xJ, yJ);
    popStyle();
  }

  void cuadrados(float cantRecorrido) {
    pushStyle();
    imageMode(CENTER);
    for ( int i = 0; i<cantI; i++ ) {

      if ( volverC[i] ) {
        xC[i] += velC[i];
        if ( xC[i] > width-cantRecorrido ) {
          volverC[i] = false;
        }
      } else {
        xC[i] -= velC[i];
        if ( xC[i] < cantRecorrido ) {
          volverC[i] = true;
        }
      }

      c[i].resize(t, t);
      tint(numCC[0]);
      image(c[iC[0]], xC[0], yC[0]);
      tint(numCC[1]);
      image(c[iC[1]], xC[1], yC[1]);
    }
    popStyle();
  }

  void triangulos(float cantRecorrido) {
    pushStyle();
    imageMode(CENTER);
    for ( int i = 0; i<cantI; i++ ) {
      if ( volverT[i] ) {
        xT[i] -= velT[i];
        if ( xT[i] < cantRecorrido ) {
          volverT[i] = false;
        }
      } else {
        xT[i] += velT[i];
        if ( xT[i] > width-cantRecorrido ) {
          volverT[i] = true;
        }
      }

      tr[i].resize(t, t);
      tint(numCT[0]);
      image(tr[iT[0]], xT[0], yT[0]);
      tint(numCT[1]);
      image(tr[iT[1]], xT[1], yT[1]);
    }
    popStyle();
  }

  void tiempo(float maxTime) {
    for ( int i = 0; i<cantI; i++ ) {
      if ( estaContagiadoC[i] ) {
        if ( frameCount % 60 == 0 ) {
          timeC[i] ++;
          if ( timeC[i] > maxTime ) {
            if ( velC[i] < 2 ) {
              velC[i] += 0.3;
            } else {
              velC[i] = 2;
            }

            if ( numCC[i] < 230 ) {
              numCC[i] += 20;
            } else {
              numCC[i] = 255;
            }

            if ( numCC[i] == 255 && velC[i] == 2 ) {
              estaContagiadoC[i] = false;
              timeC[i] = 0;
            }
          }
        }
      }

      if ( estaContagiadoT[i] ) {
        if ( frameCount % 60 == 0 ) {
          timeT[i] ++;
          if ( timeT[i] > maxTime ) {
            if ( velT[i] < 2 ) {
              velT[i] += 0.3;
            } else {
              velT[i] = 2;
            }

            if ( numCT[i] < 230 ) {
              numCT[i] += 20;
            } else {
              numCT[i] = 255;
            }

            if ( numCT[i] == 255 && velT[i] == 2 ) {
              estaContagiadoT[i] = false;
              timeT[i] = 0;
            }
          }
        }
      }
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
      xC[0] = 400;
      yC[0] = 200;
      xC[1] = width-200;
      yC[1] = height-200;
      xT[0] = width/2;
      yT[0] = height/2;
      xT[1] = 800;
      yT[1] = height/2-300;

      for ( int i = 0; i<cantI; i++ ) {
        iC[i] = 0;
        iT[i] = 0;
        estaContagiadoC[i] = false;
        timeC[i] = 0;
        estaContagiadoT[i] = false;
        timeT[i] = 0;
        volverC[i] = false;
        volverT[i] = false;
        velC[i] = 2;
        velT[i] = velC[i];
        numCC[i] = 255;
        numCT[i] = 255;
      }
      estado = "menu";
    }
  }
}
