float g = 6.67430*pow(10, -11);

//Alt vores fysik lol
void fysik(){
  raket.fysik();
  for (PhysicsObject obj : physicsObjects) {
    obj.fysik();
  }
}
