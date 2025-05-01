import processing.sound.*;

//Kamera position
double camX = 0;
double camY = 0;
float camRot = 0;
//Raket rot
double tempRaketRot;
//Kamera zoom
float zoom = 10;
boolean zoomConstrain = false;
//Kamera hastighed
float camSpeed = 30;

double scale=1;

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

JSONObject scenario;
float cx, cy, r;
double pupDist;

ArrayList<Legeme> legemer = new ArrayList<Legeme>();
Legeme zoomLegeme;
//raket
Raket raket;

ArrayList<SoundFile> explosionSounds = new ArrayList<SoundFile>();
SoundFile engineSound;


void setup() {
  fullScreen();
  for(int i=0;i<4;i++){
    explosionSounds.add(new SoundFile(this, "data/sounds/explosion_"+str(i+1)+".mp3"));
  }
  engineSound = new SoundFile(this, "data/sounds/engine_sound.mp3");
  //lav raket
  raket = new Raket();
  setupStjerner(200);
  setupKnapper();
  loadScenario("Jorden og månen");
  //textfields.add(new Textfield(width/2, height/2, 200, 50, color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), color(255, 255, 0), 20, "Indtast navn", "", 10, 0, false));
}

void draw() {
  if (skærm == simulationKører || skærm == simulationPauset) {
    simulationGrafik();
    delta = (millis()-deltaTime)/1000*timestep;
    deltaTime = millis();
    //gør så selve simulation kun kører når den skal
    if (skærm == simulationKører) {
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
    if (k.knapSkærm==simulationKører &&(skærm==simulationKører || skærm==simulationPauset)) {
      k.tegnUdenTransform();
    }
  }
  for (Textfield field : textfields) {
    field.tegnPåSkærm();
  }

  // Gør så man ikke kan zoom ud og se at planeten ikke bliver tegnet.
  if (zoomConstrain && scale <= 3) {
    zoom = constrain(zoom, (float)zoomLegeme.radius/20000000, 1000);
  }
}
