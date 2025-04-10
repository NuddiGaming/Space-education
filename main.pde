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

//statemachine med hvor man er henne i programmet
int hovedMenu=0;
int simulationKører=1;
int simulationPauset=2;
int skærm=hovedMenu;

//raket
Raket raket;


void setup() {
  fullScreen();
  //placer kamera i midten
  camX = gridSize/2;
  camY = gridSize/2;
  //lav raket
  raket = new Raket();
  setupStjerner(200);
  setupKnapper();
  //textfields.add(new Textfield(width/2, height/2, 200, 50, color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), color(255, 255, 0), 20, "Indtast navn", "", 10, 0, false));
}

void draw() {
  if (skærm == simulationKører || skærm == simulationPauset) {
    simulationGrafik();
    input();
    //gør så selve simulation kun kører når den skal
    if (skærm == simulationKører) {

      fysik();
    }
  } else if (skærm == hovedMenu) {
    //Tegner grafikken i baggrunden
    simulationGrafik();
    //laver hovedmenuen
    hovedMenu();
  }
  // Tegner knapperne baseret på absolutte koordinater
  for (Knap k : knapper) {
    if (k.knapSkærm == hovedMenu && skærm==hovedMenu) {
      k.tegnUdenTransform();
    }
    if(k.knapSkærm==simulationKører &&(skærm==simulationKører || skærm==simulationPauset)){
      k.tegnUdenTransform();
    }
  }
  for (Textfield field : textfields) {
    field.tegnPåSkærm();
  }
}
