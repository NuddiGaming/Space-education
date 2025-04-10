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
    //Gemmer den nuværende translation scale og rotation
    pushMatrix();
    //Går tilbage til den standard af disse
    resetMatrix();
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
    popMatrix();
  }

  //Funktion til at bestemme om musen er over en knap uden translation scale og rotation
  boolean mouseOverUdenTransform() {
    if (knapSkærm==skærm) {
      if (!tegner) {
        //Gemmer den nuværende translation scale og rotation
        pushMatrix();
        //Går tilbage til den standard af disse
        resetMatrix();
      }
      if (posX < mouseX && mouseX < (posX + sizeX) &&
        posY < mouseY && mouseY < (posY + sizeY)) {
        if (!tegner) {
          // Går tilbage til den tidligere translation scale og rotation
          popMatrix();
        }
        return(true);
      }
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
  void rotateFull(Punkt p, double v) {
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
