ArrayList<Textfield> textfields = new ArrayList<Textfield>();
Textfield activeField = null; // Holder styr på hvilket felt der er aktivt

class Textfield {
  float posX, posY, sizeX, sizeY, rundhed;
  color tekstFarve, activeFarve, outlineFarve, baggrundsFarve;
  int tekstSize, textfieldSkærm;
  String startTekst, tekst;
  boolean active;

  Textfield(float posX, float posY, float sizeX, float sizeY, color tekstFarve, color activeFarve, color outlineFarve, color baggrundsFarve, int tekstSize, String startTekst, String tekst, float rundhed, int textfieldSkærm, boolean active) {
    this.posX = posX;
    this.posY = posY;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.tekstFarve = tekstFarve;
    this.activeFarve = activeFarve;
    this.outlineFarve = outlineFarve;
    this.baggrundsFarve = baggrundsFarve;
    this.tekstSize = tekstSize;
    this.startTekst = startTekst;
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
      if (active){
        fill(activeFarve);
      }
      else{
        fill(baggrundsFarve);
      }
      stroke(outlineFarve);
      rect(posX, (float)(posY-camY), sizeX, sizeY, rundhed);
      textAlign(CENTER, CENTER);
      fill(tekstFarve);
      textSize(tekstSize);
      // Teksten som står i feltet
      String displayedText;
      if (active) {
        displayedText = tekst;
      } 
      else {
        if (tekst.isEmpty()) {
          displayedText = startTekst;
        } 
        else {
          displayedText = tekst;
        }
      }
      text(displayedText, posX + sizeX / 2, (float)(posY-camY + sizeY / 2));
    }
  }
  
  void tegnPåSkærm() {
  pushMatrix();
  resetMatrix();
  if (textfieldSkærm == skærm) { // Tjekker skærm
      rectMode(CORNER);
      // Sætte den rigtige farve ud fra om det er active
      if (active){
        fill(activeFarve);
      }
      else{
        fill(baggrundsFarve);
      }
      stroke(outlineFarve);
      rect(posX, posY, sizeX, sizeY, rundhed);
      textAlign(CENTER, CENTER);
      fill(tekstFarve);
      textSize(tekstSize);
      // Teksten som står i feltet
      String displayedText;
      if (active) {
        displayedText = tekst;
      } 
      else {
        if (tekst.isEmpty()) {
          displayedText = startTekst;
        } 
        else {
          displayedText = tekst;
        }
      }
      text(displayedText, posX + sizeX / 2, posY + sizeY / 2);
    }
    popMatrix();
  }

  // Tjekker om mus er over knap
  boolean mouseOver() {
    return mouseX > posX && mouseX < posX + sizeX && mouseY > posY && mouseY < posY + sizeY;
  }

  // Activate funktion
  void activate() {
    active = true;
    activeField = this;
  }

  // Deactivate funktion
  void deactivate() {
    active = false;
  }
}
