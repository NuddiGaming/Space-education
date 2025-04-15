//Kamera position
double camX = 0;
double camY = 0;
float camRot = 0;
//Kamera zoom
float zoom = 10;
//Kamera hastighed
float camSpeed = 30;

double scale=1000;

//grid
int gridDist = 100;
int gridSize = 5000;

//statemachine med hvor man er henne i programmet
int hovedMenu=0;
int simulationKører=1;
int simulationPauset=2;
int skærm=hovedMenu;

float delta;
float deltaTime;
float timestep = 1;

ArrayList<Legeme> legemer = new ArrayList<Legeme>();
Legeme jorden = new Legeme(0, 6378000, 6378000, 5.972*Math.pow(10, 24), color(0, 150, 50));
Legeme måne = new Legeme(0, -384400000, 1737400, 7.347*Math.pow(10, 22), color(100, 100, 100));
//raket
Raket raket;


void setup() {
  fullScreen();
  //lav raket
  raket = new Raket();
  setupStjerner(200);
  setupKnapper();
  //textfields.add(new Textfield(width/2, height/2, 200, 50, color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), color(255, 255, 0), 20, "Indtast navn", "", 10, 0, false));
}

void draw() {
  if (skærm == simulationKører || skærm == simulationPauset) {
    simulationGrafik();
    delta = (millis()-deltaTime)/1000*timestep;
      deltaTime = millis();
    //gør så selve simulation kun kører når den skal
    if (skærm == simulationKører) {
      delta = (millis()-deltaTime)/1000*timestep;
      deltaTime = millis();
      fysik();
    }
    input();
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
  println("vX: "+raket.vX+"   vY: "+raket.vY);
}
