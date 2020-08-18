class Desarraigo {

  float xJ, yJ;
  int tJ, tC;

  int cantCu = 9;
  PImage [] img = new PImage[5];
  int [] index = new int[cantCu];
  float [] x = new float[cantCu];
  float [] y = new float[cantCu];
  float [] xI = new float[cantCu];
  float [] yI = new float[cantCu];
  float t;
  boolean [] sePuedeMover = new boolean[cantCu];
  boolean [] puedeVolver = new boolean[cantCu];
  boolean yaAgarroUno = false;
  boolean volver = false;
  float easing = 0.02;

  float vX, vY, vTam;

  Desarraigo(int tamJ, int tamC) {
    tJ = tamJ;
    tC = tamC;

    img[0] = loadImage("CuaA.png");
    img[1] = loadImage("Desa.png");
    img[2] = loadImage("Desa2.png");
    img[3] = loadImage("Desa3.png");
    img[4] = loadImage("CirR.png");

    x[0] = width/2-200;
    y[0] = height/2-200;
    x[1] = width/2-200+67;
    y[1] = height/2-200;
    x[2] = width/2-200+134;
    y[2] = height/2-200;

    x[3] = width/2-200;
    y[3] = height/2-200+67;
    x[4] = width/2-200+67;
    y[4] = height/2-200+67;
    x[5] = width/2-200+134;
    y[5] = height/2-200+67;

    x[6] = width/2-200;
    y[6] = height/2-200+134;
    x[7] = width/2-200+67;
    y[7] = height/2-200+134;
    x[8] = width/2-200+134;
    y[8] = height/2-200+134;

    for ( int i = 0; i<cantCu; i++ ) {
      xI[i] = x[i];
      yI[i] = y[i];
      sePuedeMover[i] = false;
      puedeVolver[i] = false;
    }

    vX = 25;
    vY = 25;
    vTam = 25;
  }

  void dibujar() {
    cuadrado();
    moverPieza();
    volverMenu();
  }

  void cuadrado() {
    pushStyle();
    //imageMode(CENTER);
    for ( int i = 0; i<cantCu; i++ ) {
      if ( sePuedeMover[i] ) {
        yaAgarroUno = true;
        tiempo(4, i);
        volverGrilla(i, puedeVolver[i], 50);
      } else {
        if ( !volver ) {
          x[i] ++;
          if ( x[i] > width-200 ) {
            volver = true;
          }
        } else {
          x[i] --;
          if ( x[i] < 200 ) {
            volver = false;
          }
        }
      }

      if ( !volver ) {
        xI[i] ++;
      } else {
        xI[i] --;
      }

      image(img[index[i]], x[i], y[i], tC, tC);
    }
    popStyle();
  }

  void moverPieza() {
    for ( int i = 0; i<cantCu; i++ ) { 
      if ( mouseX > x[i] && mouseX < x[i] + tC && mouseY > y[i] && mouseY < y[i] + tC && !yaAgarroUno ) {
        sePuedeMover[i] = true;
      }
    }
  }

  void estaMoviendo() {
    t = 0;
  }

  void tiempo(float max, int index) {
    if ( frameCount % 60 == 0 ) {
      t++;

      if (t > max) {
        puedeVolver[index] = true;
      }
    }
  }

  void volverGrilla(int index, boolean noVolvio, float distancia) {
    if ( noVolvio ) {
      float targetX = xI[index];
      float dx = targetX - x[index];
      x[index] += dx * easing;

      float targetY = yI[index];
      float dy = targetY - y[index];
      y[index] += dy * easing;

      if ( frameCount % 20 == 0 ) {
        if ( this.index[index] > 0 ) {
          this.index[index] --;
        }
      }

      println(dist(x[index], y[index], xI[index], yI[index]));

      if ( dist(x[index], y[index], xI[index], yI[index]) < distancia ) {
        t = 0;
        x[index] = xI[index];
        y[index] = yI[index];
        sePuedeMover[index] = false;
        puedeVolver[index] = false;
        yaAgarroUno = false;
        noVolvio = false;
      }
    } else {
      x[index] = mouseX-img[this.index[index]].width/2+10;
      y[index] = mouseY-img[this.index[index]].height/2+10;
      if ( frameCount % 60 == 0 ) {
        if ( this.index[index] < 4 ) {
          this.index[index] ++;
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
      x[0] = width/2-200;
      y[0] = height/2-200;
      x[1] = width/2-200+67;
      y[1] = height/2-200;
      x[2] = width/2-200+134;
      y[2] = height/2-200;

      x[3] = width/2-200;
      y[3] = height/2-200+67;
      x[4] = width/2-200+67;
      y[4] = height/2-200+67;
      x[5] = width/2-200+134;
      y[5] = height/2-200+67;

      x[6] = width/2-200;
      y[6] = height/2-200+134;
      x[7] = width/2-200+67;
      y[7] = height/2-200+134;
      x[8] = width/2-200+134;
      y[8] = height/2-200+134;

      for ( int i = 0; i<cantCu; i++ ) {
        xI[i] = x[i];
        yI[i] = y[i];
        sePuedeMover[i] = false;
        puedeVolver[i] = false;
        index[i] = 0;
      }
      t = 0;
      yaAgarroUno = false;
      estado = "menu";
    }
  }
}
