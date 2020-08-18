class Mediacion {

  float tamCi, tamCu;
  float x, y, x2, y2, targetXC1, targetXC2;
  boolean seAlejo1, seAlejo2;
  int secuencia;

  PImage cir, cuads;

  float vX, vY, vTam;

  Mediacion(float tCir, float tCua) {
    tamCi = tCir;
    tamCu = tCua;

    x = width/2-200;
    x2 = width/2+200;
    y = height/2;
    y2 = height/2;

    targetXC1 = width/2-200;
    targetXC2 = width/2+200;

    cir = loadImage("CirR.png");
    cuads = loadImage("CuaA.png");

    vX = 25;
    vY = 25;
    vTam = 25;
  }

  void dibujar() {
    circulo();
    cuadrados();
    volverMenu();

    if ( dist(mouseX, mouseY, width/2, height/2) < tamCi ) {
      if ( x > targetXC1 ) {
        x --;
      }
      if ( x2 < targetXC2 ) {
        x2 ++;
      }
      secuencia = 0;
    } else {
      if ( dist(x, y, x2, y2) > tamCu-20 && secuencia == 0 ) {
        x += 1.5;
        x2 -= 1.5;
      } else if ( secuencia == 0 ) {
        secuencia = 1;
      }

      if ( secuencia == 1 ) {
        if ( !seAlejo1 ) {
          x2 += 2;
          if ( x2 > width/2+100 ) {
            seAlejo1 = true;
          }
        } else {
          if ( x2 > width/2+tamCu/2-12 ) {
            x2 -= 1.5;
          } else {
            seAlejo1 = false;
            secuencia = 2;
          }
        }
      }

      if ( secuencia == 2 ) {
        if ( !seAlejo2 ) {
          x -= 2;
          if ( x < width/2-100 ) {
            seAlejo2 = true;
          }
        } else {
          if ( x < width/2-tamCu/2+12 ) {
            x += 1.5;
          } else {
            seAlejo2 = false;
            secuencia = 1;
          }
        }
      }
    }
  }

  void circulo() {
    pushStyle();
    imageMode(CENTER);
    /*fill(255, 0, 0);
     ellipse(mouseX, mouseY, tamCi, tamCi);*/
    cir.resize(int(tamCi), int(tamCi));
    image(cir, mouseX, mouseY);
    popStyle();
  }

  void cuadrados() {
    pushStyle();
    rectMode(CENTER);
    imageMode(CENTER);
    /*fill(0, 255, 0);
     rect(x, y, tamCu, tamCu);
     rect(x2, y2, tamCu, tamCu);*/
    cuads.resize(int(tamCu), int(tamCu));
    image(cuads, x, y);
    image(cuads, x2, y2);
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
      x = width/2-200;
      x2 = width/2+200;
      y = height/2;
      y2 = height/2;
      seAlejo1 = false;
      seAlejo2 = false;
      secuencia = 0;
      estado = "menu";
    }
  }
}
