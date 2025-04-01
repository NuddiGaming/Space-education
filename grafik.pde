//Alt vores grafik lol
void grafik(){
  tegnGrid();
  raket.tegnRaket();
}

void tegnGrid(){
  background(0);
  stroke(60);
  //lav alle de lodrette linjer
  for(int x=0;x<=gridSize;x+=gridDist){
    //hver 10'ene er tykkere
    if(x % (gridDist*10) == 0){
      strokeWeight(10);
    }
    else{
      strokeWeight(4);
    }
    line(x-camX, 0-camY, x-camX, gridSize-camY);
  }
  //lav alle de vandrette linjer
  for(int y=0;y<=gridSize;y+=gridDist){
    //hver 10'ene er tykkere
    if(y % (gridDist*10) == 0){
      strokeWeight(10);
    }
    else{
      strokeWeight(4);
    }
    line(0-camX, y-camY, gridSize-camX, y-camY);
  }
  //Lav linjerne der viser x og y aksen
  strokeWeight(15);
  stroke(0, 255, 0);
  line(gridDist*round(gridSize/gridDist/2)-camX, 0-camY, gridDist*round(gridSize/gridDist/2)-camX, gridSize-camY);
  stroke(255, 0, 0);
  line(0-camX, gridDist*round(gridSize/gridDist/2)-camY, gridSize-camX, gridDist*round(gridSize/gridDist/2)-camY);
  strokeWeight(2);
  stroke(0);
}
