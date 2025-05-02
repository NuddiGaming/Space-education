//Alt vores grafik lol
void simulationGrafik() {
  background(0);
  //Tegner stjernerne før zoom fordi deres størrelse ændres ikke ved en zoom på de størrelsesordner i brug i programmet
  for (Stjerne S : stjerner) {
    S.tegnStjerne();
  }
  pushMatrix();
  //Zoom
  translate(width/2, height/2);
  scale(zoom);
  rotate(camRot);
  raket.tegnRaket();
  for (PhysicsObject obj : physicsObjects) {
    obj.tegn();
  }
  if (zoomConstrain == false || skærm==editorSkærm) {
    for (Legeme legeme : legemer) {
      legeme.tegn();
    }
  } else {
    tegnFlatWorld();
  }
  for (int i=0;i<smokes.size();i++){
    explosionSmoke smoke = smokes.get(i);
    smoke.tegn();
  }
  popMatrix();
  tegnHud();
  resetMatrix();
  if(zoom < 0.8 && skærm!=editorSkærm){
    tegnPil(new Punkt(width/2, height/2), 100, 30, 30, raket.rot, color(255, 0, 0, (1-(zoom-0.1)/(0.8-0.1))*255));
  }
}

void hovedMenu() {

  //Gør baggrunden mørkere
  fill(0, 150);
  rect(0, 0, width, height);
  fill(255);
  textSize(100);
  textAlign(CENTER);
  text("space simulator", width/2, height/7);
}

//opretter knapperne
Knap hovedMenuStartKnap;
Knap hovedMenuEditorKnap;
PauseKnap simulationsHovedMenuKnap;
PauseKnap editorTilbageKnap;
Knap editorRocketKnap;
Knap editorUniverseKnap;
Knap tilføjPlanetKnap;

void setupKnapper() {
  //kommer værdierne på knapperne
  hovedMenuStartKnap = new Knap(width/3-width/16, height/2-height/5, width/8, height/8, color(0, 0, 0), "Start",
    40, color(0, 255, 0), color(255, 0, 0), color(0, 0, 255), 0, hovedMenu);
  knapper.add(hovedMenuStartKnap);
  hovedMenuEditorKnap = new Knap(width/3*2-width/16, height/2-height/5, width/8, height/8, color(0, 0, 0), "Editor",
    40, color(0, 255, 0), color(255, 0, 0), color(0, 0, 255), 0, hovedMenu);
  knapper.add(hovedMenuEditorKnap);
  simulationsHovedMenuKnap = new PauseKnap(height/50, height/50, height/15*2, width/16, color(0, 0, 0), "",
    10, color(255), color(0, 255, 0), color(0, 0, 255), 0, simulationKører);
  knapper.add(simulationsHovedMenuKnap);
  editorTilbageKnap = new PauseKnap(height/50, height/50, height/15*2, width/16, color(0, 0, 0), "",
    10, color(255), color(0, 255, 0), color(0, 0, 255), 0, editorSkærm);
  knapper.add(editorTilbageKnap);
  editorRocketKnap = new Knap(width - width/8 - width/50, height/50, width/8, height/16, color(0, 0, 0), "Rocket",
    20, color(0, 150, 255), color(100, 200, 255), color(0, 100, 200), 10, editorSkærm);
  knapper.add(editorRocketKnap);
  editorUniverseKnap = new Knap(width - width/8 - width/50, height/50 + height/14, width/8, height/16, color(0, 0, 0), "Universe",
    20, color(0, 150, 255), color(100, 200, 255), color(0, 100, 200), 10, editorSkærm);
  knapper.add(editorUniverseKnap);
  tilføjPlanetKnap = new Knap(width - width/8 - width/50, height/50 + height/14*2, width/8, height/16, color(0, 0, 0), "Add Planet",
    20, color(50, 200, 50), color(100, 255, 100), color(0, 150, 0), 10, editorSkærm);
  knapper.add(tilføjPlanetKnap);
}


void setupStjerner(int antal) {
  //Sørger for at man kan bestemme hvor mange stjerner der skal laves
  for (int i=0; i<antal; i++) {
    //vælger tilfældigt mellem tallene 0, 1 og 2
    int værdi=floor(random(2.999));
    color farve=color(255);
    // bruger det tilfældige tal til at finde en specifik farve mellem de tre kategorier
    if (værdi==0) {
      //Hvid
      farve=color(random(230, 255), random(230, 255), random(230, 255));
    } else if (værdi==1) {
      //Rød
      farve=color(random(230, 255), random(180, 200), random(180, 200));
    } else if (værdi==2) {
      //Blå
      farve=color(random(200, 220), random(200, 220), random(230, 255));
    }
    //Laver stjernen
    Stjerne stjerne =new Stjerne(random(width), random(height), random(5), farve);
    //Tilføjer stjernerne til en liste til brug når de skal tegnes
    stjerner.add(stjerne);
  }
}

void tegnHud() {
  tegnHudDel("Hastighed", "m/s", (float)(Math.sqrt(Math.pow(raket.vX, 2)+Math.pow(raket.vY, 2))), width/4*3, height-height/20*4);
  tegnHudDel("MotorKraft", "%", (float)(raket.brændMængde*100), width/4*3, height-height/20*3);
  if (raket.resulterendeKraft!=null) {
    tegnHudDel("Resulterende kraft", "N", (float)(raket.resulterendeKraft.størrelse()), width/4*3, height-height/20*2);
  } else {
    tegnHudDel("Resulterende kraft", "N", 9.82, width/4*3, height-height/20*2);
  }
  tegnHudDel("Tids scaling", "s/s", timestep, width/4*3, height-height/20*1);
}

void tegnHudDel(String Titel, String enhed, float værdi, float posX, float posY) {
  rectMode(CORNER);
  fill(60);
  stroke(30);
  strokeWeight(3);
  rect(posX, posY, width/4, height/20, 5, 5, 0, 0);
  textAlign(CORNER, CENTER);
  textSize(30);
  fill(0);
  text(Titel+": "+int(værdi)+enhed, posX+10, posY+height/40);
}

// Tegner et fladt udsnit af planetens overflade lige under raketten
void tegnFlatWorld() {
  // Raket og planet pos
  double rocketX = raket.massemidtpunkt.rotate(raket.rotationspunkt, raket.rot).x + raket.x;
  double rocketY = raket.massemidtpunkt.rotate(raket.rotationspunkt, raket.rot).y + raket.y;

  double planetX = zoomLegeme.x;
  double planetY = zoomLegeme.y;

  // Afstand og normalvektor
  double dx   = planetX - rocketX;
  double dy   = planetY - rocketY;
  double dist = Math.hypot(dx, dy);

  if (dist == 0) return;
  double ux = dx / dist;
  double uy = dy / dist;

  // Skæringspunkt
  double planeDistance = dist - zoomLegeme.radius;
  if (planeDistance < 0) planeDistance = 0;

  double planeCenterX = rocketX + ux * planeDistance;
  double planeCenterY = rocketY + uy * planeDistance;

  // Rotation af rect/quad
  double angleToPlane = Math.atan2(planeCenterY - planetY, planeCenterX - planetX);
  double angleDeg     = Math.toDegrees(angleToPlane);

  // Matematik osv. til at tegne rect/quad
  pushStyle();
  fill(zoomLegeme.farve);
  noStroke();

  float halfWidth = (float) (zoomLegeme.radius / 190.0);
  float thickness = (float) (zoomLegeme.radius / 190.0);


  double perpX = Math.cos(angleToPlane + Math.PI / 2.0);
  double perpY = Math.sin(angleToPlane + Math.PI / 2.0);
  double dirX  = Math.cos(angleToPlane);
  double dirY  = Math.sin(angleToPlane);

  double[][] local = {{-halfWidth, 0}, { halfWidth, 0}, { halfWidth, -thickness}, {-halfWidth, -thickness}};

  float[] sx = new float[4];
  float[] sy = new float[4];

  for (int i = 0; i < 4; i++) {
    double lx = local[i][0];
    double ly = local[i][1];

    double wx = planeCenterX + perpX * lx + dirX * ly;
    double wy = planeCenterY + perpY * lx + dirY * ly;

    sx[i] = (float) (wx - camX);
    sy[i] = (float) (wy - camY);
  }

  // Tegner skæringspunkt og rect/quad
  float dotSize = 10 / zoom;
  //circle((float) (planeCenterX - camX), (float) (planeCenterY - camY), dotSize);
  quad(sx[0], sy[0], sx[1], sy[1], sx[2], sy[2], sx[3], sy[3]);

  popStyle();
}
