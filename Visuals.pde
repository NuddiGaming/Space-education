void tegnRaket(float x, float y, float phi, boolean tændt) {
  //x og y angiver koordinaterne af centerpunktet
  //phi angiver rotation og en hel omgang er 2 pi
  //tændt angiver om raket exhaust vises
  strokeWeight(3);
  stroke(0);
  pushMatrix();
  //flytter og roterer raketten
  translate(x, y);
  rotate(phi);
  //tegner toppen
  fill(255, 0, 0);
  arc(0, -height/6, width/15*2, height/3, 0, PI*2);
  //tegner kroppen
  fill(150);
  rect(-width/15, -height/6, width/15*2, height/3);
  //tegner vinduet
  fill(100, 100, 255);
  circle(0, -height/15, width/18);
  //tegner raket motoren
  fill(75);
  beginShape();
  vertex(-width/15, height/6);
  vertex(width/15, height/6);
  vertex(width/20, height/4);
  vertex(-width/20, height/4);
  endShape(CLOSE);
  //tegner den højre finne
  fill(100);
  beginShape();
  vertex(width/15, height/14);
  vertex(width/8, height/7*2);
  vertex(width/15, height/6);
  endShape(CLOSE);
  //tegner den venstre finne
  beginShape();
  vertex(-width/15, height/14);
  vertex(-width/8, height/7*2);
  vertex(-width/15, height/6);
  endShape(CLOSE);
  //hvis motoren kører vises exhaust
  if (tændt) {
    noStroke();
    //tegner ydre exhaust
    fill(252, 164, 48);
    arc(0, height/4, width/15, height/3, 0, PI, CHORD);
    //tegner indre exhaust
    fill(245, 215, 24);
    arc(0, height/4, width/30, height/6, 0, PI, CHORD);
  }
  popMatrix();
}
