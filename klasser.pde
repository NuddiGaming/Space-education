//vores kraft class
class Kraft{
  float x;
  float y;
  float pX = 0;
  float pY = 0;
  Kraft(float x, float y){
    this.x = x;
    this.y = y;
  }
  //størrelsen/længden af kraften
  float størrelse(){
    return sqrt(pow(x, 2)+pow(y, 2));
  }
}
