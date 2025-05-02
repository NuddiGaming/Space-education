void editorSkærm() {

  fill(255);
  textSize(100);
  textAlign(CENTER);
  text("Raket editor", width/2, height/7);

  fill(200, 200, 255);
  textSize(20);
  textAlign(CENTER);
  text("Click on a planet in the view to edit its properties", width/2, height/7 + 60);

  fill(255, 220, 150);
  textSize(16);
  text("Hold SHIFT and click on a planet to drag it", width/2, height/7 + 90);

  // tegn raket menu hvis nødvændigt
  if (visRaketMenu) {
    tegnRaketMenu();
  }

  // tegn univers menu hvis nødvændigt
  if (visUniversMenu) {
    tegnUniversMenu();
  }

  // tegn tekstfelter
  if (visMenu && VisesIMenu != null) {
    // Kun tegn tekstfelter for den menu som skal vises lige nu
    VisesIMenu.navnFelt.tegnPåSkærm();
    VisesIMenu.masseFelt.tegnPåSkærm();
    VisesIMenu.radiusFelt.tegnPåSkærm();
  }

  // Tegn raket menu textfelter hvis nødvændigt
  if (visRaketMenu) {
    motorKraftFelt.tegnPåSkærm();
    raketMasseFelt.tegnPåSkærm();
  }

  // Tegn univers menu tekstfelter hvis nødvændigt
  if (visUniversMenu) {
    scaleFelt.tegnPåSkærm();
    gKonstantFelt.tegnPåSkærm();
  }

  // Tegner menuen  når man skal kunne se den
  if (visMenu && VisesIMenu != null) {
    tegnMenu(VisesIMenu);
  }
  // tegner tekstfelter
  if (visMenu && VisesIMenu != null) {
    // Tegner kun tekstfelterne som skal kunne ses lige nu
    VisesIMenu.navnFelt.tegnPåSkærm();
    VisesIMenu.masseFelt.tegnPåSkærm();
    VisesIMenu.radiusFelt.tegnPåSkærm();
  }
}



void startMenu(Legeme legeme) {
  menuX = mouseX;
  menuY = mouseY;
  visMenu = true;
  visRaketMenu = false;
  visUniversMenu = false;
  VisesIMenu = legeme;

  // Ændrer positionen af tekstfelterne så de er placeret rigtigt
  legeme.navnFelt.posX = menuX + width/100;
  legeme.navnFelt.posY = menuY + height/100+height/26;

  legeme.masseFelt.posX = menuX + width/100;
  legeme.masseFelt.posY = menuY + 4*height/100 + legeme.navnFelt.sizeY+height/26;

  legeme.radiusFelt.posX = menuX + width/100;
  legeme.radiusFelt.posY = menuY + 7*height/100 + legeme.navnFelt.sizeY + legeme.masseFelt.sizeY+ height/26;
}

void tegnMenu(Legeme legeme) {

  // Beregner størrelsen af menuen
  float menuWidth = legeme.navnFelt.sizeX + width/50;
  float menuHeight = legeme.radiusFelt.posY + legeme.radiusFelt.sizeY + height/10 - menuY;

  // forbereder til tegning af baggrunden
  fill(30, 30, 30, 220);
  stroke(100);
  strokeWeight(2);
  rectMode(CORNER);
  // tegner menu baggrunden
  rect(menuX, menuY, menuWidth, menuHeight, 10);

  // Forbereder til at skrive titlerne
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(16);

  // titeler
  text("Navn:", menuX + width/100, legeme.navnFelt.posY - height/100);
  text("Masse:", menuX + width/100, legeme.masseFelt.posY - height/100);
  text("Radius:", menuX + width/100, legeme.radiusFelt.posY - height/100);

  // Tegner tilføj knappen
  fill(50, 200, 50);
  rect(menuX + menuWidth/2 - height/15, menuY + menuHeight - height/20, height/7.5, height/25, 5);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Tilføj", menuX + menuWidth/2, menuY + menuHeight - height/20 + height/50);
}

void tegnRaketMenu() {
  // Beregner menu position
  float menuX = width - width/4 - width/50;
  float menuY = height/4;
  float menuWidth = width/4;
  float menuHeight = height/3;

  // tegner menu baggrund
  fill(30, 30, 30, 220);
  stroke(100);
  strokeWeight(2);
  rectMode(CORNER);
  rect(menuX, menuY, menuWidth, menuHeight, 10);

  // tegner titel
  fill(255);
  textAlign(CENTER, TOP);
  textSize(24);
  text("Raket egenskaber", menuX + menuWidth/2, menuY + height/50);

  // tegner luk knap
  fill(200, 50, 50);
  rect(menuX + menuWidth - height/25, menuY + height/100, height/30, height/30, 5);
  fill(255);
  textAlign(CENTER, CENTER);
  text("X", menuX + menuWidth - height/25 + height/60, menuY + height/100 + height/60);

  // tegner tilføj knap
  fill(50, 200, 50);
  rect(menuX + menuWidth/2 - height/15, menuY + menuHeight - height/20, height/7.5, height/25, 5);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Tilføj", menuX + menuWidth/2, menuY + menuHeight - height/20 + height/50);

  // tegenr titler
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(16);
  text("Motor Kraft:", menuX + width/50, motorKraftFelt.posY - height/100);
  text("Masse:", menuX + width/50, raketMasseFelt.posY - height/100);
}

void tegnUniversMenu() {
  // Beregner menu position
  float menuX = width - width/4 - width/50;
  float menuY = height/4;
  float menuWidth = width/4;
  float menuHeight = height/3;

  // tegner menu baggrund
  fill(30, 30, 30, 220);
  stroke(100);
  strokeWeight(2);
  rectMode(CORNER);
  rect(menuX, menuY, menuWidth, menuHeight, 10);

  // tegner titel
  fill(255);
  textAlign(CENTER, TOP);
  textSize(24);
  text("univers egenskaber", menuX + menuWidth/2, menuY + height/50);

  // tegner luk knap
  fill(200, 50, 50);
  rect(menuX + menuWidth - height/25, menuY + height/100, height/30, height/30, 5);
  fill(255);
  textAlign(CENTER, CENTER);
  text("X", menuX + menuWidth - height/25 + height/60, menuY + height/100 + height/60);

  // tegner tilføj knap
  fill(50, 200, 50);
  rect(menuX + menuWidth/2 - height/15, menuY + menuHeight - height/20, height/7.5, height/25, 5);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Tilføj", menuX + menuWidth/2, menuY + menuHeight - height/20 + height/50);

  // tegner overskrifter
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(16);
  text("Scale:", menuX + width/50, scaleFelt.posY - height/100);
  text("Gravitations konstant:", menuX + width/50, gKonstantFelt.posY - height/100);
}

void startRaketMenu() {
  visMenu = false;
  visRaketMenu = true;
  visUniversMenu = false;

  // definer textfelt positioner
  float menuX = width - width/4 - width/50;
  float menuY = height/4;

  motorKraftFelt.posX = menuX + width/50;
  motorKraftFelt.posY = menuY + height/8;

  raketMasseFelt.posX = menuX + width/50;
  raketMasseFelt.posY = menuY + height/8 + height/16 + height/50;
}

void startUniversMenu() {
  visMenu = false;
  visRaketMenu = false;
  visUniversMenu = true;

  // definer textfelt positioner
  float menuX = width - width/4 - width/50;
  float menuY = height/4;

  scaleFelt.posX = menuX + width/50;
  scaleFelt.posY = menuY + height/8;

  gKonstantFelt.posX = menuX + width/50;
  gKonstantFelt.posY = menuY + height/8 + height/16 + height/50;
}

void handleMenuInteractions() {
  if (visMenu) {
    // Beregner menu størrelse baseret på tekstfelter
    float menuWidth = VisesIMenu.navnFelt.sizeX + width/50;
    float menuHeight = VisesIMenu.radiusFelt.posY + VisesIMenu.radiusFelt.sizeY + height/10 - menuY;

    // Check om tilføj knappen er blevet trykket på
    if (mouseX >= menuX + menuWidth/2 - height/15 && mouseX <= menuX + menuWidth/2 - height/15 + height/7.5 &&
      mouseY >= menuY + menuHeight - height/20 && mouseY <= menuY + menuHeight - height/20 + height/25) {
      // kommer ændringerne på legemet
      try {
        VisesIMenu.navn = VisesIMenu.navnFelt.tekst;
        VisesIMenu.masse = Double.parseDouble(VisesIMenu.masseFelt.tekst)/Math.pow(scale, 2);
        VisesIMenu.radius = Double.parseDouble(VisesIMenu.radiusFelt.tekst)/scale;
        hideMenu();
      }
      catch (NumberFormatException e) {
        // Handle invalid number input
        println("Invalid number format in one of the fields");
      }
      return;
    }
  }
}

void checkClickOutsideMenu() {
  if (visMenu && VisesIMenu != null) {
    // Beregn kanten af menuen
    float menuWidth = VisesIMenu.navnFelt.sizeX + width/50;
    float menuHeight = VisesIMenu.radiusFelt.posY + VisesIMenu.radiusFelt.sizeY + height/100 - menuY;

    // Check om click er udenfor
    if (mouseX < menuX || mouseX > menuX + menuWidth ||
      mouseY < menuY || mouseY > menuY + menuHeight) {
      // Check om vi klikker uden for en menu
      if (!(VisesIMenu.navnFelt.mouseOver() ||
        VisesIMenu.masseFelt.mouseOver() ||
        VisesIMenu.radiusFelt.mouseOver())) {
        hideMenu();
      }
    }
  }
}

void hideMenu() {
  visMenu = false;
  if (VisesIMenu != null) {
    // Gør så tekstfelterne ikke er aktive længere
    VisesIMenu.navnFelt.deactivate();
    VisesIMenu.masseFelt.deactivate();
    VisesIMenu.radiusFelt.deactivate();
  }
  if (activeFelt != null) {
    activeFelt.deactivate();
    activeFelt = null;
  }
  VisesIMenu = null;
}

void inputMenuer() {
  // tilføjer planet hvis man trykker på knappen
  if (tilføjPlanetKnap.mouseOverUdenTransform()) {
    tilføjNyPlanet();
  }
  // Raket menu
  if (visRaketMenu) {
    // De relevante textfelter
    if (motorKraftFelt.mouseOver()) {
      if (activeFelt != null) {
        activeFelt.deactivate();
      }
      motorKraftFelt.activate();
      return;
    }
    if (raketMasseFelt.mouseOver()) {
      if (activeFelt != null) {
        activeFelt.deactivate();
      }
      raketMasseFelt.activate();
      return;
    }

    // Beregner textfelt position og størrelse til brug i click detection
    float menuX = width - width/4 - width/50;
    float menuY = height/4;
    float menuWidth = width/4;
    float menuHeight = height/3;

    // Check for luk knap tryk
    if (mouseX >= menuX + menuWidth - height/25 &&
      mouseX <= menuX + menuWidth - height/25 + height/30 &&
      mouseY >= menuY + height/100 &&
      mouseY <= menuY + height/100 + height/30) {
      visRaketMenu = false;
      if (activeFelt != null) {
        activeFelt.deactivate();
        activeFelt = null;
      }
      return;
    }

    // Check for tilføj knap tryk
    if (mouseX >= menuX + menuWidth/2 - height/15 &&
      mouseX <= menuX + menuWidth/2 - height/15 + height/7.5 &&
      mouseY >= menuY + menuHeight - height/20 &&
      mouseY <= menuY + menuHeight - height/20 + height/25) {
      try {
        raket.motorKraft = Double.parseDouble(motorKraftFelt.tekst);
        raket.masse = Double.parseDouble(raketMasseFelt.tekst);
        visRaketMenu = false;
        if (activeFelt != null) {
          activeFelt.deactivate();
          activeFelt = null;
        }
      }
      catch (NumberFormatException e) {
        println("Invalid number format in rocket fields");
      }
      return;
    }
  }

  // universet menu
  if (visUniversMenu) {
    // Check for tekstfelt kliks
    if (scaleFelt.mouseOver()) {
      if (activeFelt != null) {
        activeFelt.deactivate();
      }
      scaleFelt.activate();
      return;
    }
    if (gKonstantFelt.mouseOver()) {
      if (activeFelt != null) {
        activeFelt.deactivate();
      }
      gKonstantFelt.activate();
      return;
    }

    // Beregner menu position og størrelse til tryk tjek
    float menuX = width - width/4 - width/50;
    float menuY = height/4;
    float menuWidth = width/4;
    float menuHeight = height/3;

    // Check for luk knap tryk
    if (mouseX >= menuX + menuWidth - height/25 &&
      mouseX <= menuX + menuWidth - height/25 + height/30 &&
      mouseY >= menuY + height/100 &&
      mouseY <= menuY + height/100 + height/30) {
      visUniversMenu = false;
      if (activeFelt != null) {
        activeFelt.deactivate();
        activeFelt = null;
      }
      return;
    }

    // Check for tilføj knap tryk
    if (mouseX >= menuX + menuWidth/2 - height/15 &&
      mouseX <= menuX + menuWidth/2 - height/15 + height/7.5 &&
      mouseY >= menuY + menuHeight - height/20 &&
      mouseY <= menuY + menuHeight - height/20 + height/25) {
      try {
        //ændrer scale og ændre den reale masse og radius så det passer
        double scaleChange = scale/Double.parseDouble(scaleFelt.tekst);
        scale = Double.parseDouble(scaleFelt.tekst);
        for (Legeme legeme : legemer) {
          legeme.radius=legeme.radius*scaleChange;
          legeme.masse=legeme.masse*Math.pow(scaleChange, 2);
          legeme.x=legeme.x*scaleChange;
          legeme.y=legeme.y*scaleChange;
        }
        raket.x=raket.x*scaleChange;
        raket.y=raket.y*scaleChange;
        g = Float.parseFloat(gKonstantFelt.tekst);
        visUniversMenu = false;
        if (activeFelt != null) {
          activeFelt.deactivate();
          activeFelt = null;
        }
      }
      catch (NumberFormatException e) {
        println("Invalid number format in universe fields");
      }
      return;
    }
  }

  // If we clicked outside any menu, deactivate text fields
  if (visRaketMenu || visUniversMenu) {
    if (activeFelt != null) {
      activeFelt.deactivate();
      activeFelt = null;
    }
  }
  // Bearbejder interaktioner hvis en menu skal vises
  if (visMenu) {
    handleMenuInteractions();
    checkClickOutsideMenu();
  }
  // Check om der er blevet trykket på en planet
  if (!visMenu) {
    for (Legeme legeme : legemer) {
      if (legeme.mouseOver()) {
        // Hvis der trykkes på shift trækkes legemet
        if (keyPressed && keyCode == SHIFT) {
          draggingLegeme = legeme;

          // Beregner musens position i globale koordinater
          double mx = mouseX - width / 2;
          double my = mouseY - height / 2;
          double cosR = cos(-camRot);
          double sinR = sin(-camRot);
          double rotx = mx * cosR - my * sinR;
          double roty = mx * sinR + my * cosR;
          double globalX = rotx / zoom + camX;
          double globalY = roty / zoom + camY;

          // Beregner offset så det ikke ser mærkeligt ud når man trækker
          dragOffsetX = legeme.x - globalX;
          dragOffsetY = legeme.y - globalY;
        } else {
          // åben menuen hvis ikke shift er trykket
          startMenu(legeme);
        }
        return;
      }
    }
  }
}

void tilføjNyPlanet() {
  // Beregner hvor midten af skærmen er i globale koordinater
  double mx = width / 2 - width / 2;
  double my = height / 2 - height / 2;
  double cosR = cos(-camRot);
  double sinR = sin(-camRot);
  double rotx = mx * cosR - my * sinR;
  double roty = mx * sinR + my * cosR;
  double globalX = rotx / zoom + camX;
  double globalY = roty / zoom + camY;
  
  // Laver en ny default planet med en radius der gør at den kan ses på skærmen med det samme
  double defaultRadius = scale*50/zoom;
  double defaultMass = 1.0; //masse som kan justeres i programmet
  //Giver det en tilfældig farve
  color defaultColor = color(random(100, 255), random(100, 255), random(100, 255));
  
  // laver planeten og gemmer den i legeme arrayet
  Legeme newPlanet = new Legeme(globalX * scale, globalY * scale, defaultRadius, defaultMass, defaultColor, "Ny Planet " + (legemer.size()));
  
  // Åbner menuen så man med det samme kan ændre i de tilhørende variabler
  startMenu(newPlanet);
}
