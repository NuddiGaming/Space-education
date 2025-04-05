//vores kraft class
class Kraft {
  float x;
  float y;
  Punkt p;
  Kraft(float x, float y, Punkt p) {
    this.x = x;
    this.y = y;
    this.p = p;
  }
  //størrelsen/længden af kraften
  float størrelse() {
    return sqrt(pow(x, 2)+pow(y, 2));
  }
}

class Punkt {
  float x;
  float y;
  Punkt(float x, float y) {
    this.x = x;
    this.y = y;
  }
  Punkt rotate(Punkt p, float v) {
    return new Punkt((x-p.x)*cos(v) - (y-p.y)*sin(v)+p.x, (x-p.x)*sin(v) + (y-p.y)*cos(v)+p.x);
  }
}

class Linje {
  Punkt p1;
  Punkt p2;
  Linje(Punkt p1, Punkt p2) {
    this.p1 = p1;
    this.p2 = p2;
  }
  void tegn(){
    line(p1.x+raket.rotationspunkt.x, p1.y+raket.rotationspunkt.y, p2.x+raket.rotationspunkt.x, p2.y+raket.rotationspunkt.y);
  }
  float længdeX(){
    return p2.x-p1.x;
  }
  float længdeY(){
    return p2.y-p1.y;
  }
  float a(){
    return længdeY()/længdeX();
  }
  float b(){
    return p1.y-a()*p1.x;
  }
}

Punkt skæringspunkt(Linje l1, Linje l2) {
  float x;
  float y;
  if (l1.p2.x != l1.p1.x && l2.p2.x != l2.p1.x) {
    float a1 = l1.a();
    float a2 = l2.a();
    float b1 = l1.b();
    float b2 = l2.b();
    x = -((b1-b2)/(a1-a2));
    y = a1*x+b1;
  } else {
    float a;
    float b;
    if (l1.p2.x == l1.p1.x) {
      x = l1.p2.x;
      a = l2.a();
      b = l2.b();
    } else {
      x = l2.p2.x;
      a = l1.a();
      b = l1.b();
    }
    y = a*x+b;
  }
  return new Punkt(x, y);
}

class Legeme {
  float x;
  float y;
  float radius;
  float masse;
  color farve;
  Legeme(float x, float y, float radius, float masse, color farve) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.masse = masse;
    this.farve = farve;
    legemer.add(this);
  }
  void tegn() {
    fill(farve);
    circle(x-camX, y-camY, radius*2);
  }
}
