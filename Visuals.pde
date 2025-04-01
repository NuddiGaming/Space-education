void tegnRaket(float x, float y, float phi, boolean tændt,float højde) {
  //x og y angiver koordinaterne af centerpunktet
  //phi angiver rotation og en hel omgang er 2 pi
  //tændt angiver om raket exhaust vises
  //højde er med til at bestemme størrelsen af rakketen
  
  //bestemmer den standard højde af raketten
  float skala=height/60+height/30+height/35;
  //bruger den standard størrelse og højde til at beregne hvor 
  //mange gange større rakketten skal være end standard
  skala=højde/skala;
  noStroke();
  pushMatrix();
  //flytter og roterer raketten
  translate(x, y);
  rotate(phi);
  //tegner toppen
  fill(255, 0, 0);
  arc(0.52*skala, -height/60*skala, width/75*skala, height/30*skala, 0, PI*2);
  //tegner kroppen
  fill(150);
  rect(-width/150*skala, -height/60*skala, width/75*skala, height/30*skala);
  //tegner vinduet
  fill(100, 100, 255);
  circle(0, -height/150*skala, width/180*skala);
  //tegner raket motoren
  fill(75);
  beginShape();
  vertex(-width/150*skala, height/60*skala);
  vertex(width/150*skala, height/60*skala);
  vertex(width/200*skala, height/40*skala);
  vertex(-width/200*skala, height/40*skala);
  endShape(CLOSE);
  //tegner den højre finne
  fill(100);
  beginShape();
  vertex(width/150*skala+1*skala, height/140*skala);
  vertex(width/80*skala+1*skala, height/35*skala);
  vertex(width/150*skala+1*skala, height/60*skala);
  endShape(CLOSE);
  //tegner den venstre finne
  beginShape();
  vertex(-width/150*skala, height/140*skala);
  vertex(-width/80*skala, height/35*skala);
  vertex(-width/150*skala, height/60*skala);
  endShape(CLOSE);
  //hvis motoren kører vises exhaust
  if (tændt) {
    noStroke();
    //tegner ydre exhaust
    fill(252, 164, 48);
    arc(0, height/40*skala, width/150*skala, height/30*skala, 0, PI, CHORD);
    //tegner indre exhaust
    fill(245, 215, 24);
    arc(0, height/40*skala, width/300*skala, height/60*skala, 0, PI, CHORD);
  }
  popMatrix();
}
