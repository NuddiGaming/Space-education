//Alt vores grafik lol
void grafik() {
  background(0);
  //tegnGrid();
  raket.tegnRaket();
  //jorden.tegn();
  fill(255, 0, 0);
  circle(raket.x-camX, raket.y-camY, 2);
}

void tegnGrid() {
  stroke(60);
  strokeWeight(2/zoom);
  //lav alle de lodrette linjer
  for (float x=camX-width/2/zoom; x<=camX+width/2/zoom; x++) {
    if (round(x) % ceil(gridDist/zoom) == 0) {
      line(x-camX, -height/2/zoom, x-camX, height/2/zoom);
    }
  }
  //lav alle de vandrette linjer
  for (float y=camY-height/2/zoom; y<=camY+height/2/zoom; y++) {
    if (round(y) % ceil(gridDist/zoom) == 0) {
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
