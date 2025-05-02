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
  Kraft rotate(Punkt rP, float v) {
    return new Kraft((x-rP.x)*cos(v) - (y-rP.y)*sin(v)+rP.x, (x-rP.x)*sin(v) + (y-rP.y)*cos(v)+rP.y, p);
  }
  void reset() {
    x=0;
    y=0;
  }
}

ArrayList<Knap> knapper = new ArrayList <Knap>();

class Knap {
  //position af det øverste venstre hjørne af tekstfeltet
  float posX;
  float posY;
  //Størrelsen af tekstfeltet
  float sizeX;
  float sizeY;
  //Farven på teksten
  color tekstFarve;
  //Teksten der vises på knappen
  String tekst;
  //Størrelsen af teksten der vises
  int tekstSize;
  //Basis farve på knappen
  color knapFarve;
  //Farven der vises når musen er placeret over knappen
  color hoverFarve;
  //Farven der vises når der clickes på knappen
  color clickFarve;
  //Værdi der bruges til at afrunde hjørnerne på knappen
  float rundhed;
  //Skærmen som tekst feltet er på
  int knapSkærm;

  boolean tegner=false;

  Knap(float POSX, float POSY, float SIZEX, float SIZEY, color TEKSTFARVE, String TEKST,
    int TEKSTSIZE, color KNAPFARVE, color HOVERFARVE, color CLICKFARVE, float RUNDHED, int KNAPSKÆRM) {
    //Gemmer alle værdierne som der inputtes i constructoren
    posX=POSX;
    posY=POSY;
    sizeX=SIZEX;
    sizeY=SIZEY;
    tekstFarve=TEKSTFARVE;
    tekst=TEKST;
    tekstSize=TEKSTSIZE;
    knapFarve=KNAPFARVE;
    rundhed=RUNDHED;
    knapSkærm=KNAPSKÆRM;
    hoverFarve=HOVERFARVE;
    clickFarve=CLICKFARVE;
  }
  void tegn() {
    //Tegnes kun hvis knappen er på den samme skærm som brugeren er
    if (knapSkærm==skærm) {
      //Sørger for at det er det øverste venstre hjørne som knappen tegnes fra
      rectMode(CORNER);
      //Skifter farven hvis musen er over knappen
      if (mouseOver()) {
        if (mousePressed) {
          fill(clickFarve);
        } else {
          fill(hoverFarve);
        }
      } else {
        fill(knapFarve);
      }
      //Sørger for at tekst tegnes med udgangspunkt i centrum af knappen
      textAlign(CENTER, CENTER);
      textSize(tekstSize);
      if (knapSkærm == hovedMenu) {
        //Tegner selve knappen
        rect(posX, posY, sizeX, sizeY, rundhed, rundhed, rundhed, rundhed);
        //Skifter farven på teksten
        fill(tekstFarve);
        //Skriver teksten
        text(tekst, posX+sizeX/2, posY+sizeY/2);
      } else {
        //Tegner selve knappen
        rect((float)(posX-camX), (float)(posY-camY), sizeX, sizeY, rundhed, rundhed, rundhed, rundhed);
        //Skifter farven på teksten
        fill(tekstFarve);
        //Skriver teksten
        text(tekst, (float)(posX+sizeX/2-camX), (float)(posY+sizeY/2-camY));
      }
    }
  }
  //funktion der returnerer sand når musen er over knappen men ellers falsk
  boolean mouseOver() {
    if (posX-camX < mouseX && mouseX < (posX+sizeX-camX) && posY-camY < mouseY && mouseY < (posY+sizeY-camY) && knapSkærm==skærm) {
      return(true);
    } else {
      return(false);
    }
  }
  //funktion til at tegne knapper uden camX og camY
  void tegnUdenTransform() {
    // bestemmer farven ved musOver og klick
    tegner=true;
    if (mouseOverUdenTransform()) {
      tegner=false;
      if (mousePressed) {
        fill(clickFarve);
      } else {
        fill(hoverFarve);
      }
    } else {
      fill(knapFarve);
    }

    // Tegner den selve knappen
    rectMode(CORNER);
    rect(posX, posY, sizeX, sizeY, rundhed, rundhed, rundhed, rundhed);

    // Skriver teksten
    textAlign(CENTER, CENTER);
    fill(tekstFarve);
    textSize(tekstSize);
    text(tekst, posX + sizeX/2, posY + sizeY/2);
    // Går tilbage til den tidligere translation scale og rotation
  }

  //Funktion til at bestemme om musen er over en knap uden translation scale og rotation
  boolean mouseOverUdenTransform() {
    if (knapSkærm==skærm) {
      if (posX < mouseX && mouseX < (posX + sizeX) &&
        posY < mouseY && mouseY < (posY + sizeY)) {
        return(true);
      }
    }
    return(false);
  }
}

class PauseKnap extends Knap {
  PauseKnap(float POSX, float POSY, float SIZEX, float SIZEY, color TEKSTFARVE, String TEKST,
    int TEKSTSIZE, color KNAPFARVE, color HOVERFARVE, color CLICKFARVE, float RUNDHED, int KNAPSKÆRM) {
    super(POSX, POSY, SIZEX, SIZEY, TEKSTFARVE, TEKST, TEKSTSIZE, KNAPFARVE, HOVERFARVE, CLICKFARVE, RUNDHED, KNAPSKÆRM);
  }
  @Override
    void tegnUdenTransform() {
    if (skærm==editorSkærm || skærm==simulationPauset || skærm==simulationKører) {
      rectMode(CORNER);
      noStroke();
      //Tegner selve knappen
      translate(posX, posY);
      tegner=true;
      if (mouseOverUdenTransform()) {
        fill(hoverFarve);
      } else {
        fill(knapFarve);
      }
      tegner=false;
      noStroke();
      beginShape();
      vertex(height/15, 0);
      vertex(height/15, height/17*2);
      vertex(0, height/17);
      endShape(CLOSE);
      rect(height/15, height/17-height/44, height/15, height/22);
    }
  }
  @Override
    //Funktion til at bestemme om musen er over en knap uden translation scale og rotation
    boolean mouseOverUdenTransform() {
    if (posX < mouseX && mouseX < (posX + sizeX) &&
      posY < mouseY && mouseY < (posY + sizeY)) {
      return(true);
    }
    return(false);
  }
}

ArrayList<Stjerne> stjerner = new ArrayList<Stjerne>();

class Stjerne {
  float posX;
  float posY;
  float radius;
  color farve;
  Stjerne(float POSX, float POSY, float RADIUs, color FARVE) {
    posX=POSX;
    posY=POSY;
    radius=RADIUs;
    farve=FARVE;
  }
  void tegnStjerne() {
    noStroke();
    fill(farve);
    circle(posX, posY, radius);
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
}

//Linje class til extreme math.
class Linje {
  Punkt p1;
  Punkt p2;
  Linje(Punkt p1, Punkt p2) {
    this.p1 = p1;
    this.p2 = p2;
  }
  Linje rotate(Punkt p, double v) {
    return new Linje(p1.rotate(p, v), p2.rotate(p, v));
  }
  double længdeX() {
    return p2.x-p1.x;
  }
  double længdeY() {
    return p2.y-p1.y;
  }
  double længde() {
    return Math.sqrt(Math.pow(længdeX(), 2)+Math.pow(længdeY(), 2));
  }
  double a() {
    return længdeY()/længdeX();
  }
  double b() {
    return p1.y-a()*p1.x;
  }
}

//Legeme class til planeter/måner/whatever der skal have tyngdekraft
class Legeme {
  double x;
  double y;
  double radius;
  double masse;
  color farve;
  String navn;
  Textfield masseFelt, radiusFelt, navnFelt;
  Legeme(double x, double y, double radius, double masse, color farve, String navn) {
    this.x = x/scale;
    this.y = y/scale;
    this.radius = radius/scale;
    this.masse = masse/Math.pow(scale, 2);
    this.farve = farve;
    this.navn=navn;

    masseFelt= new Textfield(width/2, height/2, 200, 30, color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), color(255, 255, 0), 15, Double.toString(masse), 10, editorSkærm, false);

    radiusFelt= new Textfield(width/2, height/2, 200, 30, color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), color(255, 255, 0), 15, Double.toString(radius), 10, editorSkærm, false);

    navnFelt= new Textfield(width/2, height/2, 200, 30, color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), color(255, 255, 0), 15, navn, 10, editorSkærm, false);
    legemer.add(this);
  }
  void tegn() {
    fill(farve);
    circle((float)(x-camX), (float)(y-camY), (float)radius*2);
  }

  boolean mouseOver() {
    // Omregner musens koordinater til nogen der passer til translationen af disse
    double mx = mouseX - width / 2;
    double my = mouseY - height / 2;
    double cosR = cos(-camRot);
    double sinR = sin(-camRot);
    double rotx = mx * cosR - my * sinR;
    double roty = mx * sinR + my * cosR;
    double globalX = rotx / zoom + camX;
    double globalY = roty / zoom + camY;

    // beregner global afstand mellem musen og legemets center
    double dx = x - globalX;
    double dy = y - globalY;
    double afstand = Math.sqrt(dx * dx + dy * dy);

    // hvis afstand er mindre end radius true
    return afstand <= radius;
  }
}
ArrayList<PhysicsObject> physicsObjects = new ArrayList<PhysicsObject>();

class PhysicsObject {
  Punkt pos;
  double vX;
  double vY;
  double rot;
  double rotHast;
  ArrayList<Punkt> grafikPunkter;
  ArrayList<Punkt> kollisionsPunkter;
  Punkt massemidtPunkt;
  double masse;
  color farve;
  Punkt rotationsPunkt;
  Punkt collisionsPunkt;
  PhysicsObject(Punkt pos, double vX, double vY, double rot, double rotHast, ArrayList<Punkt> grafikPunkter, ArrayList<Punkt> kollisionsPunkter, Punkt massemidtPunkt, double masse, color farve) {
    this.pos = pos;
    this.vX = vX;
    this.vY = vY;
    this.rot = rot;
    this.rotHast = rotHast;
    this.grafikPunkter = grafikPunkter;
    this.kollisionsPunkter = kollisionsPunkter;
    this.massemidtPunkt = massemidtPunkt;
    this.masse = masse;
    rotationsPunkt = massemidtPunkt;
    this.farve = farve;
    physicsObjects.add(this);
  }
  void fysik() {
    ArrayList<Kraft> krafter = new ArrayList<Kraft>();
    collisionsPunkt = null;
    double sumX = 0;
    double sumY = 0;
    int m = 0;
    Legeme collisionsLegeme = null;
    Punkt closestPoint = massemidtPunkt;
    //tyngdekraft funktionalitet og collision med legemer
    for (Legeme legeme : legemer) {
      double dX = legeme.x-(massemidtPunkt.rotate(rotationsPunkt, rot).x+pos.x);
      double dY = legeme.y-(massemidtPunkt.rotate(rotationsPunkt, rot).y+pos.y);
      double dist = Math.sqrt(Math.pow(dX, 2)+Math.pow(dY, 2));
      double tyngdekraft = g*legeme.masse*masse/Math.pow(dist, 2);
      double rX = dX/dist;
      double rY = dY/dist;
      Kraft gravity = new Kraft(rX*tyngdekraft, rY*tyngdekraft, massemidtPunkt);
      krafter.add(gravity);
      //collisionen mellem legemer
      for (Punkt p : kollisionsPunkter) {
        Punkt pCopy = new Punkt(p.x, p.y);
        pCopy = pCopy.rotate(new Punkt(rotationsPunkt.x, rotationsPunkt.y), rot);
        pCopy.x += pos.x;
        pCopy.y += pos.y;
        double legemeDist = Math.sqrt(Math.pow(pCopy.x-legeme.x, 2)+Math.pow(pCopy.y-legeme.y, 2));
        if (legemeDist <= legeme.radius) {
          if (Math.sqrt(Math.pow(pCopy.x-legeme.x, 2)+Math.pow(pCopy.y-legeme.y, 2)) < Math.sqrt(Math.pow(closestPoint.x-legeme.x, 2)+Math.pow(closestPoint.y-legeme.y, 2))) {
            closestPoint = pCopy;
          }
          fill(255, 0, 0);
          if (collisionsLegeme == null) {
            collisionsLegeme = legeme;
            collisionsPunkt = new Punkt(0, 0);
          }
          sumX += p.x;
          sumY += p.y;
          m++;
        } else {
          fill(255);
        }
        //circle((float)(pCopy.x-camX), (float)(pCopy.y-camY), 1);
      }
      float zoomDist = (float) legeme.radius + (float) legeme.radius/1200;
      if (dist <= zoomDist && scale <= 3 && skærm!=editorSkærm) {
        zoomConstrain = true;
        zoomLegeme = legeme;
        pupDist = dist;
      } else if (dist > zoomDist && zoomLegeme == legeme) {
        zoomConstrain = false;
      }
    }
    //her tilføjes alle kræfter
    for (Kraft kraft : krafter) {
      tilføjKraft(kraft);
    }
    if (collisionsPunkt != null) {
      collisionsPunkt.x = sumX/m;
      collisionsPunkt.y = sumY/m;
      Linje l2 = new Linje(rotationsPunkt, collisionsPunkt);
      Punkt oldPos = massemidtPunkt.rotate(rotationsPunkt, rot);
      if (rotationsPunkt != collisionsPunkt) {
        rotationsPunkt = new Punkt(collisionsPunkt.x, collisionsPunkt.y);
      }
      Punkt newPos = massemidtPunkt.rotate(rotationsPunkt, rot);
      double dX = oldPos.x-newPos.x;
      double dY = oldPos.y-newPos.y;
      pos.x += dX;
      pos.y += dY;
      Linje l1 = new Linje(new Punkt(collisionsLegeme.x, collisionsLegeme.y), new Punkt(collisionsPunkt.x+pos.x, collisionsPunkt.y+pos.y));
      double v = rotHast*l2.længde()+Math.sqrt(Math.pow(vX, 2)+Math.pow(vY, 2));
      double kraft = masse*v;
      double kX = l1.længdeX()/l1.længde()*kraft;
      double kY = l1.længdeY()/l1.længde()*kraft;
      tilføjKraft(new Kraft(kX, kY, collisionsPunkt));
      rotHast *= 0.99;
      vY *= 0.99;
      vX *= 0.99;
    } else if (rotationsPunkt != massemidtPunkt) {
      Punkt oldPos = massemidtPunkt.rotate(rotationsPunkt, rot);
      rotationsPunkt = massemidtPunkt;
      Punkt newPos = massemidtPunkt.rotate(rotationsPunkt, rot);
      double dX = oldPos.x-newPos.x;
      double dY = oldPos.y-newPos.y;
      pos.x += dX;
      pos.y += dY;
    }
    //tilføj hastigheden på x og y
    pos.x += vX*delta;
    pos.y += vY*delta;
    rot += rotHast*delta;
    if (collisionsLegeme != null) {
      for (Punkt p : kollisionsPunkter) {
        Punkt pCopy = new Punkt(p.x, p.y);
        pCopy = pCopy.rotate(new Punkt(rotationsPunkt.x, rotationsPunkt.y), rot);
        pCopy.x += pos.x;
        pCopy.y += pos.y;
        if (Math.sqrt(Math.pow(pCopy.x-collisionsLegeme.x, 2)+Math.pow(pCopy.y-collisionsLegeme.y, 2)) <= collisionsLegeme.radius) {
          if (Math.sqrt(Math.pow(pCopy.x-collisionsLegeme.x, 2)+Math.pow(pCopy.y-collisionsLegeme.y, 2)) < Math.sqrt(Math.pow(closestPoint.x-collisionsLegeme.x, 2)+Math.pow(closestPoint.y-collisionsLegeme.y, 2))) {
            closestPoint = pCopy;
          }
        }
      }
      Linje l1 = new Linje(new Punkt(collisionsLegeme.x, collisionsLegeme.y), closestPoint);
      double sX = l1.længdeX()/l1.længde()*collisionsLegeme.radius+collisionsLegeme.x;
      double sY = l1.længdeY()/l1.længde()*collisionsLegeme.radius+collisionsLegeme.y;
      Punkt p = new Punkt(sX, sY);
      Linje l2 = new Linje(closestPoint, p);
      pos.x += l2.længdeX()*0.99;
      pos.y += l2.længdeY()*0.99;
    }
  }
  void tilføjKraft(Kraft kraft) {
    //jeg finder vektoren der peger fra påvirkningspunktet til massemidtpunktet
    Punkt a = new Punkt(kraft.p.x, kraft.p.y);
    Linje l = new Linje(a, massemidtPunkt);
    l = l.rotate(rotationsPunkt, rot);
    Punkt d = new Punkt(l.længdeX(), l.længdeY());
    //find distancen til massemidtpunkt
    double dist = Math.sqrt(Math.pow(d.x, 2) + Math.pow(d.y, 2));
    //regn vinklen mellem kraftvektoren og vektoren der peger mod massemidtpunkt
    double v = Math.acos((kraft.x*d.x + kraft.y*d.y) / (kraft.størrelse()*dist));
    //sikrer at v ikke er lig NaN
    if (v != v) {
      v = 0;
    }
    //tilføj kraften på hastigheden
    vX += kraft.x/masse*Math.abs(Math.cos(v))*delta;
    vY += kraft.y/masse*Math.abs(Math.cos(v))*delta;
    //find determinanten
    double det = d.x*kraft.y - d.y*kraft.x;
    //hvis determinanten er negativ så er kraft vektoren med uret rundt om vektoren der peger mod massemidtpunktet og derfor skal objektet rotere mod uret rundt, basic stuff lol B)
    if (det < 0) {
      rotHast += kraft.størrelse()/masse/5*Math.abs(Math.sin(v))*delta;
    } else { //og hvis den er positiv så er det omvendt
      rotHast -= kraft.størrelse()/masse/5*Math.abs(Math.sin(v))*delta;
    }
  }
  void tegn() {
    pushMatrix();

    //flyt objekt position til 0, 0
    translate((float)(pos.x-camX), (float)(pos.y-camY));

    noStroke();

    //tegn objekt
    fill(farve);
    beginShape();
    for (Punkt p : grafikPunkter) {
      vertex((float)p.rotate(rotationsPunkt, rot).x, (float)p.rotate(rotationsPunkt, rot).y);
    }
    endShape(CLOSE);
    for (int i=0;i<kollisionsPunkter.size();i++) {
      Punkt p = kollisionsPunkter.get(i);
      fill(0, float(i+1)/kollisionsPunkter.size()*255, 0);
      //circle((float)p.rotate(rotationsPunkt, rot).x, (float)p.rotate(rotationsPunkt, rot).y, 0.5);
    }
    //tegn massemidtpunkt indikatoren
    /*fill(255, 255, 0);
    circle((float)massemidtPunkt.rotate(rotationsPunkt, rot).x, (float)massemidtPunkt.rotate(rotationsPunkt, rot).y, 0.5);
    fill(0);
    arc((float)massemidtPunkt.rotate(rotationsPunkt, rot).x, (float)massemidtPunkt.rotate(rotationsPunkt, rot).y, 0.5, 0.5, 0, PI/2);
    arc((float)massemidtPunkt.rotate(rotationsPunkt, rot).x, (float)massemidtPunkt.rotate(rotationsPunkt, rot).y, 0.5, 0.5, PI, 1.5*PI);*/
    popMatrix();
  }
}
