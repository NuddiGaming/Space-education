//Kamera position
double camX = 0;
double camY = 0;
float camRot = 0;
//Kamera zoom
float zoom = 10;
//Kamera hastighed
float camSpeed = 30;

//grid
int gridDist = 100;
int gridSize = 5000;

int skærm=0;

float delta;
float deltaTime;

ArrayList<Legeme> legemer = new ArrayList<Legeme>();
Legeme jorden = new Legeme(0, 6378000, 6378000, 5972*pow(10, 21), color(0, 0, 255));
//raket
Raket raket;

void setup() {
  fullScreen();
  //lav raket
  raket = new Raket();
}

void draw() {
  delta = (millis()-deltaTime)/1000;
  deltaTime = millis();
  //zoom
  translate(width/2, height/2);
  scale(zoom);
  rotate(camRot);
  //lav alt andet
  grafik();
  fysik();
  input();
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
    int TEKSTSIZE, color KNAPFARVE, color HOVERFARVE,color CLICKFARVE ,float RUNDHED, int KNAPSKÆRM) {
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
      //Tegner selve knappen
      rect((float)(posX-camX), (float)(posY-camY), sizeX, sizeY, rundhed);
      //Sørger for at tekst tegnes med udgangspunkt i centrum af knappen
      textAlign(CENTER, CENTER);
      //Skifter farven på teksten
      fill(tekstFarve);
      //Skriver teksten
      text(tekst, (float)(posX+sizeX/2), (float)(posY-camY+sizeY/2));
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
