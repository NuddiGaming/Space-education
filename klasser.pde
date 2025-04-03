//vores kraft class
class Kraft{
  float x;
  float y;
  float pX = 0;
  float pY = 0;
  Kraft(float x, float y, float pX, float pY){
    this.x = x;
    this.y = y;
    this.pX = pX;
    this.pY = pY;
  }
  //størrelsen/længden af kraften
  float størrelse(){
    return sqrt(pow(x, 2)+pow(y, 2));
  }
}

class legeme{
  
}
