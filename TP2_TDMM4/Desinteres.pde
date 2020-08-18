class Desinteres {

  float xJ, yJ, tam, tamT;

  int cantTri = 4;
  /*Triangulo [] triangulos = new Triangulo[cantTri];
   float [] x = new float[cantTri]; 
   float [] y = new float[cantTri]; 
   float [] x2 = new float[cantTri]; 
   float [] y2 = new float[cantTri]; 
   float [] x3 = new float[cantTri]; 
   float [] y3 = new float[cantTri];*/
  float [] posX = new float[cantTri];
  float [] posY = new float[cantTri];
  float [] ang = new float[cantTri];

  PImage cir, tri;
  Imagen [] trians = new Imagen[cantTri];

  float vX, vY, vTam;

  Desinteres(float tamCir, float tamTri) {
    tam = tamCir;
    tamT = tamTri;

    cir = loadImage("CirR.png");
    tri = loadImage("TriA.png");

    for ( int i = 0; i<cantTri; i++ ) {
      /*x[i] = 40;
       y[i] = 40;
       x2[i] = 0;
       y2[i] = 55;
       x3[i] = 40;
       y3[i] = 40;*/

      ang[i] = 90;

      //triangulos[i] = new Triangulo(x[i], y[i], x2[i], y2[i], x3[i], y3[i]);

      trians[i] = new Imagen(tri);
    }

    posX[0] = 300;
    posY[0] = 300;

    posX[1] = width/2;
    posY[1] = height/2;

    posX[2] = width/2+200;
    posY[2] = height/2-200;

    posX[3] = width-300;
    posY[3] = height-300;

    vX = 25;
    vY = 25;
    vTam = 25;
  }

  void dibujar() {
    jugador();
    losTriangulos();
    volverMenu();

    for ( int i = 0; i<cantTri; i++ ) {
      if ( dist(xJ, yJ, posX[i], posY[i]) < tam*2 ) {
        if ( xJ > posX[i] && yJ < posY[i]+50 && yJ > posY[i]-50 ) {
          //ang[i] = -90;
          ang[i] = map(yJ, posY[i], posY[i]+70, -45, 10);
        } else if ( xJ < posX[i] && yJ < posY[i]+50 && yJ > posY[i]-50 ) {
          //ang[i] = 90;
          ang[i] = map(yJ, posY[i], posY[i]+70, 45, -10);
        } else if ( xJ > posX[i] && yJ > posY[i] ) {
          ang[i] = map(xJ, posX[i], posX[i]+70, 0, -45);
          println(xJ);
        } else if ( xJ < posX[i] && yJ > posY[i] ) {
          //ang[i] = 0;
          ang[i] = map(xJ, posX[i], posX[i]-70, 0, 45);
        } else if ( xJ < posX[i] && yJ < posY[i] ) {
          //ang[i] = 180;
          ang[i] = map(xJ, posX[i], posX[i]-70, 180, 45);
        } else if ( xJ > posX[i] && yJ < posY[i] ) {
          //ang[i] = 180;
          ang[i] = map(xJ, posX[i], posX[i]-70, 180, 120);
        }

        //ang[i] = atan2(posX[i]-xJ, posY[i]-yJ);
      }
    }
  }

  void jugador() {
    pushStyle();
    imageMode(CENTER);
    //fill(255, 0, 0);
    xJ = mouseX;
    yJ = mouseY;
    //ellipse(xJ, yJ, tam, tam);
    cir.resize(int(tam), int(tam));
    image(cir, xJ, yJ);
    popStyle();
  }

  void losTriangulos() {
    pushStyle();
    tri.resize(int(tamT), int(tamT));
    //fill(0, 255, 0);
    for ( int i = 0; i<cantTri; i++ ) {
      //ang[i] = map(mouseX, 0, width, -PI, PI);
      //triangulos[i].dibujar(posX[i], posY[i], ang[i]);
      trians[i].dibujar(posX[i], posY[i], radians(ang[i]));
    }
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
      for ( int i = 0; i<cantTri; i++ ) {
        ang[i] = 90;
      }
      estado = "menu";
    }
  }
}
