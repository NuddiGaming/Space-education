float camX = 0, camY = 0;
float zoom = 1.0;
float shipX = 0, shipY = 0;
//indledende skridt til statemachine
int skærm=0;

void setup() {
  fullScreen();
  textSize(16);
}

void draw() {
  background(0);

  translate(width / 2, height / 2);
  scale(zoom);
  translate(-camX, -camY);

  // Bliver displayet på hele mappet:
  drawGrid(); 
  drawAxes();
  tegnRaket(shipX,shipY,0,true,10);

  resetMatrix();
  
  // Bliver displayet på skærmen:
  drawHUD();
}

void keyPressed() { // Temp movement
  float moveSpeed = 10; // Hvor hurtigt camera og skibet/racketen bevæger sig.
  shipX = constrain(shipX, -5000, 5000); // Constrainer til mappet
  shipY = constrain(shipY, -5000, 5000); // Constrainer til mappet
  camX = constrain(camX, -5000, 5000); // Constrainer til mappet
  camY = constrain(camY, -5000, 5000); // Constrainer til mappet
  if (key == 'w') {
    camY -= moveSpeed;
    shipY -= moveSpeed;
  }
  if (key == 's') {
    camY += moveSpeed;
    shipY += moveSpeed;
  }
  if (key == 'a') {
    camX -= moveSpeed;
    shipX -= moveSpeed;
  }
  if (key == 'd') {
    camX += moveSpeed;
    shipX += moveSpeed;
  }
  if (key == 'r') { // Resetter camera til skibet/racketens location
    camX = shipX;
    camY = shipY;
    zoom = 10;
  }
}

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
  color feltFarve;
  //Farven der vises når musen er placeret over knappen
  color mouseOverFarve;
  //Værdi der bruges til at afrunde hjørnerne på knappen
  float rundhed;
  //Skærmen som tekst feltet er på
  int knapSkærm;

  Knap(float POSX, float POSY, float SIZEX, float SIZEY, color TEKSTFARVE, String TEKST,
    int TEKSTSIZE, color FELTFARVE, color MOUSEOVERFARVE, float RUNDHED, int KNAPSKÆRM) {
    //Gemmer alle værdierne som der inputtes i constructoren
    posX=POSX;
    posY=POSY;
    sizeX=SIZEX;
    sizeY=SIZEY;
    tekstFarve=TEKSTFARVE;
    tekst=TEKST;
    tekstSize=TEKSTSIZE;
    feltFarve=FELTFARVE;
    rundhed=RUNDHED;
    knapSkærm=KNAPSKÆRM;
    mouseOverFarve=MOUSEOVERFARVE;
  }
  void tegn() {
    //Tegnes kun hvis knappen er på den samme skærm som brugeren er
    if (knapSkærm==skærm) {
      //Sørger for at det er det øverste venstre hjørne som knappen tegnes fra
      rectMode(CORNER);
      //Skifter farven hvis musen er over knappen
      if (mouseOver()) {
        fill(mouseOverFarve);
      } else {
        fill(feltFarve);
      }
      //Tegner selve knappen
      rect(posX, posY-camY, sizeX, sizeY, rundhed, rundhed, rundhed, rundhed);
      //Sørger for at tekst tegnes med udgangspunkt i centrum af knappen
      textAlign(CENTER, CENTER);
      //Skifter farven på teksten
      fill(tekstFarve);
      //Skriver teksten
      text(tekst, posX+sizeX/2, posY-camY+sizeY/2);
    }
  }
  //funktion der returnerer sand når musen er over knappen men ellers falsk
  boolean mouseOver() {
    if (posX < mouseX && mouseX < (posX+sizeX) && posY < mouseY && mouseY < (posY+sizeY) && knapSkærm==skærm) {
      return(true);
    } else {
      return(false);
    }
  }
}
