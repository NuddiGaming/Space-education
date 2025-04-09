//Alt vores grafik lol
void grafik() {
  background(0);
  tegnGrid();
  raket.tegnRaket();
  jorden.tegn();
}

void tegnGrid() {
  stroke(60);
  strokeWeight(2/zoom);
  //lav alle de lodrette linjer
  for (double x=camX-width/2/zoom; x<=camX+width/2/zoom; x++) {
    if (Math.round(x) % ceil(gridDist/zoom) == 0) {
      line((float)(x-camX), -height/2/zoom, (float)(x-camX), height/2/zoom);
    }
  }
  //lav alle de vandrette linjer
  for (double y=camY-height/2/zoom; y<=camY+height/2/zoom; y++) {
    if (Math.round(y) % ceil(gridDist/zoom) == 0) {
      line(-width/2/zoom, (float)(y-camY), width/2/zoom, (float)(y-camY));
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
