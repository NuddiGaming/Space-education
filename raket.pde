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
  Punkt massemidtpunkt = new Punkt(0, -højde/2);
  Punkt rotationspunkt = new Punkt(massemidtpunkt.x, massemidtpunkt.y);
  //position
  float x = 0;
  float y = -10;

  float masse = 20000;

  float motorKraft = 1000000;
  //hastighed
  float vX = 0;
  float vY = 0;
  //rotation
  float rot = 0;
  float rotHast = 0;

  int punktMængde = 4;

  //listen med alle collision punkter
  ArrayList<Punkt> collisionPunkter = new ArrayList<Punkt>();

  //listen med alle grafik punkter
  ArrayList<Punkt> grafikPunkter = new ArrayList<Punkt>();
  //listen med alle grafik punkter til hoved
  ArrayList<Punkt> hovedPunkter = new ArrayList<Punkt>();
  int hovedPunktMængde = 20;
  //de basale punkter til collision og grafik.
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
  Punkt collisionsPunkt;
  Raket() {
    println("Raket oprettet");
    //Punkter til collision... Dette tog lang tid at lave. :(
    Linje l1 = new Linje(højreVingeEnde, new Punkt(0, højreVingeStart.y*0.8));
    Linje l2 = new Linje(højreSideTop, højreSideBundStart);
    Punkt s = skæringspunkt(l1, l2);
    if (s.y < højreSideBundStart.y) {
      collisionPunkter.add(højreSideBundStart);
    }
    l1 = new Linje(venstreVingeEnde, new Punkt(0, venstreVingeStart.y*0.8));
    l2 = new Linje(venstreSideTop, venstreSideBundStart);
    s = skæringspunkt(l1, l2);
    if (s.y < venstreSideBundStart.y) {
      collisionPunkter.add(venstreSideBundStart);
    }
    for (int i=0; i<=punktMængde; i++) {
      collisionPunkter.add(new Punkt(højreSideTop.x, højreVingeStart.y+(højreSideTop.y-højreVingeStart.y)*i/punktMængde));
      collisionPunkter.add(new Punkt(venstreSideTop.x, venstreVingeStart.y+(venstreSideTop.y-venstreVingeStart.y)*i/punktMængde));
      if (i > 0) {
        l1 = new Linje(højreVingeStart, højreVingeEnde);
        l2 = new Linje(venstreVingeStart, venstreVingeEnde);
        collisionPunkter.add(new Punkt(højreVingeStart.x+l1.længdeX()*i/punktMængde, højreVingeStart.y+l1.a()*l1.længdeX()*i/punktMængde));
        collisionPunkter.add(new Punkt(venstreVingeStart.x+l2.længdeX()*i/punktMængde, venstreVingeStart.y+l2.a()*l2.længdeX()*i/punktMængde));
        if (i < punktMængde) {
          collisionPunkter.add(new Punkt(hovedTop.x+cos(PI*i/punktMængde)*bredde/2, -højde*topProcent-sin(PI*i/punktMængde)*højde*(1-topProcent)));
        }
      }
    }
    punktMængde = round(punktMængde*0.5);
    for (int i=0; i<=punktMængde; i++) {
      collisionPunkter.add(new Punkt(højreSideBundEnde.x+(venstreSideBundEnde.x-højreSideBundEnde.x)*i/punktMængde, højreSideBundEnde.y));
      if (i > 0) {
        l1 = new Linje(højreVingeEnde, new Punkt(0, højreVingeStart.y*0.8));
        l2 = new Linje(højreSideBundStart, højreSideBundEnde);
        s = skæringspunkt(l1, l2);
        l1 = new Linje(højreVingeEnde, s);
        collisionPunkter.add(new Punkt(højreVingeEnde.x+l1.længdeX()*i/punktMængde, højreVingeEnde.y+l1.a()*l1.længdeX()*i/punktMængde));
        l1 = new Linje(venstreVingeEnde, new Punkt(0, venstreVingeStart.y*0.8));
        l2 = new Linje(venstreSideBundStart, venstreSideBundEnde);
        s = skæringspunkt(l1, l2);
        l1 = new Linje(venstreVingeEnde, s);
        collisionPunkter.add(new Punkt(venstreVingeEnde.x+l1.længdeX()*i/punktMængde, venstreVingeEnde.y+l1.a()*l1.længdeX()*i/punktMængde));
      }
    }
    for (int i=0; i<=hovedPunktMængde; i++) {
      Punkt a = new Punkt(hovedTop.x+cos(PI*i/hovedPunktMængde)*bredde/2, -højde*topProcent-sin(PI*i/hovedPunktMængde)*højde*(1-topProcent));
      hovedPunkter.add(a);
      grafikPunkter.add(a);
    }
    grafikPunkter.add(hovedTop);
    grafikPunkter.add(højreSideTop);
    grafikPunkter.add(venstreSideTop);
    grafikPunkter.add(højreVingeStart);
    grafikPunkter.add(højreVingeEnde);
    grafikPunkter.add(venstreVingeStart);
    grafikPunkter.add(venstreVingeEnde);
    grafikPunkter.add(højreSideBundStart);
    grafikPunkter.add(højreSideBundEnde);
    grafikPunkter.add(venstreSideBundStart);
    grafikPunkter.add(venstreSideBundEnde);
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
    collisionsPunkt = null;
    float sumX = 0;
    float sumY = 0;
    int m = 0;
    Legeme collisionsLegeme = null;
    //tyngdekraft funktionalitet og collision med legemer
    for (Legeme legeme : legemer) {
      float dX = abs(legeme.x-(massemidtpunkt.rotate(rotationspunkt, rot).x+x));
      float dY = abs(legeme.y-(massemidtpunkt.rotate(rotationspunkt, rot).y+y));
      println(dX, dY);
      float dist = sqrt(pow(dX, 2)+pow(dY, 2));
      float tyngdekraft = g*legeme.masse*masse/pow(dist, 2);
      float rX = dX/dist;
      float rY = dY/dist;
      Kraft gravity = new Kraft(rX*tyngdekraft, rY*tyngdekraft, new Punkt(massemidtpunkt.x, massemidtpunkt.y));
      krafter.add(gravity);
      //collisionen mellem legemer
      for (Punkt p : collisionPunkter) {
        Punkt pCopy = new Punkt(p.x, p.y);
        pCopy = pCopy.rotate(new Punkt(rotationspunkt.x, rotationspunkt.y), rot);
        pCopy.x += x;
        pCopy.y += y;
        if (sqrt(pow(pCopy.x-legeme.x, 2)+pow(pCopy.y-legeme.y, 2)) <= legeme.radius) {
          fill(255, 0, 0);
          if (collisionsLegeme == null) {
            collisionsLegeme = legeme;
            collisionsPunkt = new Punkt(0, 0);
            krafter.remove(gravity);
          }
          sumX += p.x;
          sumY += p.y;
          m++;
        } else {
          fill(255);
        }
        circle(pCopy.x-camX, pCopy.y-camY, 1);
      }
    }
    //her tilføjes alle kræfter
    for (Kraft kraft : krafter) {
      tilføjKraft(kraft);
    }
    if (collisionsPunkt != null) {
      collisionsPunkt.x = sumX/m;
      collisionsPunkt.y = sumY/m;
      rotationspunkt = new Punkt(collisionsPunkt.x, collisionsPunkt.y);
      Linje l1 = new Linje(new Punkt(collisionsLegeme.x, collisionsLegeme.y), collisionsPunkt);
      float kraft = masse*sqrt(pow(vX, 2)+pow(vY, 2))/delta;
      float kX = l1.længdeX()/l1.længde()*kraft;
      float kY = l1.længdeY()/l1.længde()*kraft;
      tilføjKraft(new Kraft(kX, kY, collisionsPunkt));
      println(vY);
    } else {
      rotationspunkt = massemidtpunkt;
    }
    //tilføj hastigheden på x og y
    x += vX*delta;
    y += vY*delta;
    roter(rotHast*delta);
  }

  void tilføjKraft(Kraft kraft) {
    //jeg finder vektoren der peger fra påvirkningspunktet til massemidtpunktet
    Punkt a = new Punkt(kraft.p.x, kraft.p.y);
    Punkt b = new Punkt(massemidtpunkt.x-kraft.p.x, massemidtpunkt.y-kraft.p.y);
    Linje l = new Linje(a, b);
    l = l.rotate(rotationspunkt, rot);
    Punkt d = new Punkt(l.længdeX(), l.længdeY());
    //find distancen til massemidtpunkt
    float dist = sqrt(pow(d.x, 2) + pow(d.y, 2));
    //regn vinklen mellem kraftvektoren og vektoren der peger mod massemidtpunkt
    float v = acos((kraft.x*d.x + kraft.y*d.y) / (kraft.størrelse()*dist));
    //sikrer at v ikke er lig NaN
    if (v != v) {
      v = 0;
    }
    //tilføj kraften på hastigheden
    vX += kraft.x/masse*abs(cos(v))*delta;
    vY += kraft.y/masse*abs(cos(v))*delta;
    //find determinanten
    float det = d.x*kraft.y - d.y*kraft.x;

    //hvis determinanten er negativ så er kraft vektoren med uret rundt om vektoren der peger mod massemidtpunktet og derfor skal raketen rotere mod uret rundt, basic stuff lol B)
    if (det < 0) {
      rotHast += kraft.størrelse()/masse*abs(sin(v))/20*delta;
    } else { //og hvis den er positiv så er det omvendt
      rotHast -= kraft.størrelse()/masse*abs(sin(v))/20*delta;
    }
  }
  
  void roter(float v){
    println(grafikPunkter.get(0).x);
    for(int i=0;i<collisionPunkter.size();i++){
      collisionPunkter.get(i).rotateFull(rotationspunkt, v); 
    }
    for(int i=0;i<grafikPunkter.size();i++){
      grafikPunkter.get(i).rotateFull(rotationspunkt, v); 
    }
    massemidtpunkt.rotateFull(rotationspunkt, v);
  }

  void tegnRaket() {
    pushMatrix();

    //flyt raket position til 0, 0
    translate(x-camX, y-camY);

    noStroke();

    //tegn top delen
    fill(255, 0, 0);
    beginShape();
    for (Punkt p : hovedPunkter) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    //tegn vinger
    fill(50);
    beginShape();
    vertex(venstreVingeStart.x, venstreVingeStart.y);
    vertex(venstreVingeEnde.x, venstreVingeEnde.y);
    vertex(0, venstreVingeStart.y*0.8);
    vertex(højreVingeEnde.x, højreVingeEnde.y);
    vertex(højreVingeStart.x, højreVingeStart.y);
    endShape(CLOSE);

    //tegn bunden
    fill(75);
    beginShape();
    vertex(venstreSideBundStart.x, venstreSideBundStart.y);
    vertex(venstreSideBundEnde.x, venstreSideBundEnde.y);
    vertex(højreSideBundEnde.x, højreSideBundEnde.y);
    vertex(højreSideBundStart.x, højreSideBundStart.y);
    endShape(CLOSE);

    //tegn hoved delen
    fill(150);
    beginShape();
    vertex(højreSideTop.x, højreSideTop.y);
    vertex(højreSideBundStart.x, højreSideBundStart.y);
    vertex(venstreSideBundStart.x, venstreSideBundStart.y);
    vertex(venstreSideTop.x, venstreSideTop.y);
    endShape(CLOSE);

    //tegn shine
    stroke(240);
    strokeWeight(bredde/8);
    line(bredde*0.35, -højde*bundProcent - højde*abs(topProcent-bundProcent)*0.1, bredde*0.35, -højde*bundProcent - højde*abs(topProcent-bundProcent)*0.7);
    stroke(0);
    strokeWeight(2);
    noStroke();

    //tegn rude
    fill(100, 100, 255);
    circle(0, -højde*bundProcent - højde*abs(topProcent-bundProcent)*(4.0/5.0), bredde*0.4);

    //tegn flammer hvis moteren brænder
    if (brænder) {
      //tegner ydre exhaust
      fill(252, 164, 48);
      arc(0, 0, bredde*0.8, bredde*2, 0, PI);
      //tegner indre exhaust
      fill(245, 215, 24);
      arc(0, 0, bredde*0.5, bredde*1.2, 0, PI);
    }

    fill(0, 255, 0);
    for (Punkt p : collisionPunkter) {
      circle(p.x, p.y, bredde/10);
    }

    fill(255, 255, 0);
    circle(0, 0, 1);
    fill(0, 255, 255);
    if (collisionsPunkt != null) {
      circle(collisionsPunkt.x, collisionsPunkt.y, 1);
    }
    //tegn massemidtpunkt indikatoren
    fill(255, 255, 0);
    circle(massemidtpunkt.x, massemidtpunkt.y, bredde/5);
    fill(0);
    arc(massemidtpunkt.x, massemidtpunkt.y, bredde/5, bredde/5, 0, PI/2);
    arc(massemidtpunkt.x, massemidtpunkt.y, bredde/5, bredde/5, PI, 1.5*PI);
    popMatrix();
  }
}
