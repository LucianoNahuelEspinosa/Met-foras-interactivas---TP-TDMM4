class Liderazgo {

  int tamL, tamS;
  float xL, yL;
  boolean sePuedeMover = false;

  int cant = 3;
  float [] x = new float[cant];
  float [] y = new float[cant];
  boolean pri, seg, ter;
  boolean [] seguir = new boolean[cant];
  boolean [] enFila = new boolean[cant];
  int i1, i2, i3;

  boolean seguiendoLider;
  float easing = 0.03;

  int t;

  PImage lider, subditos;

  float vX, vY, vTam;

  Liderazgo(int tL, int tS) {
    tamL = tL;
    tamS = tS;
    xL = 200;
    yL = height/2;

    x[0] = 200;
    y[0] = tamS;
    x[1] = width/2;
    y[1] = height-tamS;
    x[2] = width-tamS;
    y[2] = height/2;

    lider = loadImage("CirR.png");
    subditos = loadImage("CirA.png");

    vX = 25;
    vY = 25;
    vTam = 25;
  }

  void dibujar() {
    lider();
    seguidores();
    if ( !seguiendoLider ) {
      volverPos();
    } else {
      for ( int i = 0; i<cant; i++ ) {
        if ( dist(xL, yL, x[i], y[i]) < tamL ) {
          if ( !pri && !enFila[i] ) {
            pri = true;
            seguir[i] = true;
            enFila[i] = true;
            i1 = i;
          } else {
            if ( !seg && !enFila[i] ) {
              seg = true;
              seguir[i] = true;
              enFila[i] = true;
              i2 = i;
            } else {
              if ( !ter && !enFila[i] ) {
                ter = true;
                seguir[i] = true;
                enFila[i] = true;
                i3 = i;
              }
            }
          }
        }
      }
      seguirJefe(60, i1, i2, i3);
    }

    if ( frameCount % 60 == 0 ) {
      t ++;

      if ( t > 4 ) {
        seguiendoLider = false;
        pri = false;
        seg = false;
        ter = false;
        for ( int i = 0; i<cant; i++ ) {
          seguir[i] = false;
          enFila[i] = false;
        }
      }
    }

    volverMenu();
  }

  void lider() {
    pushStyle();
    imageMode(CENTER);
    //fill(255, 0, 0);
    moverLider();
    if ( sePuedeMover ) {
      xL = mouseX;
      yL = mouseY;
    }
    //ellipse(xL, yL, tamL, tamL);
    lider.resize(tamL, tamL);
    image(lider, xL, yL);
    popStyle();
  }

  void moverLider() {
    if ( mouseX >= xL && mouseX <= xL + tamL && mouseY >= yL && mouseY <= yL + tamL ) {
      sePuedeMover = true;
    }
  }

  void seguirJefe(float distancia, int in, int in2, int in3) {
    if ( seguir[in] && pri ) {
      float targetX = xL - distancia*2;
      float dx = targetX - x[in];
      x[in] += dx * easing;

      float targetY = yL;
      float dy = targetY - y[in];
      y[in] += dy * easing;
    }

    if ( seguir[in2] && seg ) {
      float targetX = x[in] - distancia;
      float dx = targetX - x[in2];
      x[in2] += dx * easing;

      float targetY = y[in];
      float dy = targetY - y[in2];
      y[in2] += dy * easing;
    }

    if ( seguir[in3] && ter ) {
      float targetX = x[in2] - distancia;
      float dx = targetX - x[in3];
      x[in3] += dx * easing;

      float targetY = y[in2];
      float dy = targetY - y[in3];
      y[in3] += dy * easing;
    }
  }

  void volverPos() {
    float targetX = 200;
    float dx = targetX - x[0];
    x[0] += dx * easing;

    float targetY = tamS;
    float dy = targetY - y[0];
    y[0] += dy * easing;

    float targetX2 = width/2;
    float dx2 = targetX2 - x[1];
    x[1] += dx2 * easing;

    float targetY2 = height-tamS;
    float dy2 = targetY2 - y[1];
    y[1] += dy2 * easing;

    float targetX3 = width-tamS;
    float dx3 = targetX3 - x[2];
    x[2] += dx3 * easing;

    float targetY3 = height/2;
    float dy3 = targetY3 - y[2];
    y[2] += dy3 * easing;
  }

  void seguidores() {
    pushStyle();
    imageMode(CENTER);
    /*fill(0, 255, 0);
     ellipse(x-distancia, y, tamS, tamS);
     ellipse(x2-distancia-distancia/2, y2, tamS, tamS);
     ellipse(x3-distancia*2, y3, tamS, tamS);*/
    subditos.resize(tamS, tamS);
    for ( int i = 0; i<cant; i++ ) {
      image(subditos, x[i], y[i]);
    }
    popStyle();
  }

  void lidera() {
    if ( sePuedeMover ) {
      t = 0;
      seguiendoLider = true;
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
      xL = 200;
      yL = height/2;
      x[0] = 200;
      y[0] = tamS;
      x[1] = width/2;
      y[1] = height-tamS;
      x[2] = width-tamS;
      y[2] = height/2;
      pri = false;
      seg = false;
      ter = false;
      for ( int i = 0; i<cant; i++ ) {
        seguir[i] = false;
        enFila[i] = false;
      }
      sePuedeMover = false;
      seguiendoLider = false;
      estado = "menu";
    }
  }
}
