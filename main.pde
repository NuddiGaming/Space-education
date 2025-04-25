//Kamera position
double camX = 0;
double camY = 0;
float camRot = 0;
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

float cx, cy, r;
double pupDist;

ArrayList<Legeme> legemer = new ArrayList<Legeme>();
Legeme jorden = new Legeme(0, 6378000, 6378000, 5.972*Math.pow(10, 24), color(0, 150, 50));
Legeme måne = new Legeme(0, -384400000, 1737400, 7.347*Math.pow(10, 22), color(100, 100, 100));

Legeme zoomLegeme;
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


  if (zoomConstrain) {
    zoom = constrain(zoom, (float)zoomLegeme.radius/200000000, 1000);


    PVector rocketPos = new PVector((float)raket.massemidtpunkt.rotate(raket.rotationspunkt,raket.rot).x + (float) raket.x, (float) raket.massemidtpunkt.rotate(raket.rotationspunkt,raket.rot).y + (float)raket.y);
    PVector planetPos = new PVector((float)zoomLegeme.x, (float)zoomLegeme.y);
    PVector toCenter = PVector.sub(planetPos, rocketPos);
    float dist = toCenter.mag();
    toCenter.normalize();

    float planeDistance = dist - (float)zoomLegeme.radius;
    if (planeDistance < 0) planeDistance = 0;

    PVector planeCenter = PVector.add(rocketPos, PVector.mult(toCenter, planeDistance));
    
    float angleToPlane = atan2(planeCenter.y - planetPos.y,planeCenter.x - planetPos.x);
    float angleDeg = degrees(angleToPlane);

    pushStyle();
    fill(255, 0, 0);
    noStroke();
    
    float halfWidth = (float) zoomLegeme.radius/1200;
    float thickness = (float) zoomLegeme.radius/2000;
    
    PVector u = new PVector(cos(angleToPlane + HALF_PI), sin(angleToPlane + HALF_PI));
    PVector v = new PVector(cos(angleToPlane),sin(angleToPlane));
    
    float[][] local = {{-halfWidth,0},{halfWidth,0},{halfWidth,-thickness},{-halfWidth,-thickness}};
    
    float[] sx = new float[4], sy = new float[4];
    for (int i = 0; i < 4; i++) {
      float lx = local[i][0];
      float ly = local[i][1];

      float wx = planeCenter.x + u.x * lx + v.x * ly;
      float wy = planeCenter.y + u.y * lx + v.y * ly;

      sx[i] = wx - (float)camX;
      sy[i] = wy - (float)camY;
    }
    
    float dotSize = 10 / zoom;
    circle(planeCenter.x - (float)camX, planeCenter.y - (float)camY, dotSize);
    
    quad(sx[0], sy[0], sx[1], sy[1], sx[2], sy[2], sx[3], sy[3]);
    popStyle();

    println("Angle to plane  (rad) = " + nf(angleToPlane, 0, 3) + ", (deg) = "+ nf(angleDeg, 0, 1));
  }
}
