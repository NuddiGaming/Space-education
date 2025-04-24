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
  raket.tegnRaket();
  jorden.tegn();
  måne.tegn();
  tegnHud();
}

void hovedMenu() {
  //Gemmer den nuværende translation scale og rotation
  pushMatrix(); 
  //Går tilbage til den standard af disse
  resetMatrix();
  
  //Gør baggrunden mørkere
  fill(0, 150);
  rect(0, 0, width, height); 
  fill(255);
  textSize(100);
  textAlign(CENTER);
  text("space simulator",width/2,height/7);
  
  // Går tilbage til den tidligere translation scale og rotation
  popMatrix();
}

Knap hovedMenuStartKnap;
Knap hovedMenuEditorKnap;
PauseKnap simulationsHovedMenuKnap;
PauseKnap editorTilbageKnap;

void setupKnapper() {
  hovedMenuStartKnap = new Knap(width/3-width/16,height/2-height/5, width/8, height/8, color(0,0,0),"Start",
    40, color(0,255,0),color(255,0,0),color(0,0,255),0,hovedMenu);
  knapper.add(hovedMenuStartKnap);
   hovedMenuEditorKnap = new Knap(width/3*2-width/16,height/2-height/5, width/8, height/8, color(0,0,0),"Editor",
    40, color(0,255,0),color(255,0,0),color(0,0,255),0,hovedMenu);
  knapper.add(hovedMenuEditorKnap);
  simulationsHovedMenuKnap = new PauseKnap(height/50,height/50, width/16, width/16, color(0,0,0),"",
    10, color(255),color(0,255,0),color(0,0,255),0,simulationKører);
  knapper.add(simulationsHovedMenuKnap);
  editorTilbageKnap = new PauseKnap(height/50,height/50, width/16, width/16, color(0,0,0),"",
    10, color(255),color(0,255,0),color(0,0,255),0,editorSkærm);
  knapper.add(editorTilbageKnap);
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

void tegnHud(){
  //Gemmer den nuværende translation scale og rotation
  pushMatrix(); 
  //Går tilbage til den standard af disse
  resetMatrix();
  tegnHudDel("Hastighed","m/s",(float)(Math.sqrt(Math.pow(raket.vX,2)+Math.pow(raket.vY,2))),width/4*3,height-height/20*4);
  tegnHudDel("MotorKraft","%",int(brænder)*100,width/4*3,height-height/20*3);
  if(raket.resulterendeKraft!=null){
    tegnHudDel("Resulterende kraft","N",(float)(raket.resulterendeKraft.størrelse()),width/4*3,height-height/20*2);
  } else{
    tegnHudDel("Resulterende kraft","N",9.82,width/4*3,height-height/20*2);
  }
   tegnHudDel("Tids scaling","s/s",timestep,width/4*3,height-height/20*1);
  
  popMatrix();
}

void tegnHudDel(String Titel,String enhed, float værdi,float posX,float posY){
  rectMode(CORNER);
  fill(60);
  stroke(30);
  strokeWeight(3);
  rect(posX,posY,width/4,height/20,5,5,0,0);
  textAlign(CORNER,CENTER);
  textSize(30);
  fill(0);
  text(Titel+": "+int(værdi)+enhed,posX+10,posY+height/40);
}

void editorSkærm(){
  //Gemmer den nuværende translation scale og rotation
  pushMatrix(); 
  //Går tilbage til den standard af disse
  resetMatrix();
  
  //Gør baggrunden mørkere
  fill(0, 150);
  rect(0, 0, width, height); 
  fill(255);
  textSize(100);
  textAlign(CENTER);
  text("Raket editor",width/2,height/7);
  
  // Går tilbage til den tidligere translation scale og rotation
  popMatrix();
}

void startMenu(Legeme legeme){
 menuX=mouseX;
 menuY=mouseY;
 visMenu=true;
 VisesIMenu=legeme;
 legeme.navnField.posX=menuX+width/100;
 legeme.navnField.posY=menuY+width/100;
 legeme.navnField.active=true;
 legeme.masseField.posX=menuX+width/100;
 legeme.masseField.posY=menuY+2*height/100+legeme.masseField.sizeY;
 legeme.masseField.active=true;
 legeme.radiusField.posX=menuX+width/100;
 legeme.radiusField.posY=menuY+3*height/100+legeme.radiusField.sizeY;
 legeme.radiusField.active=true;
}

void tegnMenu(Legeme legeme){
 pushMatrix();
 resetMatrix();
 
 //rect(menuX,menuY,
 
 popMatrix();
}
