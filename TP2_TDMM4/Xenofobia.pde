class Xenofobia {

  int tamCir, tamCua, cantCua;
  float [] xC; 
  float [] yC;
  float [] xCI; 
  float [] yCI;
  float velCua, dir;
  float xCir, yCir;
  boolean sePuedeMover = true;
  boolean estadoSoldados, aProteger;
  boolean [] otraDir;
  float easing = 0.05;

  PImage circ, soldados;

  float vX, vY, vTam;

  Xenofobia(int cir, int cua, int cant) {
    tamCir = cir;
    tamCua = cua;
    cantCua = cant;
    velCua = 2;
    vX = 25;
    vY = 25;
    vTam = 25;
    xC = new float[cantCua];
    yC = new float[cantCua];
    xCI = new float[cantCua];
    yCI = new float[cantCua];
    otraDir = new boolean[cantCua];
    for (int i = 0; i < cantCua; i++) {
      xC[i] = random(20, 200);
      yC[i] = random(30, height-50);
      xCI[i] = xC[i];
      yCI[i] = yC[i];
      otraDir[i] = false;
    }

    circ = loadImage("CirR.png");
    soldados = loadImage("CuaA.png");
  }

  void dibujar() {
    circulo();
    cuadrados();
    moverCuads(estadoSoldados);
    volverMenu();

    for (int i = 0; i < cantCua; i++) {
      if ( mouseX < width/2-200 ) {
        estadoSoldados = true;
      } else if (  mouseX > width/2+200 ) {
        estadoSoldados = false;
      }
    }

    if ( mouseX < width/2-225 ) {
      sePuedeMover = false;
    } else {
      sePuedeMover = true;
    }
  }

  void circulo() {
    pushStyle();
    imageMode(CENTER);
    //fill(255, 0, 0);
    if (sePuedeMover) {
      xCir = mouseX;
    }
    yCir = mouseY;
    //ellipse(xCir, yCir, tamCir, tamCir);
    circ.resize(int(tamCir), int(tamCir));
    image(circ, xCir, yCir);
    popStyle();
  }

  void cuadrados() {
    pushStyle();
    //fill(0, 255, 0);
    for (int i = 0; i < cantCua; i++) {
      //rect(xC[i], yC[i], tamCua, tamCua);
      soldados.resize(int(tamCua), int(tamCua));
      image(soldados, xC[i], yC[i]);
    }

    /*stroke(255, 255, 0);
     strokeWeight(3);
     line(200, 0, 200, height);
     popStyle();*/
  }

  void moverCuads(boolean hayQueProteger) {
    if ( hayQueProteger ) {
      float targetX = 317;
      float dx = targetX - xC[0];
      xC[0] += dx * easing;

      float targetY = yCir-soldados.height-25;
      float dy = targetY - yC[0];
      yC[0] += dy * easing;

      float targetX2 = 317;
      float dx2 = targetX2 - xC[1];
      xC[1] += dx2 * easing;

      float targetY2 = yCir-soldados.height/2;
      float dy2 = targetY2 - yC[1];
      yC[1] += dy2 * easing;

      float targetX3 = 317;
      float dx3 = targetX3 - xC[2];
      xC[2] += dx3 * easing;

      float targetY3 = yCir+soldados.height/2-15;
      float dy3 = targetY3 - yC[2];
      yC[2] += dy3 * easing;

      /*xC[0] = 317;
       yC[0]= yCir-soldados.height-25;
       xC[1] = 317;
       yC[1]= yCir-soldados.height/2;
       xC[2] = 317;
       yC[2]= yCir+soldados.height/2-15;*/
    } else {
      for (int i = 0; i < cantCua-2; i++) {
        float targetX = xCI[i];
        float dx = targetX - xC[i];
        xC[i] += dx * easing;

        float targetY = yCI[i];
        float dy = targetY - yC[i];
        yC[i] += dy * easing;

        /*xC[i] = xCI[i];
         yC[i] = yCI[i];*/
      }
    }

    for (int i = 3; i < cantCua; i++) {
      if ( otraDir[i] ) {
        yC[i] -= velCua;
        yCI[i] -= velCua;
        if ( yC[i] < soldados.height/2 ) {
          otraDir[i] = false;
        }
      } else {
        yC[i] += velCua;
        yCI[i] += velCua;
        if ( yC[i] > height-soldados.height ) {
          otraDir[i] = true;
        }
      }
    }

    for (int i = 0; i < cantCua-2; i++) {
      if ( otraDir[i] ) {
        yCI[i] -= velCua;
        if ( yCI[i] < soldados.height ) {
          otraDir[i] = false;
        }
      } else {
        yCI[i] += velCua;
        if ( yCI[i] > height-soldados.height ) {
          otraDir[i] = true;
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
      for (int i = 0; i < cantCua; i++) {
        xC[i] = random(25, 200);
        yC[i] = random(30, height-50);
        xCI[i] = xC[i];
        yCI[i] = yC[i];
        otraDir[i] = false;
      }
      estado = "menu";
    }
  }
}
