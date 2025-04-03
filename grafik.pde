//Alt vores grafik lol
void grafik() {
  //tegnGrid();
  raket.tegnRaket();
}

void tegnGrid() {
  background(0);
  stroke(60);
  //lav alle de lodrette linjer
  for (float x=camX-width/2/zoom; x<=camX+width/2/zoom; x++) {
    if (round(x) % round(gridDist/sqrt(zoom)) == 0) {
      //hver 10'ene er tykkere
      if (x % round(gridDist*10/sqrt(zoom)) == 0) {
        strokeWeight(2);
      } else {
        strokeWeight(1);
      }
      line(x-camX, -height/2/zoom, x-camX, height/2/zoom);
    }
  }
  //lav alle de vandrette linjer
  for (float y=camY-height/2/zoom; y<=camY+height/2/zoom; y++) {
    if (round(y) % round(gridDist/sqrt(zoom)) == 0) {
      //hver 10'ene er tykkere
      if (y % round(gridDist*10/sqrt(zoom)) == 0) {
        strokeWeight(2);
      } else {
        strokeWeight(1);
      }
      line(-width/2/zoom, y-camY, width/2/zoom, y-camY);
    }
  }
  //Lav linjerne der viser x og y aksen
  strokeWeight(3);
  stroke(0, 255, 0);
  //line(gridDist*round(gridSize/gridDist/2)-camX, 0-camY, gridDist*round(gridSize/gridDist/2)-camX, gridSize-camY);
  stroke(255, 0, 0);
  //line(0-camX, gridDist*round(gridSize/gridDist/2)-camY, gridSize-camX, gridDist*round(gridSize/gridDist/2)-camY);
  strokeWeight(2);
  stroke(0);
}
