void setupTextfields() {
  // Create text fields for rocket properties
  motorKraftFelt = new Textfield(width/2, height/2, width/6, height/20, color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), 
  color(255, 255, 0), 16, String.valueOf(raket.motorKraft), 5, editorSkærm, false);
  
  raketMasseFelt = new Textfield(width/2, height/2, width/6, height/20, color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), 
  color(255, 255, 0), 16, String.valueOf(raket.masse), 5, editorSkærm, false);
  
  // Create text fields for universe properties
  scaleFelt = new Textfield(width/2, height/2, width/6, height/20, color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), 
  color(255, 255, 0), 16, String.valueOf(scale), 5, editorSkærm, false);
  
  gKonstantFelt = new Textfield(width/2, height/2, width/6, height/20, color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), 
  color(255, 255, 0), 16, String.valueOf(g), 5, editorSkærm, false);
}

class Textfield {
  float posX, posY, sizeX, sizeY, rundhed;
  color tekstFarve, activeFarve, outlineFarve, baggrundsFarve;
  int tekstSize, textfieldSkærm;
  String tekst;
  boolean active;

  Textfield(float posX, float posY, float sizeX, float sizeY, color tekstFarve, color activeFarve, color outlineFarve, color baggrundsFarve, int tekstSize, String tekst, float rundhed, int textfieldSkærm, boolean active) {
    this.posX = posX;
    this.posY = posY;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.tekstFarve = tekstFarve;
    this.activeFarve = activeFarve;
    this.outlineFarve = outlineFarve;
    this.baggrundsFarve = baggrundsFarve;
    this.tekstSize = tekstSize;
    this.tekst = tekst;
    this.rundhed = rundhed;
    this.textfieldSkærm = textfieldSkærm;
    this.active = active;
    textfields.add(this);
  }

  void tegn() {
    if (textfieldSkærm == skærm) { // Tjekker skærm
      rectMode(CORNER);
      // Sætte den rigtige farve ud fra om det er active
      if (active) {
        fill(activeFarve);
      } else {
        fill(baggrundsFarve);
      }
      stroke(outlineFarve);
      rect(posX, (float)(posY-camY), sizeX, sizeY, rundhed);
      textAlign(CENTER, CENTER);
      fill(tekstFarve);
      textSize(tekstSize);
      // Teksten som står i feltet
      String displayedText;
      displayedText = tekst;

      text(displayedText, posX + sizeX / 2, (float)(posY-camY + sizeY / 2));
    }
  }

  void tegnPåSkærm() {
    if (textfieldSkærm == skærm) { // Tjekker skærm
      rectMode(CORNER);
      // Sætte den rigtige farve ud fra om det er active
      if (active) {
        fill(activeFarve);
      } else {
        fill(baggrundsFarve);
      }
      stroke(outlineFarve);
      rect(posX, posY, sizeX, sizeY, rundhed);
      textAlign(CENTER, CENTER);
      fill(tekstFarve);
      textSize(tekstSize);
      // Teksten som står i feltet
      String displayedText;
      displayedText = tekst;
      text(displayedText, posX + sizeX / 2, posY + sizeY / 2);
    }
  }

  // Tjekker om mus er over knap
  boolean mouseOver() {
    return mouseX > posX && mouseX < posX + sizeX && mouseY > posY && mouseY < posY + sizeY;
  }

  // Activate funktion
  void activate() {
    active = true;
    activeFelt = this;
  }

  // Deactivate funktion
  void deactivate() {
    active = false;
  }
}
