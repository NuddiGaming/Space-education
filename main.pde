float camX = 0, camY = 0;
float zoom = 1.0;
float shipX = 0, shipY = 0;

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
  tegnRaket(shipX,shipY,0,true);

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
