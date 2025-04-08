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
}

void draw() {
  if (skærm == simulationKører || skærm == simulationPauset) {
    simulationGrafik();
    //gør så selve simulation kun kører når den skal
    if (skærm == simulationKører) {
      input();
      fysik();
    }
  } 
  else if (skærm == hovedMenu) {
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
  }
  for(Textfield field : textfields){
    field.tegn();
  }
}
