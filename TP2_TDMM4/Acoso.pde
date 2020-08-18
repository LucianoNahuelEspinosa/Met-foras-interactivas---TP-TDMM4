class Acoso {

  float xVi, yVi, tamVi, tamVO;
  boolean sePuedeMover = false;
  boolean moverAcosadores, acosaron, vanAcosar;

  int cant = 3;
  float [] x = new float[cant];
  float [] y = new float[cant];
  float tamA;
  float easing = 0.005;
  float easing2 = 0.002;
  int t = 0;
  int t2 = 0;
  float velTam = 0.5;

  boolean seAgranda, yaAchico;

  PImage victima, acosadores;

  float vX, vY, vTam;

  Acoso(float tamv, float tama) {
    xVi = 200;
    yVi = height/2;
    tamVi = tamv;
    tamVO = tamVi;
    tamA = tama;

    x[0] = width/2-200;
    y[0] = height-tamA;
    x[1] = width-tamA;
    y[1] = height/2;
    x[2] = width/2+200;
    y[2] = tamA;

    victima = loadImage("CirR.png");
    acosadores = loadImage("CuaA.png");

    vX = 25;
    vY = 25;
    vTam = 25;
  }

  void dibujar() {
    victima();
    acosadores(moverAcosadores);
    volverMenu();

    if ( xVi > width/2-200 && !acosaron && sePuedeMover ) {
      moverAcosadores = true;
      vanAcosar = true;
    }

    for ( int i = 0; i<cant; i++) {
      if ( dist(xVi, yVi, x[i], y[i]) < tamVO+tamVO/2 && vanAcosar ) {

        float d = dist(xVi, yVi, x[i], y[i]);

        if ( !yaAchico ) {
          float tamMap = map(d, tamVO, 0, tamVO-30, 10);
          tamVi = tamMap;
        }

        if ( d < tamVO*2 ) {
          sePuedeMover = false;
          acosaron = true;
          tiempo();
        }
      } else {
        //tamVi = tamVO;
      }
    }

    if ( seAgranda ) {
      if ( frameCount % 60 == 0 ) {
        t2 ++;
      }
      if ( t2 > 2 ) {
        tamVi += velTam;
        if ( tamVi >= tamVO ) {
          seAgranda = false;
          yaAchico = false;
          t2 = 0;
        }
      }
    }
  }

  void victima() {
    pushStyle();
    imageMode(CENTER);
    //fill(255, 0, 0);
    moverVictima();
    if ( sePuedeMover ) {
      xVi = mouseX;
      yVi = mouseY;
    }
    image(victima, xVi, yVi, tamVi, tamVi);
    //ellipse(xVi, yVi, tamVi, tamVi);
    popStyle();
  }

  void moverVictima() {
    if ( mouseX >= xVi && mouseX <= xVi + tamVi && mouseY >= yVi && mouseY <= yVi + tamVi ) {
      sePuedeMover = true;
    }
  }

  void tiempo() {
    if ( frameCount % 60 == 0 ) {
      t++;

      if (t > 5) {
        yaAchico = true;
        moverAcosadores = false;
        vanAcosar = false;
        seAgranda = true;
        t = 0;
      }
    }
  }


  void acosadores(boolean seMueven) {
    for ( int i = 0; i<cant; i++) {
      if ( seMueven ) {
        float targetX = xVi;
        float dx = targetX - x[i];
        x[i] += dx * easing;

        float targetY = yVi;
        float dy = targetY - y[i];
        y[i] += dy * easing;

        /*float targetX2 = xVi;
         float dx2 = targetX2 - x2;
         x2 += dx2 * easing;
         
         float targetY2 = yVi;
         float dy2 = targetY2 - y2;
         y2 += dy2 * easing;
         
         float targetX3 = xVi;
         float dx3 = targetX3 - x3;
         x3 += dx3 * easing;
         
         float targetY3 = yVi;
         float dy3 = targetY3 - y3;
         y3 += dy3 * easing;*/
      } else {
        float targetX = width/2-200;
        float dx = targetX - x[0];
        x[0] += dx * easing2;

        float targetY = height-tamA;
        float dy = targetY - y[0];
        y[0] += dy * easing2;

        float targetX2 = width-tamA;
        float dx2 = targetX2 - x[1];
        x[1] += dx2 * easing2;

        float targetY2 = height/2;
        float dy2 = targetY2 - y[1];
        y[1] += dy2 * easing2;

        float targetX3 = width/2+200;
        float dx3 = targetX3 - x[2];
        x[2] += dx3 * easing2;

        float targetY3 = tamA;
        float dy3 = targetY3 - y[2];
        y[2] += dy3 * easing2;

        if ( x[0] < targetX+150 && x[1] > targetX2-tamA-10 && y[2] < targetY3+tamA/2 ) {
          acosaron = false;
        }
      }

      pushStyle();
      rectMode(CENTER);
      imageMode(CENTER);
      /*fill(0, 255, 0);
       rect(x, y, tamA, tamA);
       rect(x2, y2, tamA, tamA);
       rect(x3, y3, tamA, tamA);*/
      acosadores.resize(int(tamA), int(tamA));
      image(acosadores, x[i], y[i]);
      popStyle();
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
      xVi = 200;
      yVi = height/2;
      x[0] = width/2-200;
      y[0] = height-tamA;
      x[1] = width-tamA;
      y[1] = height/2;
      x[2] = width/2+200;
      y[2] = tamA;
      sePuedeMover = false;
      moverAcosadores = false; 
      acosaron = false; 
      vanAcosar = false;
      estado = "menu";
    }
  }
}
