class Raket {
  float højde = 20;
  float bredde = 5;
  //hvor stor en procentdel hver del fylder af højden
  float topProcent = 0.8;
  float bundProcent = 0.1;
  float vingeProcent = 0.3;
  float vingeProcentHøjde = 0.4;
  float vingeProcentBredde = 0.4;
  //massemidpunkt position
  Punkt massemidtpunkt = new Punkt(0, højde/2);
  Punkt rotationspunkt = new Punkt(massemidtpunkt.x, massemidtpunkt.y);
  //position
  float x = 0;
  float y = 0;

  float masse = 20000;

  float motorKraft = 1000000;
  //hastighed
  float vX = 0;
  float vY = 0;
  //rotation
  float rot = 0;
  float rotHast = 0;

  int punktMængde = 4;

  ArrayList<Punkt> punkter = new ArrayList<Punkt>();
  Punkt hovedTop = new Punkt(0, -højde);
  Punkt højreSideTop = new Punkt(bredde/2, -højde*topProcent);
  Punkt venstreSideTop = new Punkt(-bredde/2, -højde*topProcent);
  Punkt højreVingeStart = new Punkt(bredde/2, -højde*vingeProcent);
  Punkt højreVingeEnde = new Punkt(bredde/2+bredde*vingeProcentBredde, -højde*vingeProcent+højde*vingeProcentHøjde);
  Punkt venstreVingeStart = new Punkt(-bredde/2, -højde*vingeProcent);
  Punkt venstreVingeEnde = new Punkt(-bredde/2-bredde*vingeProcentBredde, -højde*vingeProcent+højde*vingeProcentHøjde);
  Punkt højreSideBundStart = new Punkt(bredde/2, -højde*bundProcent);
  Punkt højreSideBundEnde = new Punkt(bredde*0.4, 0);
  Punkt venstreSideBundStart = new Punkt(-bredde/2, -højde*bundProcent);
  Punkt venstreSideBundEnde = new Punkt(-bredde*0.4, 0);
  Raket() {
    println("Raket oprettet");
    Linje l1 = new Linje(højreVingeEnde, new Punkt(0, højreVingeStart.y*0.8));
    Linje l2 = new Linje(højreSideTop, højreSideBundStart);
    Punkt s = skæringspunkt(l1, l2);
    if (s.y < højreSideBundStart.y) {
      punkter.add(højreSideBundStart);
    }
    l1 = new Linje(venstreVingeEnde, new Punkt(0, venstreVingeStart.y*0.8));
    l2 = new Linje(venstreSideTop, venstreSideBundStart);
    s = skæringspunkt(l1, l2);
    if (s.y < venstreSideBundStart.y) {
      punkter.add(venstreSideBundStart);
    }
    for (int i=0; i<=punktMængde; i++) {
      punkter.add(new Punkt(højreSideTop.x, højreVingeStart.y+(højreSideTop.y-højreVingeStart.y)*i/punktMængde));
      punkter.add(new Punkt(venstreSideTop.x, venstreVingeStart.y+(venstreSideTop.y-venstreVingeStart.y)*i/punktMængde));
      if (i > 0) {
        l1 = new Linje(højreVingeStart, højreVingeEnde);
        l2 = new Linje(venstreVingeStart, venstreVingeEnde);
        punkter.add(new Punkt(højreVingeStart.x+l1.længdeX()*i/punktMængde, højreVingeStart.y+l1.a()*l1.længdeX()*i/punktMængde));
        punkter.add(new Punkt(venstreVingeStart.x+l2.længdeX()*i/punktMængde, venstreVingeStart.y+l2.a()*l2.længdeX()*i/punktMængde));
        if(i < punktMængde){
          punkter.add(new Punkt(hovedTop.x+cos(PI*i/punktMængde)*bredde/2, -højde*topProcent-sin(PI*i/punktMængde)*højde*(1-topProcent)));
        }
      }
    }
    punktMængde = round(punktMængde*0.5);
    for (int i=0; i<=punktMængde; i++) {
      punkter.add(new Punkt(højreSideBundEnde.x+(venstreSideBundEnde.x-højreSideBundEnde.x)*i/punktMængde, højreSideBundEnde.y));
      if (i > 0) {
        l1 = new Linje(højreVingeEnde, new Punkt(0, højreVingeStart.y*0.8));
        l2 = new Linje(højreSideBundStart, højreSideBundEnde);
        s = skæringspunkt(l1, l2);
        l1 = new Linje(højreVingeEnde, s);
        punkter.add(new Punkt(højreVingeEnde.x+l1.længdeX()*i/punktMængde, højreVingeEnde.y+l1.a()*l1.længdeX()*i/punktMængde));
        l1 = new Linje(venstreVingeEnde, new Punkt(0, venstreVingeStart.y*0.8));
        l2 = new Linje(venstreSideBundStart, venstreSideBundEnde);
        s = skæringspunkt(l1, l2);
        l1 = new Linje(venstreVingeEnde, s);
        punkter.add(new Punkt(venstreVingeEnde.x+l1.længdeX()*i/punktMængde, venstreVingeEnde.y+l1.a()*l1.længdeX()*i/punktMængde));
      }
    }
  }
  //fysikken til raketen
  void fysik() {
    //rotation input
    if (j) {
      raket.rotHast -= 0.1;
    } else if (l) {
      raket.rotHast += 0.1;
    }

    ArrayList<Kraft> krafter = new ArrayList<Kraft>();
    //tjek om motoren brænder og hvis ja så tilføj motorkraften i krafter
    if (brænder) {
      krafter.add(new Kraft(motorKraft*sin(rot), -motorKraft*cos(rot), new Punkt(0, 0)));
    }
    //tyngdekraft funktionalitet
    for (Legeme legeme : legemer) {
      float dX = abs(legeme.x-x);
      float dY = abs(legeme.y-y);
      float dist = sqrt(pow(dX, 2)+pow(dY, 2));
      float tyngdekraft = g*legeme.masse*masse/pow(dist, 2);
      float rX = dX/dist;
      float rY = dY/dist;
      println(tyngdekraft/masse);
      krafter.add(new Kraft(rX*tyngdekraft, rY*tyngdekraft, new Punkt(massemidtpunkt.x, massemidtpunkt.y)));
    }

    //her tilføjes alle kræfter
    for (Kraft kraft : krafter) {
      //jeg finder vektoren der peger fra påvirkningspunktet til massemidtpunktet
      float dX = (kraft.p.x-massemidtpunkt.x) * cos(rot) - (kraft.p.y-massemidtpunkt.y) * sin(rot);
      float dY = (kraft.p.x-massemidtpunkt.x) * sin(rot) + (kraft.p.y-massemidtpunkt.y) * cos(rot);
      //find distancen til massemidtpunkt
      float dist = sqrt(pow(dX, 2) + pow(dY, 2));
      //regn vinklen mellem kraftvektoren og vektoren der peger mod massemidtpunkt
      float v = acos((kraft.x*dX + kraft.y*dY) / (kraft.størrelse()*dist));
      //sikrer at v ikke er lig NaN
      if (v != v) {
        v = 0;
      }
      //tilføj kraften på hastigheden
      vX += kraft.x/masse*abs(cos(v))*delta;
      vY += kraft.y/masse*abs(cos(v))*delta;
      //find determinanten
      float det = dX*kraft.y - dY*kraft.x;

      //hvis determinanten er negativ så er kraft vektoren med uret rundt om vektoren der peger mod massemidtpunktet og derfor skal raketen rotere mod uret rundt, basic stuff lol B)
      if (det < 0) {
        rotHast += kraft.størrelse()/masse*abs(sin(v))/20*delta;
      } else { //og hvis den er positiv så er det omvendt
        rotHast -= kraft.størrelse()/masse*abs(sin(v))/20*delta;
      }
    }
    //tilføj hastigheden på x og y
    x += vX*delta;
    y += vY*delta;
    rot += rotHast*delta;
  }

  void tegnRaket() {
    pushMatrix();

    //flyt raket position til 0, 0
    translate(x-camX-rotationspunkt.x, y-camY-rotationspunkt.y);
    //rotér raket
    rotate(rot);

    noStroke();

    //tegn top delen
    fill(255, 0, 0);
    arc(hovedTop.x+rotationspunkt.x, højreSideTop.y+rotationspunkt.y, bredde, -(hovedTop.y-højreSideTop.y)*2, PI, 2*PI);
    //tegn vinger
    fill(50);
    beginShape();
    vertex(venstreVingeStart.x+rotationspunkt.x, venstreVingeStart.y+rotationspunkt.y);
    vertex(venstreVingeEnde.x+rotationspunkt.x, venstreVingeEnde.y+rotationspunkt.y);
    vertex(0+rotationspunkt.x, venstreVingeStart.y*0.8+rotationspunkt.y);
    vertex(højreVingeEnde.x+rotationspunkt.x, højreVingeEnde.y+rotationspunkt.y);
    vertex(højreVingeStart.x+rotationspunkt.x, højreVingeStart.y+rotationspunkt.y);
    endShape(CLOSE);

    //tegn bunden
    fill(75);
    beginShape();
    vertex(venstreSideBundStart.x+rotationspunkt.x, venstreSideBundStart.y+rotationspunkt.y);
    vertex(venstreSideBundEnde.x+rotationspunkt.x, venstreSideBundEnde.y+rotationspunkt.y);
    vertex(højreSideBundEnde.x+rotationspunkt.x, højreSideBundEnde.y+rotationspunkt.y);
    vertex(højreSideBundStart.x+rotationspunkt.x, højreSideBundStart.y+rotationspunkt.y);
    endShape(CLOSE);

    //tegn hoved delen
    fill(150);
    beginShape();
    vertex(højreSideTop.x+rotationspunkt.x, højreSideTop.y+rotationspunkt.y);
    vertex(højreSideBundStart.x+rotationspunkt.x, højreSideBundStart.y+rotationspunkt.y);
    vertex(venstreSideBundStart.x+rotationspunkt.x, venstreSideBundStart.y+rotationspunkt.y);
    vertex(venstreSideTop.x+rotationspunkt.x, venstreSideTop.y+rotationspunkt.y);
    endShape(CLOSE);

    //tegn shine
    stroke(240);
    strokeWeight(bredde/8);
    line(bredde*0.35+rotationspunkt.x, -højde*bundProcent - højde*abs(topProcent-bundProcent)*0.1+rotationspunkt.y, bredde*0.35+rotationspunkt.x, -højde*bundProcent - højde*abs(topProcent-bundProcent)*0.7+rotationspunkt.y);
    stroke(0);
    strokeWeight(2);
    noStroke();

    //tegn rude
    fill(100, 100, 255);
    circle(0+rotationspunkt.x, -højde*bundProcent - højde*abs(topProcent-bundProcent)*(4.0/5.0)+rotationspunkt.y, bredde*0.4);

    //tegn flammer hvis moteren brænder
    if (brænder) {
      //tegner ydre exhaust
      fill(252, 164, 48);
      arc(0+rotationspunkt.x, 0+rotationspunkt.y, bredde*0.8, bredde*2, 0, PI);
      //tegner indre exhaust
      fill(245, 215, 24);
      arc(0+rotationspunkt.x, 0+rotationspunkt.y, bredde*0.5, bredde*1.2, 0, PI);
    }

    fill(0, 255, 0);
    for (Punkt p : punkter) {
      circle(p.x+rotationspunkt.x, p.y+rotationspunkt.y, bredde/10);
    }
    //tegn massemidtpunkt indikatoren
    fill(255, 255, 0);
    circle(massemidtpunkt.x+rotationspunkt.x, -massemidtpunkt.y+rotationspunkt.y, bredde/5);
    fill(0);
    arc(massemidtpunkt.x+rotationspunkt.x, -massemidtpunkt.y+rotationspunkt.y, bredde/5, bredde/5, 0, PI/2);
    arc(massemidtpunkt.x+rotationspunkt.x, -massemidtpunkt.y+rotationspunkt.y, bredde/5, bredde/5, PI, 1.5*PI);
    popMatrix();
  }
}
