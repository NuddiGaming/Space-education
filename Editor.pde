void editorSkærm() {
  //Gemmer den nuværende translation scale og rotation
  pushMatrix();
  //Går tilbage til den standard af disse
  resetMatrix();

  fill(255);
  textSize(100);
  textAlign(CENTER);
  text("Raket editor", width/2, height/7);

  fill(200, 200, 255);
  textSize(20);
  textAlign(CENTER);
  text("Click on a planet in the view to edit its properties", width/2, height/7 + 60);

  // Draw rocket menu if visible
  if (visRocketMenu) {
    tegnRocketMenu();
  }

  // Draw universe menu if visible
  if (visUniverseMenu) {
    tegnUniverseMenu();
  }

  // Draw text fields
  if (visMenu && VisesIMenu != null) {
    // Only draw text fields for the currently visible menu
    VisesIMenu.navnField.tegnPåSkærm();
    VisesIMenu.masseField.tegnPåSkærm();
    VisesIMenu.radiusField.tegnPåSkærm();
  }

  // Draw rocket text fields if visible
  if (visRocketMenu) {
    motorKraftField.tegnPåSkærm();
    raketMasseField.tegnPåSkærm();
  }

  // Draw universe text fields if visible
  if (visUniverseMenu) {
    scaleField.tegnPåSkærm();
    gravityField.tegnPåSkærm();
  }

  // Tegner menuen  når man skal kunne se den
  if (visMenu && VisesIMenu != null) {
    tegnMenu(VisesIMenu);
  }
  // tegner tekstfelter
  if (visMenu && VisesIMenu != null) {
    // Tegner kun tekstfelterne som skal kunne ses lige nu
    VisesIMenu.navnField.tegnPåSkærm();
    VisesIMenu.masseField.tegnPåSkærm();
    VisesIMenu.radiusField.tegnPåSkærm();
  }

  // Går tilbage til den tidligere translation scale og rotation
  popMatrix();
}



void startMenu(Legeme legeme) {
  menuX = mouseX;
  menuY = mouseY;
  visMenu = true;
  visRocketMenu = false;
  visUniverseMenu = false;
  VisesIMenu = legeme;

  // Ændrer positionen af tekstfelterne så de er placeret rigtigt
  legeme.navnField.posX = menuX + width/100;
  legeme.navnField.posY = menuY + height/100+height/26;

  legeme.masseField.posX = menuX + width/100;
  legeme.masseField.posY = menuY + 4*height/100 + legeme.navnField.sizeY+height/26;

  legeme.radiusField.posX = menuX + width/100;
  legeme.radiusField.posY = menuY + 7*height/100 + legeme.navnField.sizeY + legeme.masseField.sizeY+ height/26;
}

void tegnMenu(Legeme legeme) {
  // gemmer nuværende transformation
  pushMatrix();
  // går tilbage til en standard transformation
  resetMatrix();

  // Beregner størrelsen af menuen
  float menuWidth = legeme.navnField.sizeX + width/50;
  float menuHeight = legeme.radiusField.posY + legeme.radiusField.sizeY + height/10 - menuY;

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
  text("Navn:", menuX + width/100, legeme.navnField.posY - height/100);
  text("Masse:", menuX + width/100, legeme.masseField.posY - height/100);
  text("Radius:", menuX + width/100, legeme.radiusField.posY - height/100);

  // Tegner tilføj knappen
  fill(50, 200, 50);
  rect(menuX + menuWidth/2 - height/15, menuY + menuHeight - height/20, height/7.5, height/25, 5);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Tilføj", menuX + menuWidth/2, menuY + menuHeight - height/20 + height/50);

  // Går tilbage til den gamle transformation
  popMatrix();
}

void tegnRocketMenu() {
  // Calculate menu position and size
  float menuX = width - width/4 - width/50;
  float menuY = height/4;
  float menuWidth = width/4;
  float menuHeight = height/3;

  // Draw menu background
  fill(30, 30, 30, 220);
  stroke(100);
  strokeWeight(2);
  rectMode(CORNER);
  rect(menuX, menuY, menuWidth, menuHeight, 10);

  // Draw title
  fill(255);
  textAlign(CENTER, TOP);
  textSize(24);
  text("Rocket Properties", menuX + menuWidth/2, menuY + height/50);

  // Draw close button
  fill(200, 50, 50);
  rect(menuX + menuWidth - height/25, menuY + height/100, height/30, height/30, 5);
  fill(255);
  textAlign(CENTER, CENTER);
  text("X", menuX + menuWidth - height/25 + height/60, menuY + height/100 + height/60);

  // Draw apply button
  fill(50, 200, 50);
  rect(menuX + menuWidth/2 - height/15, menuY + menuHeight - height/20, height/7.5, height/25, 5);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Apply", menuX + menuWidth/2, menuY + menuHeight - height/20 + height/50);

  // Draw labels
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(16);
  text("Motor Kraft:", menuX + width/50, motorKraftField.posY - height/100);
  text("Masse:", menuX + width/50, raketMasseField.posY - height/100);
}

void tegnUniverseMenu() {
  // Calculate menu position and size
  float menuX = width - width/4 - width/50;
  float menuY = height/4;
  float menuWidth = width/4;
  float menuHeight = height/3;

  // Draw menu background
  fill(30, 30, 30, 220);
  stroke(100);
  strokeWeight(2);
  rectMode(CORNER);
  rect(menuX, menuY, menuWidth, menuHeight, 10);

  // Draw title
  fill(255);
  textAlign(CENTER, TOP);
  textSize(24);
  text("Universe Properties", menuX + menuWidth/2, menuY + height/50);

  // Draw close button
  fill(200, 50, 50);
  rect(menuX + menuWidth - height/25, menuY + height/100, height/30, height/30, 5);
  fill(255);
  textAlign(CENTER, CENTER);
  text("X", menuX + menuWidth - height/25 + height/60, menuY + height/100 + height/60);

  // Draw apply button
  fill(50, 200, 50);
  rect(menuX + menuWidth/2 - height/15, menuY + menuHeight - height/20, height/7.5, height/25, 5);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Apply", menuX + menuWidth/2, menuY + menuHeight - height/20 + height/50);

  // Draw labels
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(16);
  text("Scale:", menuX + width/50, scaleField.posY - height/100);
  text("Gravity Constant:", menuX + width/50, gravityField.posY - height/100);
}

void startRocketMenu() {
  visMenu = false;
  visRocketMenu = true;
  visUniverseMenu = false;

  // Set text field positions
  float menuX = width - width/4 - width/50;
  float menuY = height/4;

  motorKraftField.posX = menuX + width/50;
  motorKraftField.posY = menuY + height/8;

  raketMasseField.posX = menuX + width/50;
  raketMasseField.posY = menuY + height/8 + height/16 + height/50;
}

void startUniverseMenu() {
  visMenu = false;
  visRocketMenu = false;
  visUniverseMenu = true;

  // Set text field positions
  float menuX = width - width/4 - width/50;
  float menuY = height/4;

  scaleField.posX = menuX + width/50;
  scaleField.posY = menuY + height/8;

  gravityField.posX = menuX + width/50;
  gravityField.posY = menuY + height/8 + height/16 + height/50;
}

void handleMenuInteractions() {
  if (visMenu) {
    // Beregner menu størrelse baseret på tekstfelter
    float menuWidth = VisesIMenu.navnField.sizeX + width/50;
    float menuHeight = VisesIMenu.radiusField.posY + VisesIMenu.radiusField.sizeY + height/10 - menuY;

    // Check om tilføj knappen er blevet trykket på
    if (mouseX >= menuX + menuWidth/2 - height/15 && mouseX <= menuX + menuWidth/2 - height/15 + height/7.5 &&
      mouseY >= menuY + menuHeight - height/20 && mouseY <= menuY + menuHeight - height/20 + height/25) {
      // kommer ændringerne på legemet
      try {
        VisesIMenu.navn = VisesIMenu.navnField.tekst;
        VisesIMenu.masse = Double.parseDouble(VisesIMenu.masseField.tekst)/Math.pow(scale, 2);
        VisesIMenu.radius = Double.parseDouble(VisesIMenu.radiusField.tekst)/scale;
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
    float menuWidth = VisesIMenu.navnField.sizeX + width/50;
    float menuHeight = VisesIMenu.radiusField.posY + VisesIMenu.radiusField.sizeY + height/100 - menuY;

    // Check om click er udenfor
    if (mouseX < menuX || mouseX > menuX + menuWidth ||
      mouseY < menuY || mouseY > menuY + menuHeight) {
      // Check om vi klikker uden for en menu
      if (!(VisesIMenu.navnField.mouseOver() ||
        VisesIMenu.masseField.mouseOver() ||
        VisesIMenu.radiusField.mouseOver())) {
        hideMenu();
      }
    }
  }
}

void hideMenu() {
  visMenu = false;
  if (VisesIMenu != null) {
    // Gør så tekstfelterne ikke er aktive længere
    VisesIMenu.navnField.deactivate();
    VisesIMenu.masseField.deactivate();
    VisesIMenu.radiusField.deactivate();
  }
  if (activeField != null) {
    activeField.deactivate();
    activeField = null;
  }
  VisesIMenu = null;
}

void inputMenuer() {
  // Handle rocket menu interactions
  if (visRocketMenu) {
    // Check for text field clicks
    if (motorKraftField.mouseOver()) {
      if (activeField != null) {
        activeField.deactivate();
      }
      motorKraftField.activate();
      return;
    }
    if (raketMasseField.mouseOver()) {
      if (activeField != null) {
        activeField.deactivate();
      }
      raketMasseField.activate();
      return;
    }

    // Calculate menu position and size for hit testing
    float menuX = width - width/4 - width/50;
    float menuY = height/4;
    float menuWidth = width/4;
    float menuHeight = height/3;

    // Check for close button click
    if (mouseX >= menuX + menuWidth - height/25 &&
      mouseX <= menuX + menuWidth - height/25 + height/30 &&
      mouseY >= menuY + height/100 &&
      mouseY <= menuY + height/100 + height/30) {
      visRocketMenu = false;
      if (activeField != null) {
        activeField.deactivate();
        activeField = null;
      }
      return;
    }

    // Check for apply button click
    if (mouseX >= menuX + menuWidth/2 - height/15 &&
      mouseX <= menuX + menuWidth/2 - height/15 + height/7.5 &&
      mouseY >= menuY + menuHeight - height/20 &&
      mouseY <= menuY + menuHeight - height/20 + height/25) {
      try {
        raket.motorKraft = Double.parseDouble(motorKraftField.tekst);
        raket.masse = Double.parseDouble(raketMasseField.tekst);
        visRocketMenu = false;
        if (activeField != null) {
          activeField.deactivate();
          activeField = null;
        }
      }
      catch (NumberFormatException e) {
        println("Invalid number format in rocket fields");
      }
      return;
    }
  }

  // Handle universe menu interactions
  if (visUniverseMenu) {
    // Check for text field clicks
    if (scaleField.mouseOver()) {
      if (activeField != null) {
        activeField.deactivate();
      }
      scaleField.activate();
      return;
    }
    if (gravityField.mouseOver()) {
      if (activeField != null) {
        activeField.deactivate();
      }
      gravityField.activate();
      return;
    }

    // Calculate menu position and size for hit testing
    float menuX = width - width/4 - width/50;
    float menuY = height/4;
    float menuWidth = width/4;
    float menuHeight = height/3;

    // Check for close button click
    if (mouseX >= menuX + menuWidth - height/25 &&
      mouseX <= menuX + menuWidth - height/25 + height/30 &&
      mouseY >= menuY + height/100 &&
      mouseY <= menuY + height/100 + height/30) {
      visUniverseMenu = false;
      if (activeField != null) {
        activeField.deactivate();
        activeField = null;
      }
      return;
    }

    // Check for apply button click
    if (mouseX >= menuX + menuWidth/2 - height/15 &&
      mouseX <= menuX + menuWidth/2 - height/15 + height/7.5 &&
      mouseY >= menuY + menuHeight - height/20 &&
      mouseY <= menuY + menuHeight - height/20 + height/25) {
      try {
        scale = Double.parseDouble(scaleField.tekst);
        g = Float.parseFloat(gravityField.tekst);
        visUniverseMenu = false;
        if (activeField != null) {
          activeField.deactivate();
          activeField = null;
        }
      }
      catch (NumberFormatException e) {
        println("Invalid number format in universe fields");
      }
      return;
    }
  }

  // If we clicked outside any menu, deactivate text fields
  if (visRocketMenu || visUniverseMenu) {
    if (activeField != null) {
      activeField.deactivate();
      activeField = null;
    }
  }
}
