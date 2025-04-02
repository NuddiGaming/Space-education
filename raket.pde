class Raket {
  float højde = 300;
  float bredde = 80;
  //position
  float x = gridSize/2;
  float y = gridSize/2;
  //massemidpunkt position
  float mX = 0;
  float mY = højde/2;
  
  float masse = 1000;
  
  float motorKraft = 1000;
  //hastighed
  float vX = 0;
  float vY = 0;
  //rotation
  float rot = 0;
  float rotHast = 0;
  
  Raket(){
    println("Raket oprettet");
  }
  //fysikken til raketen
  void fysik(){
    ArrayList<Kraft> krafter = new ArrayList<Kraft>();
    if(brænder){
      krafter.add(new Kraft(100*sin(rot), -100*cos(rot), 0, 0));
    }
    //krafter.add(new Kraft(0, 0.1*masse));
    for(Kraft kraft : krafter){
      vX += kraft.x/masse;
      vY += kraft.y/masse;
    }
    x += vX;
    y += vY;
  }
  
  void tegnRaket() {
    pushMatrix();
    
    //flyt raket position til 0, 0
    translate(x-camX, y-camY);
    //rotér raket
    rotate(rot);

    noStroke();
    
    //hvor stor en procentdel hver del fylder af højden
    float topProcent = 0.8;
    float bundProcent = 0.1;
    float vingeProcent = 0.3;
    
    //tegn top delen
    fill(255, 0, 0);
    arc(0+mX, -højde*topProcent+mY, bredde, højde*2*(1-topProcent), PI, 2*PI);
    
    //tegn vinger
    fill(50);
    beginShape();
    vertex(0+mX, -højde*vingeProcent - højde*bundProcent*0.2+mY);
    vertex(-bredde*0.5+mX, -højde*vingeProcent - højde*bundProcent*0.2+mY);
    vertex(-bredde*0.8+mX, -højde*vingeProcent*0.25 - højde*bundProcent*0.2+mY);
    vertex(-bredde*0.8+mX, -højde*bundProcent*0.2+mY);
    vertex(0+mX, -højde*bundProcent*0.2+mY);
    endShape(CLOSE);
    beginShape();
    vertex(0+mX, -højde*vingeProcent - højde*bundProcent*0.2+mY);
    vertex(bredde*0.5+mX, -højde*vingeProcent - højde*bundProcent*0.2+mY);
    vertex(bredde*0.8+mX, -højde*vingeProcent*0.25 - højde*bundProcent*0.2+mY);
    vertex(bredde*0.8+mX, -højde*bundProcent*0.2+mY);
    vertex(0+mX, -højde*bundProcent*0.2+mY);
    endShape(CLOSE);
    
    //tegn bunden
    fill(75);
    beginShape();
    vertex(-bredde/2+mX, -højde*bundProcent+mY);
    vertex(-bredde*0.4+mX, 0+mY);
    vertex(bredde*0.4+mX, 0+mY);
    vertex(bredde/2+mX, -højde*bundProcent+mY);
    endShape(CLOSE);
    
    //tegn hoved delen
    fill(150);
    rect(-bredde/2+mX, -højde*topProcent+mY, bredde, højde*abs(topProcent-bundProcent));
    
    //tegn shine
    stroke(240);
    strokeWeight(5);
    line(bredde*0.35+mX, -højde*bundProcent - højde*abs(topProcent-bundProcent)*0.1+mY, bredde*0.35+mX, -højde*bundProcent - højde*abs(topProcent-bundProcent)*0.7+mY);
    stroke(0);
    strokeWeight(2);
    noStroke();
    
    //tegn rude
    fill(100, 100, 255);
    circle(0+mX, -højde*bundProcent - højde*abs(topProcent-bundProcent)*(4.0/5.0)+mY, bredde*0.4);
    
    //tegn flammer hvis moteren brænder
    if (brænder) {
      //tegner ydre exhaust
      fill(252, 164, 48);
      arc(0+mX, 0+mY, bredde*0.8, bredde*2, 0, PI);
      //tegner indre exhaust
      fill(245, 215, 24);
      arc(0+mX, 0+mY, bredde*0.5, bredde*1.2, 0, PI);
    }
    
    //tegn massemidtpunkt indikatoren
    fill(255, 255, 0);
    circle(0, 0, 10);
    fill(0);
    arc(0, 0, 10, 10, 0, PI/2);
    arc(0, 0, 10, 10, PI, 1.5*PI);
    popMatrix();
  }
}
