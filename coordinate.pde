void drawGrid() { // Tegner grid
  float baseStep = 1000;
  float step = baseStep;

  while (step * zoom > 200) {
    step /= 2;
    if (step < 1) {
      break;
    }
  }
  while (step * zoom < 10) {
    step *= 2;
    if (step > 1000) {
      break;
    }
  }

  float gridStroke = 1 / zoom;
  strokeWeight(gridStroke);

  for (float x = -5000; x <= 5000; x += step) {
    if (x % 1000 == 0) {
      stroke(150);
    } 
    else {
      stroke(50);
    }
    line(x, -5000, x, 5000);
  }

  for (float y = -5000; y <= 5000; y += step) {
    if (y % 1000 == 0) {
      stroke(150);
    } 
    else {
      stroke(50);
    }
    line(-5000, y, 5000, y);
  }
}

void drawAxes() { // Tegner axes
  stroke(255, 0, 0);
  strokeWeight(2 / zoom);
  line(-5000, 0, 5000, 0);
  line(0, -5000, 0, 5000);

  fill(255);
  textAlign(CENTER, CENTER);

  for (float x = -5000; x <= 5000; x += 1000) {
    if (x != 0) {
      strokeWeight(5);
      String label = int(x) + "m";
      text(label, x, -10);
    }
  }
  for (float y = -5000; y <= 5000; y += 1000) {
    if (y != 0) {
      strokeWeight(5);
      String label = int(y) + "m";
      text(label, 20, y);
    }
  }

  fill(255, 0, 0);
  ellipse(0, 0, max(3, 10 / zoom), max(3, 10 / zoom));
}

void drawHUD() { // Tegner HUD
  float halvWidth = width / (2 * zoom);
  float halvHeight = height / (2 * zoom);

  float minX = int(camX - halvWidth);
  float maxX = int(camX + halvWidth);
  float minY = int(camY - halvHeight);
  float maxY = int(camY + halvHeight);

  fill(0, 150);
  rect(10, 10, 250, 50);

  fill(255);
  textAlign(LEFT, TOP);
  text("X: " + minX + "m - " + maxX + "m", 20, 20);
  text("Y: " + minY + "m - " + maxY + "m", 20, 40);
}

void drawShip(){ // Tegner skibet
  noStroke();
  fill(255);
  rectMode(CENTER); // Tegner den i midten af locationen
  rect(shipX, shipY, 10, 10); // Tegner selve skibet
}

void mouseWheel(MouseEvent event) { // Zoom funktion som bruger mouse wheel
  float zoomFactor = 1.1; // Hvor meget zoom ændre sig med
  float oldZoom = zoom;

  if (event.getCount() > 0) {
    zoom /= zoomFactor;
  }
  if (event.getCount() < 0) {
    zoom *= zoomFactor;
  }

  zoom = constrain(zoom, 0.1, 10); // Gør så man ikke kan zoom for langt ind eller ud

  float mouseXLoc = (mouseX - width / 2) / oldZoom + camX;
  float mouseYLoc = (mouseY - height / 2) / oldZoom + camY;
  camX = mouseXLoc - (mouseX - width / 2) / zoom;
  camY = mouseYLoc - (mouseY - height / 2) / zoom;
}
