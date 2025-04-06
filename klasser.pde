//vores kraft class
class Kraft{
  float x;
  float y;
  float pX = 0;
  float pY = 0;
  Kraft(float x, float y, float pX, float pY){
    this.x = x;
    this.y = y;
    this.pX = pX;
    this.pY = pY;
  }
  //størrelsen/længden af kraften
  float størrelse(){
    return sqrt(pow(x, 2)+pow(y, 2));
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
      }
      else {
        //Tegner selve knappen
        rect(posX-camX, posY-camY, sizeX, sizeY, rundhed, rundhed, rundhed, rundhed);
        //Skifter farven på teksten
        fill(tekstFarve);
        //Skriver teksten
        text(tekst, posX+sizeX/2-camX, posY+sizeY/2-camY);
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
  // Handle hover and click colors
  if (mouseOverUdenTransform()) {
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
}

//Funktion til at bestemme om musen er over en knap uden translation scale og rotation
boolean mouseOverUdenTransform() {
  return (posX < mouseX && mouseX < (posX + sizeX) && 
          posY < mouseY && mouseY < (posY + sizeY));
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
