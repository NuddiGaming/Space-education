boolean w = false;
boolean a = false;
boolean s = false;
boolean d = false;
boolean j = false;
boolean k = false;
boolean l = false;
boolean shift = false;
boolean ctrl = false;

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
  if (skærm == simulationKører) {
    if (shift) {
      raket.brændMængde += 1*delta;
      if (raket.brændMængde > 1) raket.brændMængde = 1;
    }
    if (ctrl) {
      raket.brændMængde -= 1*delta;
      if (raket.brændMængde < 0) raket.brændMængde = 0;
    }
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
      } else if (skærm==simulationPauset) {
        skærm=simulationKører;
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
    if (key == ' ' && skærm == simulationKører) {
      raket.brændMængde = 1;
    }
    if (key == 'x' && skærm == simulationKører) {
      raket.brændMængde = 0;
    }
    if (keyCode == CONTROL) {
      ctrl = true;
    }
    if (keyCode == SHIFT) {
      shift = true;
    }
    if (key == 'j') {
      j = true;
    }
    if (key == 'k'){
      k = true;
      tempRaketRot = raket.rotHast;
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
    if (key == '0'){
      saveScenario("save");
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
  if (keyCode == CONTROL) {
    ctrl = false;
  }
  if (keyCode == SHIFT) {
    shift = false;
  }
  if (key == 'j') {
    j = false;
  }
  if (key == 'k'){
    k = false;
  }
  if (key == 'l') {
    l = false;
  }
}

void mousePressed() {
  if (hovedMenuStartKnap.mouseOverUdenTransform()) {
    skærm=simulationKører;
  }
  if (SimulationsHovedMenuKnap.mouseOverUdenTransform() && ((skærm==simulationKører)||(skærm==simulationPauset))) {
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
  if (zoom > 0.0001 && e == -1 || zoom < 1000 && e == 1) {
    if (zoomConstrain == true){
      if (zoom > zoomLegeme.radius/20000000) {
        zoom *= pow(1.1, e);
        camSpeed /= pow(1.1, e);
        zoom = constrain(zoom, (float) zoomLegeme.radius/20000000, 1000);
      }
      else if (zoom <= zoomLegeme.radius/20000000 && e == 1){
        zoom *= pow(1.1, e);
        camSpeed /= pow(1.1, e);
        zoom = constrain(zoom, (float) zoomLegeme.radius/20000000, 1000);
      }
    }
    else{
      zoom *= pow(1.1, e);
      camSpeed /= pow(1.1, e);
    }
  }
}
