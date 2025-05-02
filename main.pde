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

//statemachine med hvor man er henne i programmet
int hovedMenu=0;
int simulationKører=1;
int simulationPauset=2;
int editorSkærm=3;
int skærm=hovedMenu;

Legeme draggingLegeme = null;
double dragOffsetX = 0;
double dragOffsetY = 0;


Legeme VisesIMenu;
int menuX;
int menuY;
boolean visMenu;

boolean visRaketMenu;
boolean visUniversMenu;

// Text felter til raket editor
Textfield motorKraftFelt;
Textfield raketMasseFelt;

// Text felter til univers editor
Textfield scaleFelt;
Textfield gKonstantFelt;

ArrayList<Textfield> textfields = new ArrayList<Textfield>();
Textfield activeFelt = null; // Holder styr på hvilket felt der er aktivt

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
Sound sound;
SoundFile engineSound;


void setup() {
  fullScreen();
  for (int i=0; i<4; i++) {
    explosionSounds.add(new SoundFile(this, "data/sounds/explosion_"+str(i+1)+".mp3"));
  }
  sound.volume(0.05);
  engineSound = new SoundFile(this, "data/sounds/engine_sound.mp3");
  engineSound.loop();
  engineSound.amp(0);
  //lav raket
  raket = new Raket();
  setupStjerner(200);
  setupKnapper();
  loadScenario("Jorden og månen");
  //textfields.add(new Textfield(width/2, height/2, 200, 50, color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), color(255, 255, 0), 20, "Indtast navn", "", 10, 0, false));
  setupTextfields();
}

void draw() {
  delta = (millis()-deltaTime)/1000*timestep;
  deltaTime = millis();
  if (skærm == simulationKører || skærm == simulationPauset) {
    simulationGrafik();
    //gør så selve simulation kun kører når den skal
    if (skærm == simulationKører) {

      fysik();
    }
    input();
  } else if (skærm == hovedMenu) {
    //Tegner grafikken i baggrunden
    simulationGrafik();
    delta = (millis()-deltaTime)/1000*timestep;
    deltaTime = millis();
    //laver hovedmenuen
    hovedMenu();
  } else if (skærm==editorSkærm) {
    input();
    //Tegner grafikken i baggrunden
    simulationGrafik();
    delta = (millis()-deltaTime)/1000*timestep;
    deltaTime = millis();
    //laver hovedmenuen
    editorSkærm();
  }
  // Tegner knapperne baseret på absolutte koordinater
  for (Knap k : knapper) {
    if (k.knapSkærm == hovedMenu && skærm==hovedMenu) {
      k.tegnUdenTransform();
    }
    if (k.knapSkærm==simulationKører &&(skærm==simulationKører || skærm==simulationPauset)) {
      k.tegnUdenTransform();
    }
    if (k.knapSkærm==skærm && k.knapSkærm==editorSkærm) {
      k.tegnUdenTransform();
    }
  }

  // Viser hvilket legeme man trækker
  if (draggingLegeme != null) {
    fill(255, 255, 0, 100);
    textAlign(CENTER);
    textSize(16);
    text("Trækker " + draggingLegeme.navn, width/2, height - 20);
  }

  // Gør så man ikke kan zoom ud og se at planeten ikke bliver tegnet.
  if (zoomConstrain == true && scale <= 3 && skærm!=editorSkærm) {
    zoom = constrain(zoom, (float)zoomLegeme.radius/20000000, 1000);
  }
}
