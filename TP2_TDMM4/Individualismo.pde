class Individualismo {

  float x, y, xI, yI, t, dir, vel;
  float x2, y2, x3, y3;

  boolean seLibre;
  float easing = 0.05;
  int time;

  int index;
  PImage [] cirs = new PImage[2];

  float vX, vY, vTam;

  Individualismo(float tam) {
    dir = radians( random( 360 ) );
    vel = 2;

    t = tam;

    cirs[0] = loadImage("CirR.png");
    cirs[1] = loadImage("CirA.png");

    vX = 25;
    vY = 25;
    vTam = 25;
  }

  void dibujar() {
    pushStyle();
    imageMode(CENTER);
    cirs[0].resize(int(t), int(t));
    cirs[1].resize(int(t), int(t));
    //fill(255, 0, 0);
    circulo();
    seguidores(75);
    if ( !seLibre ) {
      index = 0;

      float targetX2 = x3-225;
      float dx2 = targetX2 - xI;
      xI += dx2 * easing;

      float targetY2 = y3;
      float dy2 = targetY2 - yI;
      yI += dy2 * easing;
    } else {
      index = 1;
      //fill(0, 255, 0);
      /*float targetX2 = x + 75;
       float dx2 = targetX2 - xI;
       xI += dx2 * easing;
       
       float targetY2 = y;
       float dy2 = targetY2 - yI;
       yI += dy2 * easing;*/
      moverRebelde();
    }
    rebelde();
    popStyle();

    if ( frameCount % 60 == 0 ) {
      time ++;
      if ( time > 4 ) {
        seLibre = true;
      }
    }

    volverMenu();
  }

  void circulo() {
    x = mouseX;
    y = mouseY;
    //ellipse(x, y, t, t);
    image(cirs[0], x, y);
  }

  void seguidores(float distancia) {
    float targetX = x;
    float dx = targetX - x2;
    x2 += dx * easing;

    float targetY = y;
    float dy = targetY - y2;
    y2 += dy * easing;

    float targetX2 = x2;
    float dx2 = targetX2 - x3;
    x3 += dx2 * easing;

    float targetY2 = y2;
    float dy2 = targetY2 - y3;
    y3 += dy2 * easing;

    /*ellipse(x2-distancia, y2, t, t);
     ellipse(x3-distancia*2, y3, t, t);*/
    image(cirs[0], x2-distancia, y2);
    image(cirs[0], x3-distancia*2, y3);
  }

  void rebelde() {
    //ellipse( xI, yI, t, t );
    image(cirs[index], xI, yI);
  }

  void moverRebelde() {

    dir += radians(random(-10, 10));

    float dx = vel * cos( dir );
    float dy = vel * sin( dir );

    xI = xI + dx;
    yI = yI + dy;


    //espacio toroidal
    xI = ( xI>width ? xI-width : xI );
    xI = ( xI<0 ? xI+width : xI );
    yI = ( yI>height ? yI-height : yI );
    yI = ( yI<0 ? yI+height : yI );
  }

  void libertadDelRebelde() {
    time = 0;
    seLibre = false;
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
      seLibre = false;
      time = 0;
      estado = "menu";
    }
  }
}
