class Raket {
  double højde = 20;
  double bredde = 5;
  //hvor stor en procentdel hver del fylder af højden
  double topProcent = 0.8;
  double bundProcent = 0.1;
  double vingeProcent = 0.3;
  double vingeProcentHøjde = 0.4;
  double vingeProcentBredde = 0.4;
  //massemidpunkt position
  Punkt massemidtpunkt = new Punkt(0, -højde/2);
  Punkt rotationspunkt = new Punkt(massemidtpunkt.x, massemidtpunkt.y);
  //position
  double x = 0;
  double y = -2;

  double masse = 20000;

  double motorKraft = 1000000;

  double brændMængde = 0;
  //hastighed
  double vX = 0;
  double vY = 0;
  //rotation
  double rot = 0;
  double rotHast = 0;

  int punktMængde = 10;

  boolean exploded = false;

  //listen med alle collision punkter
  ArrayList<Punkt> collisionPunkter = new ArrayList<Punkt>();

  //listen med alle grafik punkter
  ArrayList<Punkt> grafikPunkter = new ArrayList<Punkt>();
  //lister med alle grafik punkter til hoved og flammer
  ArrayList<Punkt> hovedPunkter = new ArrayList<Punkt>();
  ArrayList<Punkt> flamme1Punkter = new ArrayList<Punkt>();
  ArrayList<Punkt> flamme2Punkter = new ArrayList<Punkt>();
  int grafikPunktMængde = 20;
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
  Punkt shine1 = new Punkt(bredde*0.35, -højde*bundProcent - højde*Math.abs(topProcent-bundProcent)*0.1);
  Punkt shine2 = new Punkt(bredde*0.35, -højde*bundProcent - højde*Math.abs(topProcent-bundProcent)*0.7);
  Punkt rude = new Punkt(0, -højde*bundProcent - højde*Math.abs(topProcent-bundProcent)*(4.0/5.0));
  Punkt collisionsPunkt;
  Kraft resulterendeKraft=new Kraft(0, 0, new Punkt(0, 0));

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
    int halvPunktMængde = round(punktMængde*0.5);
    for (int i=0; i<=halvPunktMængde; i++) {
      collisionPunkter.add(new Punkt(højreSideBundEnde.x+(venstreSideBundEnde.x-højreSideBundEnde.x)*i/halvPunktMængde, højreSideBundEnde.y));
      if (i > 0) {
        l1 = new Linje(højreVingeEnde, new Punkt(0, højreVingeStart.y*0.8));
        l2 = new Linje(højreSideBundStart, højreSideBundEnde);
        s = skæringspunkt(l1, l2);
        l1 = new Linje(højreVingeEnde, s);
        collisionPunkter.add(new Punkt(højreVingeEnde.x+l1.længdeX()*i/halvPunktMængde, højreVingeEnde.y+l1.a()*l1.længdeX()*i/halvPunktMængde));
        l1 = new Linje(venstreVingeEnde, new Punkt(0, venstreVingeStart.y*0.8));
        l2 = new Linje(venstreSideBundStart, venstreSideBundEnde);
        s = skæringspunkt(l1, l2);
        l1 = new Linje(venstreVingeEnde, s);
        collisionPunkter.add(new Punkt(venstreVingeEnde.x+l1.længdeX()*i/halvPunktMængde, venstreVingeEnde.y+l1.a()*l1.længdeX()*i/halvPunktMængde));
      }
    }
    for (int i=0; i<=grafikPunktMængde; i++) {
      Punkt a = new Punkt(hovedTop.x+cos(PI*i/grafikPunktMængde)*bredde/2, -højde*topProcent-sin(PI*i/grafikPunktMængde)*højde*(1-topProcent));
      Punkt b = new Punkt(cos(-PI*i/grafikPunktMængde)*bredde*0.4, -sin(-PI*i/grafikPunktMængde)*bredde*1);
      Punkt c = new Punkt(cos(-PI*i/grafikPunktMængde)*bredde*0.25, -sin(-PI*i/grafikPunktMængde)*bredde*0.6);
      hovedPunkter.add(a);
      flamme1Punkter.add(b);
      flamme2Punkter.add(c);
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
    if (exploded) {
      return;
    }
    //rotation input
    if (k == true && j == false && l == false) {
      raket.rotHast = lerp((float)tempRaketRot, 0, 0.1);
      if (raket.rotHast >= 0.1 && raket.rotHast <= 0) {
        raket.rotHast = 0;
      } else if (raket.rotHast >= 0 && raket.rotHast <=-0.1) {
        raket.rotHast = 0;
      }
      if (raket.rotHast <= 0.01 && raket.rotHast >= 0) {
        raket.rotHast = 0;
      } else if (raket.rotHast <= 0 && raket.rotHast >=-0.01) {
        raket.rotHast = 0;
      }
    }
    if (j) {
      raket.rotHast -= 0.05;
    } else if (l) {
      raket.rotHast += 0.05;
    }
    ArrayList<Kraft> krafter = new ArrayList<Kraft>();
    //tjek om motoren brænder og hvis ja så tilføj motorkraften i krafter
    krafter.add(new Kraft(motorKraft*brændMængde*Math.sin(rot), -motorKraft*brændMængde*Math.cos(rot), new Punkt(0, 0)));
    engineSound.amp((float) brændMængde);
    collisionsPunkt = null;
    double sumX = 0;
    double sumY = 0;
    int m = 0;
    Legeme collisionsLegeme = null;
    Punkt closestPoint = massemidtpunkt;
    //tyngdekraft funktionalitet og collision med legemer
    for (Legeme legeme : legemer) {
      double dX = legeme.x-(massemidtpunkt.rotate(rotationspunkt, rot).x+x);
      double dY = legeme.y-(massemidtpunkt.rotate(rotationspunkt, rot).y+y);
      double dist = Math.sqrt(Math.pow(dX, 2)+Math.pow(dY, 2));
      double tyngdekraft = g*legeme.masse*masse/Math.pow(dist, 2);
      double rX = dX/dist;
      double rY = dY/dist;
      Kraft gravity = new Kraft(rX*tyngdekraft, rY*tyngdekraft, massemidtpunkt);
      krafter.add(gravity);
      //collisionen mellem legemer
      for (Punkt p : collisionPunkter) {
        Punkt pCopy = new Punkt(p.x, p.y);
        pCopy = pCopy.rotate(new Punkt(rotationspunkt.x, rotationspunkt.y), rot);
        pCopy.x += x;
        pCopy.y += y;
        double legemeDist = Math.sqrt(Math.pow(pCopy.x-legeme.x, 2)+Math.pow(pCopy.y-legeme.y, 2));
        if (legemeDist <= legeme.radius) {
          if (Math.sqrt(Math.pow(vX, 2)+Math.pow(vY, 2)) > 100 && exploded == false) {
            explode();
          }
          if (Math.sqrt(Math.pow(pCopy.x-legeme.x, 2)+Math.pow(pCopy.y-legeme.y, 2)) < Math.sqrt(Math.pow(closestPoint.x-legeme.x, 2)+Math.pow(closestPoint.y-legeme.y, 2))) {
            closestPoint = pCopy;
          }
          fill(255, 0, 0);
          if (collisionsLegeme == null) {
            collisionsLegeme = legeme;
            collisionsPunkt = new Punkt(0, 0);
          }
          sumX += p.x;
          sumY += p.y;
          m++;
        } else {
          fill(255);
        }
        //circle((float)(pCopy.x-camX), (float)(pCopy.y-camY), 1);
      }
      float zoomDist = (float) legeme.radius + (float) legeme.radius/1200;
      if (dist <= zoomDist && scale <= 3 && skærm!=editorSkærm) {
        zoomConstrain = true;
        zoomLegeme = legeme;
        pupDist = dist;
      } else if (dist > zoomDist && zoomLegeme == legeme) {
        zoomConstrain = false;
      }
    }
    resulterendeKraft.reset();
    //her tilføjes alle kræfter
    for (Kraft kraft : krafter) {
      tilføjKraft(kraft);
      resulterendeKraft.x+=kraft.x;
      resulterendeKraft.y+=kraft.y;
    }
    //kollision
    if (collisionsPunkt != null) {
      collisionsPunkt.x = sumX/m;
      collisionsPunkt.y = sumY/m;
      Linje l2 = new Linje(rotationspunkt, collisionsPunkt);
      Punkt oldPos = massemidtpunkt.rotate(rotationspunkt, rot);
      if (rotationspunkt != collisionsPunkt) {
        rotationspunkt = new Punkt(collisionsPunkt.x, collisionsPunkt.y);
      }
      //sikrer at rakketen ikke flytter sig når rotationspunktet flytter sig
      Punkt newPos = massemidtpunkt.rotate(rotationspunkt, rot);
      double dX = oldPos.x-newPos.x;
      double dY = oldPos.y-newPos.y;
      x += dX;
      y += dY;
      //tilføjer kollision kraft
      Linje l1 = new Linje(new Punkt(collisionsLegeme.x, collisionsLegeme.y), new Punkt(collisionsPunkt.x+x, collisionsPunkt.y+y));
      double v = rotHast*l2.længde()+Math.sqrt(Math.pow(vX, 2)+Math.pow(vY, 2));
      double kraft = masse*v;
      double kX = l1.længdeX()/l1.længde()*kraft;
      double kY = l1.længdeY()/l1.længde()*kraft;
      tilføjKraft(new Kraft(kX, kY, collisionsPunkt));
      rotHast *= 0.99;
      vY *= 0.99;
      vX *= 0.99;
    } else if (rotationspunkt != massemidtpunkt) { //flytter rotationspunktet tilbage til massemidtpunktet når rakketen forlader overfladen.
      Punkt oldPos = massemidtpunkt.rotate(rotationspunkt, rot);
      rotationspunkt = massemidtpunkt;
      Punkt newPos = massemidtpunkt.rotate(rotationspunkt, rot);
      double dX = oldPos.x-newPos.x;
      double dY = oldPos.y-newPos.y;
      x += dX;
      y += dY;
    }
    //tilføj hastigheden på x og y
    x += vX*delta;
    y += vY*delta;
    rot += rotHast*delta;
    //sikrer at rakketen står på overfladen
    if (collisionsLegeme != null) {
      for (Punkt p : collisionPunkter) {
        Punkt pCopy = new Punkt(p.x, p.y);
        pCopy = pCopy.rotate(new Punkt(rotationspunkt.x, rotationspunkt.y), rot);
        pCopy.x += x;
        pCopy.y += y;
        if (Math.sqrt(Math.pow(pCopy.x-collisionsLegeme.x, 2)+Math.pow(pCopy.y-collisionsLegeme.y, 2)) <= collisionsLegeme.radius) {
          if (Math.sqrt(Math.pow(pCopy.x-collisionsLegeme.x, 2)+Math.pow(pCopy.y-collisionsLegeme.y, 2)) < Math.sqrt(Math.pow(closestPoint.x-collisionsLegeme.x, 2)+Math.pow(closestPoint.y-collisionsLegeme.y, 2))) {
            closestPoint = pCopy;
          }
        }
      }
      Linje l1 = new Linje(new Punkt(collisionsLegeme.x, collisionsLegeme.y), closestPoint);
      double sX = l1.længdeX()/l1.længde()*collisionsLegeme.radius+collisionsLegeme.x;
      double sY = l1.længdeY()/l1.længde()*collisionsLegeme.radius+collisionsLegeme.y;
      Punkt p = new Punkt(sX, sY);
      Linje l2 = new Linje(closestPoint, p);
      x += l2.længdeX()*0.99;
      y += l2.længdeY()*0.99;
    }
  }

  void tilføjKraft(Kraft kraft) {
    //jeg finder vektoren der peger fra påvirkningspunktet til massemidtpunktet
    Punkt a = new Punkt(kraft.p.x, kraft.p.y);
    Linje l = new Linje(a, massemidtpunkt);
    l = l.rotate(rotationspunkt, rot);
    Punkt d = new Punkt(l.længdeX(), l.længdeY());
    //find distancen til massemidtpunkt
    double dist = Math.sqrt(Math.pow(d.x, 2) + Math.pow(d.y, 2));
    //regn vinklen mellem kraftvektoren og vektoren der peger mod massemidtpunkt
    double v = Math.acos((kraft.x*d.x + kraft.y*d.y) / (kraft.størrelse()*dist));
    //sikrer at v ikke er lig NaN
    if (v != v) {
      v = 0;
    }
    //tilføj kraften på hastigheden
    vX += kraft.x/masse*Math.abs(Math.cos(v))*delta;
    vY += kraft.y/masse*Math.abs(Math.cos(v))*delta;
    //find determinanten
    double det = d.x*kraft.y - d.y*kraft.x;
    //hvis determinanten er negativ så er kraft vektoren med uret rundt om vektoren der peger mod massemidtpunktet og derfor skal raketen rotere mod uret rundt, basic stuff lol B)
    if (det < 0) {
      rotHast += kraft.størrelse()/masse/5*Math.abs(Math.sin(v))*delta;
    } else { //og hvis den er positiv så er det omvendt
      rotHast -= kraft.størrelse()/masse/5*Math.abs(Math.sin(v))*delta;
    }
  }

  void tegnRaket() {
    if (exploded) {
      return;
    }
    pushMatrix();

    //flyt raket position til 0, 0
    translate((float)(x-camX), (float)(y-camY));

    noStroke();

    //tegn top delen
    fill(255, 0, 0);
    beginShape();
    for (Punkt p : hovedPunkter) {
      vertex((float)p.rotate(rotationspunkt, rot).x, (float)p.rotate(rotationspunkt, rot).y);
    }
    endShape(CLOSE);
    //tegn vinger
    fill(50);
    beginShape();
    vertex((float)venstreVingeStart.rotate(rotationspunkt, rot).x, (float)venstreVingeStart.rotate(rotationspunkt, rot).y);
    vertex((float)venstreVingeEnde.rotate(rotationspunkt, rot).x, (float)venstreVingeEnde.rotate(rotationspunkt, rot).y);
    Punkt v = new Punkt(0, venstreVingeStart.y*0.8).rotate(rotationspunkt, rot);
    vertex((float)v.x, (float)v.y);
    vertex((float)højreVingeEnde.rotate(rotationspunkt, rot).x, (float)højreVingeEnde.rotate(rotationspunkt, rot).y);
    vertex((float)højreVingeStart.rotate(rotationspunkt, rot).x, (float)højreVingeStart.rotate(rotationspunkt, rot).y);
    endShape(CLOSE);

    //tegn bunden
    fill(75);
    beginShape();
    vertex((float)venstreSideBundStart.rotate(rotationspunkt, rot).x, (float)venstreSideBundStart.rotate(rotationspunkt, rot).y);
    vertex((float)venstreSideBundEnde.rotate(rotationspunkt, rot).x, (float)venstreSideBundEnde.rotate(rotationspunkt, rot).y);
    vertex((float)højreSideBundEnde.rotate(rotationspunkt, rot).x, (float)højreSideBundEnde.rotate(rotationspunkt, rot).y);
    vertex((float)højreSideBundStart.rotate(rotationspunkt, rot).x, (float)højreSideBundStart.rotate(rotationspunkt, rot).y);
    endShape(CLOSE);

    //tegn hoved delen
    fill(150);
    beginShape();
    vertex((float)højreSideTop.rotate(rotationspunkt, rot).x, (float)højreSideTop.rotate(rotationspunkt, rot).y);
    vertex((float)højreSideBundStart.rotate(rotationspunkt, rot).x, (float)højreSideBundStart.rotate(rotationspunkt, rot).y);
    vertex((float)venstreSideBundStart.rotate(rotationspunkt, rot).x, (float)venstreSideBundStart.rotate(rotationspunkt, rot).y);
    vertex((float)venstreSideTop.rotate(rotationspunkt, rot).x, (float)venstreSideTop.rotate(rotationspunkt, rot).y);
    endShape(CLOSE);

    //tegn shine
    stroke(240);
    strokeWeight((float)bredde/8);
    line((float)shine1.rotate(rotationspunkt, rot).x, (float)shine1.rotate(rotationspunkt, rot).y, (float)shine2.rotate(rotationspunkt, rot).x, (float)shine2.rotate(rotationspunkt, rot).y);
    stroke(0);
    strokeWeight(2);
    noStroke();

    //tegn rude
    fill(100, 100, 255);
    circle((float)rude.rotate(rotationspunkt, rot).x, (float)rude.rotate(rotationspunkt, rot).y, (float)bredde*0.4);

    //tegn flammer hvis moteren brænder
    //tegner ydre exhaust
    fill(252, 164, 48);
    beginShape();
    for (Punkt p : flamme1Punkter) {
      Punkt pCopy = new Punkt(p.x, p.y*brændMængde);
      vertex((float)pCopy.rotate(rotationspunkt, rot).x, (float)pCopy.rotate(rotationspunkt, rot).y);
    }
    endShape(CLOSE);
    //tegner indre exhaust
    fill(245, 215, 24);
    beginShape();
    for (Punkt p : flamme2Punkter) {
      Punkt pCopy = new Punkt(p.x, p.y*brændMængde);
      vertex((float)pCopy.rotate(rotationspunkt, rot).x, (float)pCopy.rotate(rotationspunkt, rot).y);
    }
    endShape(CLOSE);

    fill(0, 255, 0);
    for (Punkt p : collisionPunkter) {
      //circle((float)p.rotate(rotationspunkt, rot).x, (float)p.rotate(rotationspunkt, rot).y, (float)bredde/10);
    }
    fill(0, 255, 255);
    if (collisionsPunkt != null) {
      //circle((float)collisionsPunkt.x, (float)collisionsPunkt.y, 1);
    }

    //tegn massemidtpunkt indikatoren
    fill(255, 255, 0);
    circle((float)massemidtpunkt.rotate(rotationspunkt, rot).x, (float)massemidtpunkt.rotate(rotationspunkt, rot).y, (float)bredde/5);
    fill(0);
    arc((float)massemidtpunkt.rotate(rotationspunkt, rot).x, (float)massemidtpunkt.rotate(rotationspunkt, rot).y, (float)bredde/5, (float)bredde/5, 0, PI/2);
    arc((float)massemidtpunkt.rotate(rotationspunkt, rot).x, (float)massemidtpunkt.rotate(rotationspunkt, rot).y, (float)bredde/5, (float)bredde/5, PI, 1.5*PI);
    popMatrix();
  }
  boolean mouseOver() {
    return true;
  }
  //logikken bag rakketen når den eksplodere
  void explode() {
    følgerRaket = false;
    engineSound.pause();
    explosionSounds.get(round(random(0, explosionSounds.size()-1))).play();
    exploded = true;
    //tilføj røg
    for (int i=0; i<30; i++) {
      double d = random(1, 10);
      double v = random(0, 2*PI);
      double dX = Math.cos(v)*d;
      double dY = Math.sin(v)*d;
      explosionSmoke smoke = new explosionSmoke(massemidtpunkt.x+x+dX, massemidtpunkt.y+y+dY, color(100));
    }
    
    //alt nedenunder er til at tilføje raketfragmenterne når den springer i luften.
    
    //top del fragment
    ArrayList<Punkt> topDelPunkter = new ArrayList<Punkt>();
    for (int i=0; i<punktMængde*2+1; i++) {
      double p = float(i)/(punktMængde*2);
      double v = p*PI;
      topDelPunkter.add(new Punkt(Math.cos(v)*bredde/2, -Math.sin(v)*højde*(1-topProcent)-højde*topProcent));
    }
    for (int i=1; i<round(punktMængde/2); i++) {
      double p = float(i)/round(punktMængde/2);
      topDelPunkter.add(new Punkt(p*bredde-bredde/2, -højde*topProcent));
    }
    Punkt topDelMassemidtPunkt = new Punkt(0, -højde*(1-topProcent)/2-højde*topProcent);
    Punkt topDelPos = topDelMassemidtPunkt.rotate(rotationspunkt, rot);
    topDelPos.x = topDelPos.x+x-topDelMassemidtPunkt.x;
    topDelPos.y = topDelPos.y+y-topDelMassemidtPunkt.y;
    PhysicsObject topDel = new PhysicsObject(topDelPos, vX, vY, rot, 0, topDelPunkter, topDelPunkter, topDelMassemidtPunkt, masse/20, color(255, 0, 0));

    //vinger fragmenter
    ArrayList<Punkt> vinge1DelPunkter = new ArrayList<Punkt>();
    ArrayList<Punkt> vinge2DelPunkter = new ArrayList<Punkt>();

    Punkt vinge1DelPos = new Punkt(x, y-højde*bundProcent);
    Punkt vinge2DelPos = new Punkt(x, y-højde*bundProcent);
    Linje l1 = new Linje(højreVingeStart, højreVingeEnde);
    Linje l2 = new Linje(venstreVingeStart, venstreVingeEnde);
    double avgX1 = l1.længdeX()/2+højreVingeStart.x;
    double avgY1 = l1.længdeY()/2+højreVingeStart.y;
    double avgX2 = l2.længdeX()/2+venstreVingeStart.x;
    double avgY2 = l2.længdeY()/2+venstreVingeStart.y;
    for (int i=0; i<punktMængde+1; i++) {
      double p = float(i)/punktMængde;
      vinge1DelPunkter.add(new Punkt(l1.længdeX()*p+højreVingeStart.x, l1.længdeX()*p*l1.a()+højreVingeStart.y));
      vinge2DelPunkter.add(new Punkt(l2.længdeX()*p+venstreVingeStart.x, l2.længdeX()*p*l2.a()+venstreVingeStart.y));
    }
    l1 = new Linje(højreVingeEnde, new Punkt(0, højreVingeStart.y*0.8));
    l2 = new Linje(venstreVingeEnde, new Punkt(0, venstreVingeStart.y*0.8));
    avgX1 = (avgX1 + (l1.længdeX()/2+højreVingeEnde.x))/2;
    avgY1 = (avgY1 + (l1.længdeY()/2+højreVingeEnde.y))/2;
    avgX2 = (avgX2 + (l2.længdeX()/2+venstreVingeEnde.x))/2;
    avgY2 = (avgY2 + (l2.længdeY()/2+venstreVingeEnde.y))/2;
    for (int i=0; i<punktMængde+1; i++) {
      double p = float(i)/punktMængde;
      vinge1DelPunkter.add(new Punkt(l1.længdeX()*p+højreVingeEnde.x, l1.længdeX()*p*l1.a()+højreVingeEnde.y));
      vinge2DelPunkter.add(new Punkt(l2.længdeX()*p+venstreVingeEnde.x, l2.længdeX()*p*l2.a()+venstreVingeEnde.y));
    }
    l1 = new Linje(new Punkt(0, højreVingeStart.y*0.8), højreVingeStart);
    l2 = new Linje(new Punkt(0, venstreVingeStart.y*0.8), venstreVingeStart);
    for (int i=0; i<round(punktMængde/2); i++) {
      double p = float(i)/round(punktMængde/2);
      vinge1DelPunkter.add(new Punkt(l1.længdeX()*p+l1.p1.x, l1.længdeX()*p*l1.a()+l1.p1.y));
      vinge2DelPunkter.add(new Punkt(l2.længdeX()*p+l2.p1.x, l2.længdeX()*p*l2.a()+l2.p1.y));
    }
    Punkt vinge1DelMassemidtPunkt = new Punkt(avgX1, avgY1);
    Punkt vinge2DelMassemidtPunkt = new Punkt(avgX2, avgY2);
    vinge1DelPos = vinge1DelMassemidtPunkt.rotate(rotationspunkt, rot);
    vinge1DelPos.x = vinge1DelPos.x+x-vinge1DelMassemidtPunkt.x;
    vinge1DelPos.y = vinge1DelPos.y+y-vinge1DelMassemidtPunkt.y;
    vinge2DelPos = vinge2DelMassemidtPunkt.rotate(rotationspunkt, rot);
    vinge2DelPos.x = vinge2DelPos.x+x-vinge2DelMassemidtPunkt.x;
    vinge2DelPos.y = vinge2DelPos.y+y-vinge2DelMassemidtPunkt.y;
    PhysicsObject vinge1Del = new PhysicsObject(vinge1DelPos, vX, vY, rot, 0, vinge1DelPunkter, vinge1DelPunkter, vinge1DelMassemidtPunkt, masse/30, color(50));
    PhysicsObject vinge2Del = new PhysicsObject(vinge2DelPos, vX, vY, rot, 0, vinge2DelPunkter, vinge2DelPunkter, vinge2DelMassemidtPunkt, masse/30, color(50));

    //bund delen
    ArrayList<Punkt> bundDelPunkter = new ArrayList<Punkt>();
    l1 = new Linje(venstreSideBundStart, venstreSideBundEnde);
    for (int i=1; i<round(punktMængde/4)+1; i++) {
      double p = float(i)/round(punktMængde/4);
      bundDelPunkter.add(new Punkt(l1.længdeX()*p+l1.p1.x, l1.længdeX()*p*l1.a()+l1.p1.y));
    }
    l1 = new Linje(venstreSideBundEnde, højreSideBundEnde);
    for (int i=1; i<round(punktMængde/2)+1; i++) {
      double p = float(i)/round(punktMængde/2);
      bundDelPunkter.add(new Punkt(l1.længdeX()*p+l1.p1.x, l1.længdeX()*p*l1.a()+l1.p1.y));
    }
    l1 = new Linje(højreSideBundEnde, højreSideBundStart);
    for (int i=1; i<round(punktMængde/4)+1; i++) {
      double p = float(i)/round(punktMængde/4);
      bundDelPunkter.add(new Punkt(l1.længdeX()*p+l1.p1.x, l1.længdeX()*p*l1.a()+l1.p1.y));
    }
    l1 = new Linje(højreSideBundStart, venstreSideBundStart);
    for (int i=1; i<round(punktMængde/2)+1; i++) {
      double p = float(i)/round(punktMængde/2);
      bundDelPunkter.add(new Punkt(l1.længdeX()*p+l1.p1.x, l1.længdeX()*p*l1.a()+l1.p1.y));
    }
    Punkt bundDelMassemidtPunkt = new Punkt(0, -højde*bundProcent/2);
    Punkt bundDelPos = bundDelMassemidtPunkt.rotate(rotationspunkt, rot);
    bundDelPos.x = bundDelPos.x+x-bundDelMassemidtPunkt.x;
    bundDelPos.y = bundDelPos.y+y-bundDelMassemidtPunkt.y;
    PhysicsObject bundDel = new PhysicsObject(bundDelPos, vX, vY, rot, 0, bundDelPunkter, bundDelPunkter, bundDelMassemidtPunkt, masse/30, color(75));

    //hoved del fragment
    ArrayList<Punkt> hovedDelPunkter = new ArrayList<Punkt>();
    l1 = new Linje(venstreSideTop, venstreSideBundStart);
    for (int i=1; i<punktMængde+1; i++) {
      double p = float(i)/punktMængde;
      hovedDelPunkter.add(new Punkt(l1.længdeX()*p+l1.p1.x, l1.længdeY()*p+l1.p1.y));
    }
    l1 = new Linje(venstreSideBundStart, højreSideBundStart);
    for (int i=1; i<round(punktMængde/2)+1; i++) {
      double p = float(i)/round(punktMængde/2);
      hovedDelPunkter.add(new Punkt(l1.længdeX()*p+l1.p1.x, l1.længdeX()*p*l1.a()+l1.p1.y));
    }
    l1 = new Linje(højreSideBundStart, højreSideTop);
    for (int i=1; i<punktMængde+1; i++) {
      double p = float(i)/punktMængde;
      hovedDelPunkter.add(new Punkt(l1.længdeX()*p+l1.p1.x, l1.længdeY()*p+l1.p1.y));
    }
    l1 = new Linje(højreSideTop, venstreSideTop);
    for (int i=1; i<round(punktMængde/2)+1; i++) {
      double p = float(i)/round(punktMængde/2);
      hovedDelPunkter.add(new Punkt(l1.længdeX()*p+l1.p1.x, l1.længdeX()*p*l1.a()+l1.p1.y));
    }
    Punkt hovedDelMassemidtPunkt = new Punkt(0, -højde*Math.abs(topProcent-bundProcent)/2);
    Punkt hovedDelPos = hovedDelMassemidtPunkt.rotate(rotationspunkt, rot);
    hovedDelPos.x = hovedDelPos.x+x-hovedDelMassemidtPunkt.x;
    hovedDelPos.y = hovedDelPos.y+y-hovedDelMassemidtPunkt.y;
    PhysicsObject hovedDel = new PhysicsObject(hovedDelPos, vX, vY, rot, 0, hovedDelPunkter, hovedDelPunkter, hovedDelMassemidtPunkt, masse/5, color(150));
  }
}
