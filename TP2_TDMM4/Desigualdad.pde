class Desigualdad {

  float tam, tamCG;
  float x, y, xC, yC, xC2, yC2, xT, yT, xT2, yT2;
  int secuenciaC, secuenciaT;
  boolean seAlejoCu1, seAlejoCu2, seAlejoT1, seAlejoT2;
  boolean seCreoGrande, seCreoChico, seCreoMundoFisica;

  PImage cua, cir, tri, cir2;

  float vX, vY, vTam;

  Desigualdad(float t) {
    tam = t;
    tamCG = t*1.8;

    x = 200;
    y = height/2;

    xC = width/2-200;
    xC2 = width/2+200;
    yC = 150;
    yC2 = 150;

    xT = width/2-200;
    xT2 = width/2+200;
    yT = height-150;
    yT2 = height-150;

    secuenciaC = 1;
    secuenciaT = 1;

    cua = loadImage("CuaA.png");
    cir = loadImage("CirR.png");
    cir2 = loadImage("CirR.png");
    tri = loadImage("TriC.png");

    vX = 25;
    vY = 25;
    vTam = 25;
  }

  void dibujar() {
    if ( !seCreoMundoFisica ) {
      mundo.setEdges(200);
      mundo.setGravity(0, 0);
      seCreoMundoFisica = true;
    }

    cuadrados(2);
    triangulos(2);
    circulos();
    volverMenu();
  }

  void circulos() {
    if ( !seCreoGrande ) {
      FBox cirG = new FBox(tamCG, tamCG);
      cirG.setPosition(width/2+50, height/2);
      cirG.setStatic(true);
      cirG.setGrabbable(false);
      cirG.setDensity( 100000 );
      cir2.resize(int(tamCG), int(tamCG));
      cirG.attachImage(cir2);
      cirG.setName("Pesado");
      mundo.add(cirG);
      seCreoGrande = true;
    }

    if ( !seCreoChico ) {
      FBox cirC = new FBox(tam, tam);
      cirC.setPosition(x, y);
      cir.resize(int(tam), int(tam));
      cirC.attachImage(cir);
      cirC.setName("Jugador");
      mundo.add(cirC);
      seCreoChico = true;
    }

    pushStyle();
    imageMode(CENTER);
    /*fill(255, 0, 0);
     ellipse(x, y, tam, tam);*/
    /*cir.resize(int(tam), int(tam));
     image(cir, x, y);*/
    popStyle();
  }


  void contactStarted(FContact col) {

    FBody cuerpo1 = col.getBody1();
    FBody cuerpo2 = col.getBody2();

    if ( darNombre( cuerpo1 ).equals( "Pesado") && 
      darNombre( cuerpo2 ).equals( "Jugador") ) {
      //cuerpo2.setVelocity( 0 , -1000 );
      cuerpo2.addForce( 0, -100000 );
    }
    if (darNombre( cuerpo2 ).equals("Pesado") && 
      darNombre( cuerpo1 ).equals("Jugador")) {
      //cuerpo1.setVelocity( 0 , -1000 );
      cuerpo1.addForce( 0, -100000 );
    }
  }

  void cuadrados(float speed) {
    if ( secuenciaC == 1 ) {
      if ( !seAlejoCu1 ) {
        xC2 += speed;
        if ( xC2 > width/2+100 ) {
          seAlejoCu1 = true;
        }
      } else {
        if ( xC2 > width/2+tam/2-12 ) {
          xC2 -= speed-speed/2;
        } else {
          seAlejoCu1 = false;
          secuenciaC = 2;
        }
      }
    }

    if ( secuenciaC == 2 ) {
      if ( !seAlejoCu2 ) {
        xC -= speed;
        if ( xC < width/2-100 ) {
          seAlejoCu2 = true;
        }
      } else {
        if ( xC < width/2-tam/2+12 ) {
          xC += speed-speed/2;
        } else {
          seAlejoCu2 = false;
          secuenciaC = 1;
        }
      }
    }

    pushStyle();
    imageMode(CENTER);
    /*fill(0, 255, 0);
     ellipse(xC, yC, tam, tam);
     ellipse(xC, yC2, tam, tam);*/
    cua.resize(int(tam), int(tam));
    image(cua, xC, yC);
    image(cua, xC2, yC2);
    popStyle();
  }

  void triangulos(float speed) {
    if ( secuenciaT == 1 ) {
      if ( !seAlejoT1 ) {
        xT2 += speed;
        if ( xT2 > width/2+100 ) {
          seAlejoT1 = true;
        }
      } else {
        if ( xT2 > width/2+tam/2-12 ) {
          xT2 -= speed-speed/2;
        } else {
          seAlejoT1 = false;
          secuenciaT = 2;
        }
      }
    }

    if ( secuenciaT == 2 ) {
      if ( !seAlejoT2 ) {
        xT -= speed;
        if ( xT < width/2-100 ) {
          seAlejoT2 = true;
        }
      } else {
        if ( xT < width/2-tam/2+12 ) {
          xT += speed-speed/2;
        } else {
          seAlejoT2 = false;
          secuenciaT = 1;
        }
      }
    }

    pushStyle();
    imageMode(CENTER);
    /*fill(0, 255, 0);
     ellipse(xC, yC, tam, tam);
     ellipse(xC, yC2, tam, tam);*/
    tri.resize(int(tam), int(tam));
    image(tri, xT, yT);
    image(tri, xT2, yT2);
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
      mundo.clear();
      seCreoGrande = false;
      seCreoChico = false;
      seCreoMundoFisica = false;
      x = 200;
      y = height/2;
      xC = width/2-200;
      xC2 = width/2+200;
      yC = 150;
      yC2 = 150;
      xT = width/2-200;
      xT2 = width/2+200;
      yT = height-150;
      yT2 = height-150;
      secuenciaC = 1;
      secuenciaT = 1;
      seAlejoCu1 = false;
      seAlejoCu2 = false;
      seAlejoT1 = false;
      seAlejoT2 = false;

      estado = "menu";
    }
  }
}
