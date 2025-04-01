void drawGrid() { // Tegner grid
  float baseStep = 1000;
  float step = baseStep;

  while (step * zoom > 200) { // Sætter hvor mange linjer der skal være i vores grid
    step /= 2;
    if (step < 1) { // Sikre step ikke kommer under 1
      break;
    }
  }
  while (step * zoom < 10) { // Sætter hvor mange linjer der skal være i vores grid
    step *= 2;
    if (step > 1000) { // Sikre step ikke kommer over 1000
      break;
    }
  }

  float gridStroke = 1 / zoom;
  strokeWeight(gridStroke);

  for (float x = -5000; x <= 5000; x += step) {
    if (x % 1000 == 0) { // Ændre til en anden farve stroke for hver 1000m linje
      stroke(150);
    } 
    else {
      stroke(50);
    }
    line(x, -5000, x, 5000); // Tegner gridline
  }

  for (float y = -5000; y <= 5000; y += step) {
    if (y % 1000 == 0) { // Ændre til en anden farve stroke for hver 1000m linje
      stroke(150);
    } 
    else {
      stroke(50);
    }
    line(-5000, y, 5000, y); // Tegner gridline
  }
}

void drawAxes() { // Tegner axes
  stroke(255, 0, 0);
  strokeWeight(2 / zoom);
  line(-5000, 0, 5000, 0);
  line(0, -5000, 0, 5000);

  fill(255);
  textSize(max(5, 25 / zoom));
  textAlign(CENTER, CENTER);

  for (float x = -5000; x <= 5000; x += 1000) { // Tegner labels ved hver 1000 meter
    if (x != 0) {
      strokeWeight(5);
      String label = int(x) + "m";
      text(label, x, -10);
    }
  }
  for (float y = -5000; y <= 5000; y += 1000) { // Tegner labels ved hver 1000 meter
    if (y != 0) {
      strokeWeight(5);
      String label = int(y) + "m";
      text(label, 20, y);
    }
  }

  fill(255, 0, 0);
  ellipse(0, 0, max(3, 10 / zoom), max(3, 10 / zoom)); // Tegner en cirkle i midten af koordinat systemet
}

void drawHUD() { // Tegner HUD
  float halvWidth = width / (2 * zoom);
  float halvHeight = height / (2 * zoom);

  float minX = int(camX - halvWidth); // udreger (cirka) hvor meget af gridet du kan se
  float maxX = int(camX + halvWidth); // udreger (cirka) hvor meget af gridet du kan se
  float minY = int(camY - halvHeight); // udreger (cirka) hvor meget af gridet du kan se
  float maxY = int(camY + halvHeight); // udreger (cirka) hvor meget af gridet du kan se

  fill(0, 150);
  rect(10, 10, 250, 50);

  fill(255);
  textAlign(LEFT, TOP);
  textSize(16);
  text("X: " + minX + "m - " + maxX + "m", 20, 20); // Displayer text i hjørnet 
  text("Y: " + minY + "m - " + maxY + "m", 20, 40); // Displayer text i hjørnet 
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
