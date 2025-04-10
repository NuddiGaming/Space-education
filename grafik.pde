//Alt vores grafik lol
void simulationGrafik() {
  background(0);
  //Tegner stjernerne før zoom fordi deres størrelse ændres ikke ved en zoom på de størrelsesordner i brug i programmet
  for (Stjerne S : stjerner) {
    S.tegnStjerne();
  }
  //Zoom
  translate(width/2, height/2);
  scale(zoom);
  rotate(camRot);
  //tegnGrid();
  raket.tegnRaket();
  jorden.tegn();
  måne.tegn();
}

void tegnGrid() {
  stroke(60);
  strokeWeight(2/zoom);
  //lav alle de lodrette linjer
  for (double x=camX-width/2/zoom; x<=camX+width/2/zoom; x++) {
    if (Math.round(x) % ceil(gridDist/zoom) == 0) {
      line((float)(x-camX), -height/2/zoom, (float)(x-camX), height/2/zoom);
    }
  }
  //lav alle de vandrette linjer
  for (double y=camY-height/2/zoom; y<=camY+height/2/zoom; y++) {
    if (Math.round(y) % ceil(gridDist/zoom) == 0) {
      line(-width/2/zoom, (float)(y-camY), width/2/zoom, (float)(y-camY));
    }
  }
  //Lav linjerne der viser x og y aksen
  strokeWeight(3);
  stroke(0, 255, 0);
  //line(gridDist*round(gridSize/gridDist/2)-camX, 0-camY, gridDist*round(gridSize/gridDist/2)-camX, gridSize-camY);
  stroke(255, 0, 0);
  //line(0-camX, gridDist*round(gridSize/gridDist/2)-camY, gridSize-camX, gridDist*round(gridSize/gridDist/2)-camY);
  strokeWeight(2);
  stroke(0);
}

void hovedMenu() {
  //Gemmer den nuværende translation scale og rotation
  pushMatrix(); 
  //Går tilbage til den standard af disse
  resetMatrix();
  
  //Gør baggrunden mørkere
  fill(0, 150);
  rect(0, 0, width, height); 
  
  // Går tilbage til den tidligere translation scale og rotation
  popMatrix();
}

Knap hovedMenuStartKnap;
Knap hovedMenuEditorKnap;

void setupKnapper() {
  hovedMenuStartKnap = new Knap(width/3,height/2, width/16, height/16, color(0,0,0),"Start",
    10, color(0,255,0),color(255,0,0),color(0,0,255),0,hovedMenu);
  knapper.add(hovedMenuStartKnap);
   hovedMenuEditorKnap = new Knap(width/3*2,height/2, width/16, height/16, color(0,0,0),"Editor",
    10, color(0,255,0),color(255,0,0),color(0,0,255),0,hovedMenu);
  knapper.add(hovedMenuEditorKnap);
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
