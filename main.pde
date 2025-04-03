//Kamera position
float camX = 0;
float camY = 0;
float camRot = 0;
//Kamera zoom
float zoom = 10;
//Kamera hastighed
float camSpeed = 30;

//grid
int gridDist = 100;
int gridSize = 5000;

int skærm=0;

//raket
Raket raket;

void setup(){
  fullScreen();
  //placer kamera i midten
  camX = gridSize/2;
  camY = gridSize/2;
  //lav raket
  raket = new Raket();
}

void draw(){
  //zoom
  translate(width/2, height/2);
  scale(zoom);
  rotate(camRot);
  //lav alt andet
  grafik();
  input();
  fysik();
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
