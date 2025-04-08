class Raket {
  float højde = 20;
  float bredde = 5;
  //position
  float x = gridSize/2;
  float y = gridSize/2;
  //massemidpunkt position
  float mX = 0;
  float mY = højde/2;
  
  float masse = 20000;
  
  float motorKraft = 10000;
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
    //tjek om motoren brænder og hvis ja så tilføj motorkraften i krafter
    if(brænder){
      krafter.add(new Kraft(motorKraft*sin(rot), -motorKraft*cos(rot), 0, 0));
    }
    //primitiv tyngdekraft funktionalitet
    float tyngdekraft = 0.1*masse;
    krafter.add(new Kraft(0, tyngdekraft, mX, mY));
    
    //her tilføjes alle kræfter
    for(Kraft kraft : krafter){
      //jeg finder vektoren der peger fra påvirkningspunktet til massemidtpunktet
      float dX = (kraft.pX-mX) * cos(rot) - (kraft.pY-mY) * sin(rot);
      float dY = (kraft.pX-mX) * sin(rot) + (kraft.pY-mY) * cos(rot);
      //find distancen til massemidtpunkt
      float dist = sqrt(pow(dX, 2) + pow(dY, 2));
      //regn vinklen mellem kraftvektoren og vektoren der peger mod massemidtpunkt
      float v = acos((kraft.x*dX + kraft.y*dY) / (kraft.størrelse()*dist));
      //sikrer at v ikke er lig NaN
      if(v != v){
        v = 0;
      }
      //tilføj kraften på hastigheden
      vX += kraft.x/masse*abs(cos(v));
      vY += kraft.y/masse*abs(cos(v));
      //find determinanten
      float det = dX*kraft.y - dY*kraft.x;
      
      //hvis determinanten er negativ så er kraft vektoren med uret rundt om vektoren der peger mod massemidtpunktet og derfor skal raketen rotere mod uret rundt, basic stuff lol B)
      if(det < 0){
        rotHast += kraft.størrelse()/masse*abs(sin(v))/20;
      } else{ //og hvis den er positiv så er det omvendt
        rotHast -= kraft.størrelse()/masse*abs(sin(v))/20;
      }
    }
    //tilføj hastigheden på x og y
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
    vertex(0+mX, -højde*vingeProcent + højde*0.1+mY);
    vertex(-bredde*0.5+mX, -højde*vingeProcent + højde*0.1+mY);
    vertex(-bredde*0.8+mX, -højde*vingeProcent*0.1 + højde*0.1+mY);
    vertex(-bredde*0.8+mX, højde*0.1+mY);
    vertex(-bredde*0.8+mX, højde*0.1+mY);
    endShape(CLOSE);
    beginShape();
    vertex(0+mX, -højde*vingeProcent + højde*0.1+mY);
    vertex(bredde*0.5+mX, -højde*vingeProcent + højde*0.1+mY);
    vertex(bredde*0.8+mX, -højde*vingeProcent*0.1 + højde*0.1+mY);
    vertex(bredde*0.8+mX, højde*0.1+mY);
    vertex(bredde*0.8+mX, højde*0.1+mY);
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
    strokeWeight(bredde/8);
    line(bredde*0.35+mX, -højde*bundProcent - højde*abs(topProcent-bundProcent)*0.1+mY, bredde*0.35+mX, -højde*bundProcent - højde*abs(topProcent-bundProcent)*0.7+mY);
    stroke(0);
    strokeWeight(2);
    noStroke();
    
    //tegn rude
    fill(100, 100, 255);
    circle(0+mX, -højde*bundProcent - højde*abs(topProcent-bundProcent)*(4.0/5.0)+mY, bredde*0.4);
    
    //tegn flammer hvis moteren brænder
    if ((brænder && skærm==simulationKører)||pauseBrænder) {
      //tegner ydre exhaust
      fill(252, 164, 48);
      arc(0+mX, 0+mY, bredde*0.8, bredde*2, 0, PI);
      //tegner indre exhaust
      fill(245, 215, 24);
      arc(0+mX, 0+mY, bredde*0.5, bredde*1.2, 0, PI);
    }
    
    //tegn massemidtpunkt indikatoren
    fill(255, 255, 0);
    circle(0, 0, bredde/3);
    fill(0);
    arc(0, 0, bredde/3, bredde/3, 0, PI/2);
    arc(0, 0, bredde/3, bredde/3, PI, 1.5*PI);
    popMatrix();
  }
}
