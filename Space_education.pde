//Kamera position
float camX = 0;
float camY = 0;
//Kamera zoom
float zoom = 1;
//Kamera hastighed
float camSpeed = 30;

//grid
int gridDist = 100;
int gridSize = 10000;

//raket
Raket raket;

void setup(){
  fullScreen();
  //placer kamera i midten
  camX = gridSize/2;
  camY = gridSize/2;
  //lav raket
  raket = new Raket();
}

void draw(){
  //zoom
  translate(width/2, height/2);
  scale(zoom);
  translate(0, 0);
  
  //lav alt andet
  grafik();
  input();
  fysik();
}
