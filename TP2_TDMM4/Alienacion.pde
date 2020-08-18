class Alienacion {

  int tamCir, tamCu, tamTri;
  float xJ, yJ;
  boolean sePuedeMover;

  int index;
  PImage [] formas = new PImage[3];

  PImage cir, cua, tri;

  float xC, yC, xT, yT, xCir, yCir, dir1, dir2, dir3, vel;
  float easing = 0.05;

  float vX, vY, vTam;

  Alienacion(int tCir, int tCua, int tTri) {
    xJ = 150;
    yJ = height/2;

    tamCir = tCir;
    tamCu = tCua;
    tamTri = tTri;

    formas[0] = loadImage("CirR.png");
    formas[1] = loadImage("CuaR.png");
    formas[2] = loadImage("TriR.png");

    cir = loadImage("CirA.png");
    cua = loadImage("CuaA.png");
    tri = loadImage("TriA.png");

    xC = width/2;
    yC = 200;
    xT = width/2;
    yT = height/2;
    xCir = width/2;
    yCir = height-200;

    vel = 2;

    vX = 25;
    vY = 25;
    vTam = 25;
  }

  void dibujar() {
    pasajeCuadrado();
    pasajeTriangulo();
    pasajeCirculo();
    circulo();
    volverMenu();

    if ( dist(xJ, yJ, xC, yC) < tamCir+tamCir/2 ) {
      index = 1;
    } else if ( dist(xJ, yJ, xT, yT) < tamCir+tamCir/2 ) {
      index = 2;
    } else if ( dist(xJ, yJ, xCir, yCir) < tamCir+tamCir/2 ) {
      index = 0;
    }
  }

  void circulo() {
    pushStyle();
    imageMode(CENTER);
    moverJugador();
    if ( sePuedeMover ) {
      xJ = mouseX;
      yJ = mouseY;
    }
    formas[index].resize(tamCir, tamCir);
    image(formas[index], xJ, yJ);
    popStyle();
  }

  void moverJugador() {
    if ( mouseX >= xJ && mouseX <= xJ + tamCir && mouseY >= yJ && mouseY <= yJ + tamCir ) {
      sePuedeMover = true;
    }
  }

  void pasajeCuadrado() {
    dir1 += radians(random(-10, 10));

    float dx = vel * cos( dir1 );
    float dy = vel * sin( dir1 );

    xC = xC + dx;
    yC = yC + dy;

    //espacio toroidal
    xC = ( xC>width ? xC-width : xC );
    xC = ( xC<0 ? xC+width : xC );
    yC = ( yC>height ? yC-height : yC );
    yC = ( yC<0 ? yC+height : yC );

    pushStyle();
    imageMode(CENTER);
    cua.resize(tamCu, tamCu);
    image(cua, xC, yC);
    image(cua, xC-150, yC);
    popStyle();
  }

  void pasajeTriangulo() {
    dir2 += radians(random(-10, 10));

    float dx = vel * cos( dir2 );
    float dy = vel * sin( dir2 );

    xT = xT + dx;
    yT = yT + dy;

    xT = ( xT>width ? xT-width : xT );
    xT = ( xT<0 ? xT+width : xT );
    yT = ( yT>height ? yT-height : yT );
    yT = ( yT<0 ? yT+height : yT );

    pushStyle();
    imageMode(CENTER);
    tri.resize(tamTri, tamTri);
    image(tri, xT, yT);
    image(tri, xT-150, yT);
    popStyle();
  }

  void pasajeCirculo() {
    dir3 += radians(random(-10, 10));

    float dx = vel * cos( dir3 );
    float dy = vel * sin( dir3 );

    xCir = xCir + dx;
    yCir = yCir + dy;

    xCir = ( xCir>width ? xCir-width : xCir );
    xCir = ( xCir<0 ? xCir+width : xCir );
    yCir = ( yCir>height ? yCir-height : yCir );
    yCir = ( yCir<0 ? yCir+height : yCir );

    pushStyle();
    imageMode(CENTER);
    cir.resize(tamCir, tamCir);
    image(cir, xCir, yCir);
    image(cir, xCir-150, yCir);
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
      index = 0;
      sePuedeMover = false;
      xJ = 150;
      yJ = height/2;
      xC = width/2;
      yC = 200;
      xT = width/2;
      yT = height/2;
      xCir = width/2;
      yCir = height-200;

      estado = "menu";
    }
  }
}
