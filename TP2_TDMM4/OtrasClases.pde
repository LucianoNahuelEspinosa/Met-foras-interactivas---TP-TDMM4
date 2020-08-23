class Triangulo {

  float tx, ty, tx2, ty2, tx3, ty3;

  Triangulo(float x, float y, float x2, float y2, float x3, float y3) {
    tx = x; 
    ty = y; 
    tx2 = x2; 
    ty2 = y2; 
    tx3 = x3; 
    ty3 = y3;
  }

  void dibujar(float x, float y, float ang) {
    pushMatrix();
    translate(x, y);
    rotate(radians(ang));
    triangle( -tx, +ty, tx2, -ty2, +tx3, +ty3);
    popMatrix();
  }
}

class Imagen {

  PImage img; 

  Imagen(PImage _img) {
    img = _img;
  }

  void dibujar(float x, float y, float ang) {
    pushMatrix();
    translate(x, y);
    rotate(ang);
    pushStyle();
    imageMode(CENTER);
    image(img, 0, 0);
    popStyle();
    popMatrix();
  }
}
