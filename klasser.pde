//vores kraft class
class Kraft {
  double x;
  double y;
  Punkt p;
  Kraft(double x, double y, Punkt p) {
    this.x = x;
    this.y = y;
    this.p = p;
  }
  //størrelsen/længden af kraften
  double størrelse() {
    return Math.sqrt(Math.pow(x, 2)+Math.pow(y, 2));
  }
  Kraft rotate(Punkt rP, float v){
    return new Kraft((x-rP.x)*cos(v) - (y-rP.y)*sin(v)+rP.x, (x-rP.x)*sin(v) + (y-rP.y)*cos(v)+rP.y, p);
  }
}

//en punkt class til math :)
class Punkt {
  double x;
  double y;
  Punkt(double x, double y) {
    this.x = x;
    this.y = y;
  }
  Punkt rotate(Punkt p, double v) {
    return new Punkt((x-p.x)*Math.cos(v) - (y-p.y)*Math.sin(v)+p.x, (x-p.x)*Math.sin(v) + (y-p.y)*Math.cos(v)+p.y);
  }
  void rotateFull(Punkt p, double v){
    x = (x-p.x)*Math.cos(v) - (y-p.y)*Math.sin(v)+p.x;
    y = (x-p.x)*Math.sin(v) + (y-p.y)*Math.cos(v)+p.y;
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
  Linje rotate(Punkt p, double v){
    return new Linje(p1.rotate(p, v), p2.rotate(p, v));
  }
  double længdeX(){
    return p2.x-p1.x;
  }
  double længdeY(){
    return p2.y-p1.y;
  }
  double længde(){
    return Math.sqrt(Math.pow(længdeX(), 2)+Math.pow(længdeY(), 2));
  }
  double a(){
    return længdeY()/længdeX();
  }
  double b(){
    return p1.y-a()*p1.x;
  }
}

//Skæringspunkt mellem 2 linjer
Punkt skæringspunkt(Linje l1, Linje l2) {
  double x;
  double y;
  //check om der er lodrette linjer
  if (l1.p2.x != l1.p1.x && l2.p2.x != l2.p1.x) {
    double a1 = l1.a();
    double a2 = l2.a();
    double b1 = l1.b();
    double b2 = l2.b();
    //regn x og y ud på skæringspunkt
    x = -((b1-b2)/(a1-a2));
    y = a1*x+b1;
  } else { //hvis der er lodrette linjer
    double a;
    double b;
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
  double x;
  double y;
  double radius;
  double masse;
  color farve;
  Legeme(double x, double y, double radius, double masse, color farve) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.masse = masse;
    this.farve = farve;
    legemer.add(this);
  }
  void tegn() {
    fill(farve);
    circle((float)(x-camX), (float)(y-camY), (float)radius*2);
  }
}
