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
      x = x/størrelse*camSpeed;
      y = y/størrelse*camSpeed;
    }
    //tilføj fart
    camX += x;
    camY += y;
  } else {
    //sæt kameraet på raketen
    camX = lerp(camX, raket.x, 0.1);
    camY = lerp(camY, raket.y, 0.1);
  }
  if (skærm==simulationKører) {
    if (j) {
      raket.rotHast -= 0.001;
    } else if (l) {
      raket.rotHast += 0.001;
    }
    raket.rot += raket.rotHast;
  }
}

//input...
void keyPressed() {
  if (activeField != null) {
    // Tjekker om det er slet man klikker på
    if (key == BACKSPACE && activeField.tekst.length() > 0) {
      activeField.tekst = activeField.tekst.substring(0, activeField.tekst.length() - 1);
    }
    // Normale tryk. Skal være normale keys, ikke backspace og ikke enter.
    else if (key != CODED && key != BACKSPACE && key != ENTER) {
      activeField.tekst += key;
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
  if(SimulationsHovedMenuKnap.mouseOverUdenTransform() && ((skærm==simulationKører)||(skærm==simulationPauset))){
    skærm=hovedMenu;
  }
  for (Textfield field : textfields) {
    if (field.mouseOver()) {
      if (activeField != null) {
        activeField.deactivate(); // Deactivater alle felter hvis 'activeField' ikke er sat
      }
      field.activate(); // Activater det field man klikker på
      return;
    }
  }
  if (activeField != null) {
    activeField.deactivate();
    activeField = null;
  }
}

//ændre zoom værdien når man skrållar med musen
void mouseWheel(MouseEvent event) {
  float e = -event.getCount();
  zoom *= pow(1.1, e);
  camSpeed /= pow(1.1, e);
}
