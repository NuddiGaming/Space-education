boolean w = false;
boolean a = false;
boolean s = false;
boolean d = false;
boolean j = false;
boolean l = false;

boolean brænder = false;

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
    camX = raket.x-raket.rotationspunkt.x-((raket.massemidtpunkt.x-raket.rotationspunkt.x) * cos(raket.rot) - (raket.massemidtpunkt.y-raket.rotationspunkt.y) * sin(raket.rot));
    camY = raket.y-raket.rotationspunkt.y-((raket.massemidtpunkt.x-raket.rotationspunkt.x) * sin(raket.rot) + (raket.massemidtpunkt.y-raket.rotationspunkt.y) * cos(raket.rot));
  }
}

//input...
void keyPressed() {
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

//ændre zoom værdien når man skrållar med musen
void mouseWheel(MouseEvent event) {
  float e = -event.getCount();
  if (zoom > 0.0001 && e == -1 || zoom < 1000 && e == 1) {
    zoom *= pow(1.1, e);
    camSpeed /= pow(1.1, e);
  }
}
