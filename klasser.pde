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
  Kraft rotate(Punkt rP, float v){
    return new Kraft((x-rP.x)*cos(v) - (y-rP.y)*sin(v)+rP.x, (x-rP.x)*sin(v) + (y-rP.y)*cos(v)+rP.y, p);
  }
}

//en punkt class til math :)
class Punkt {
  float x;
  float y;
  Punkt(float x, float y) {
    this.x = x;
    this.y = y;
  }
  Punkt rotate(Punkt p, float v) {
    return new Punkt((x-p.x)*cos(v) - (y-p.y)*sin(v)+p.x, (x-p.x)*sin(v) + (y-p.y)*cos(v)+p.y);
  }
  void rotateFull(Punkt p, float v){
    x = (x-p.x)*cos(v) - (y-p.y)*sin(v)+p.x;
    y = (x-p.x)*sin(v) + (y-p.y)*cos(v)+p.y;
  }
}

//Linje class til extreme math.
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
  Linje rotate(Punkt p, float v){
    return new Linje(p1.rotate(p, v), p2.rotate(p, v));
  }
  float længdeX(){
    return p2.x-p1.x;
  }
  float længdeY(){
    return p2.y-p1.y;
  }
  float længde(){
    return sqrt(pow(længdeX(), 2)+pow(længdeY(), 2));
  }
  float a(){
    return længdeY()/længdeX();
  }
  float b(){
    return p1.y-a()*p1.x;
  }
}

//Skæringspunkt mellem 2 linjer
Punkt skæringspunkt(Linje l1, Linje l2) {
  float x;
  float y;
  //check om der er lodrette linjer
  if (l1.p2.x != l1.p1.x && l2.p2.x != l2.p1.x) {
    float a1 = l1.a();
    float a2 = l2.a();
    float b1 = l1.b();
    float b2 = l2.b();
    //regn x og y ud på skæringspunkt
    x = -((b1-b2)/(a1-a2));
    y = a1*x+b1;
  } else { //hvis der er lodrette linjer
    float a;
    float b;
    //check om det er linje 1 der er lodret
    if (l1.p2.x == l1.p1.x) {
      x = l1.p2.x;
      a = l2.a();
      b = l2.b();
    } else { //hvis det er linje 2
      x = l2.p2.x;
      a = l1.a();
      b = l1.b();
    }
    //regn y ud.
    y = a*x+b;
  }
  return new Punkt(x, y);
}

//Legeme class til planeter/måner/whatever der skal have tyngdekraft
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
