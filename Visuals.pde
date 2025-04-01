void tegnRaket(float x, float y, float phi, boolean tændt) {
  pushMatrix();
  translate(x, y);
  rotate(phi);
  fill(255, 0, 0);
  arc(0, -height/6, width/15*2, height/3, 0, PI*2);
  fill(150);
  rect(-width/15, -height/6, width/15*2, height/3);
  fill(100, 100, 255);
  circle(0, -height/15, width/18);
  fill(75);
  beginShape();
  vertex(-width/15, height/6);
  vertex(width/15, height/6);
  vertex(width/20, height/4);
  vertex(-width/20, height/4);
  endShape(CLOSE);
  fill(100);
  beginShape();
  vertex(width/15, height/14);
  vertex(width/8, height/7*2);
  vertex(width/15, height/6);
  endShape(CLOSE);
  beginShape();
  vertex(-width/15, height/14);
  vertex(-width/8, height/7*2);
  vertex(-width/15, height/6);
  endShape(CLOSE);
  if (tændt) {
    noStroke();
    fill(252, 164, 48);
    arc(0, height/4, width/15, height/3, 0, PI, CHORD);
    fill(245, 215, 24);
    arc(0, height/4, width/30, height/6, 0, PI, CHORD);
  }
  popMatrix();
}
