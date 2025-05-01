boolean w = false;
boolean a = false;
boolean s = false;
boolean d = false;
boolean j = false;
boolean l = false;

boolean brænder = false;

boolean pauseBrænder=false;

boolean følgerRaket = true;

//alt vores input lol
void input() {
  if (!følgerRaket) {
    //Bevæg kamera
    float x = 0;
    float y = 0;
    if (w) {
      y-=1;
    }
    if (a) {
      x-=1;
    }
    if (s) {
      y+=1;
    }
    if (d) {
      x+=1;
    }
    //sikrer at kameraet har samme hastighed lige meget hvilke knapper du trykker på
    float størrelse = sqrt(pow(x, 2)+pow(y, 2));
    if (størrelse > 0) {
      x = x/størrelse*camSpeed*delta;
      y = y/størrelse*camSpeed*delta;
    }
    //tilføj fart
    camX += x;
    camY += y;
  } else {
    //sæt kameraet på raketens massemidtpunkt
    camX = raket.massemidtpunkt.rotate(raket.rotationspunkt, raket.rot).x+raket.x;
    camY = raket.massemidtpunkt.rotate(raket.rotationspunkt, raket.rot).y+raket.y;
  }
}

//input...
void keyPressed() {
  if (activeFelt != null) {
    // Tjekker om det er slet man klikker på
    if (key == BACKSPACE && activeFelt.tekst.length() > 0) {
      activeFelt.tekst = activeFelt.tekst.substring(0, activeFelt.tekst.length() - 1);
    }
    // Normale tryk. Skal være normale keys, ikke backspace og ikke enter.
    else if (key != CODED && key != BACKSPACE && key != ENTER) {
      activeFelt.tekst += key;
    }
  } else {
    if (key == 'p') {
      if (skærm==simulationKører) {
        skærm=simulationPauset;
        if (brænder) {
          pauseBrænder=true;
        }
      } else if (skærm==simulationPauset) {
        skærm=simulationKører;
        pauseBrænder=false;
      }
    }
    if (key == 'w') {
      w = true;
    }
    if (key == 'a') {
      a = true;
    }
    if (key == 's') {
      s = true;
    }
    if (key == 'd') {
      d = true;
    }
    if (key == ' ') {
      brænder = true;
    }
    if (key == 'j') {
      j = true;
    }
    if (key == 'l') {
      l = true;
    }
    if (key == 'r') {
      følgerRaket = !følgerRaket;
    }
    if (key == '1') {
      timestep=1;
    } else if (key == '2') {
      timestep=5;
    } else if (key == '3') {
      timestep=10;
    } else if (key == '4') {
      timestep=100;
    } else if (key == '5') {
      timestep=1000;
    }
  }
}
//mere input...
void keyReleased() {
  if (key == 'w') {
    w = false;
  }
  if (key == 'a') {
    a = false;
  }
  if (key == 's') {
    s = false;
  }
  if (key == 'd') {
    d = false;
  }
  if (key == ' ') {
    brænder = false;
  }
  if (key == 'j') {
    j = false;
  }
  if (key == 'l') {
    l = false;
  }
}

void mousePressed() {
  if (hovedMenuStartKnap.mouseOverUdenTransform()) {
    skærm=simulationKører;
  }
  if (simulationsHovedMenuKnap.mouseOverUdenTransform()) {
    skærm=hovedMenu;
  }
  if (hovedMenuEditorKnap.mouseOverUdenTransform()) {
    skærm=editorSkærm;
  }
  if (editorRocketKnap.mouseOverUdenTransform()) {
    startRaketMenu();
  }
  if (editorUniverseKnap.mouseOverUdenTransform()) {
    startUniversMenu();
  }
  if (skærm==editorSkærm) {
    inputMenuer();
  }
  if (visMenu) {
    for (Textfield field : textfields) {
      if (field == VisesIMenu.navnFelt ||
        field == VisesIMenu.masseFelt ||
        field == VisesIMenu.radiusFelt) {
        if (field.mouseOver()) {
          if (activeFelt != null) {
            activeFelt.deactivate();
          }
          field.activate();
          return;
        }
      }
    }
    if (activeFelt != null) {
      activeFelt.deactivate();
      activeFelt = null;
    }
  }
}

//ændre zoom værdien når man skrållar med musen
void mouseWheel(MouseEvent event) {
  float e = -event.getCount();
  if (zoom > 0.0001 && e == -1 || zoom < 1000 && e == 1) {
    zoom *= pow(1.1, e);
    camSpeed /= pow(1.1, e);
  }
}

void mouseDragged() {
  if (draggingLegeme != null && skærm == editorSkærm) {
    // Convert mouse coordinates to world coordinates
    double mx = mouseX - width / 2;
    double my = mouseY - height / 2;
    double cosR = cos(-camRot);
    double sinR = sin(-camRot);
    double rotx = mx * cosR - my * sinR;
    double roty = mx * sinR + my * cosR;
    double globalX = rotx / zoom + camX;
    double globalY = roty / zoom + camY;
    
    // Update the legeme position with the offset
    draggingLegeme.x = globalX + dragOffsetX;
    draggingLegeme.y = globalY + dragOffsetY;
  }
}

void mouseReleased() {
  // Stop dragging
  draggingLegeme = null;
}
