class NaveShot {
  float xposIn, xposAt, yposIn, yposAt, speed;
  int shotH=20, shotW=5;

  NaveShot(float x, float y) {
    xposIn = x;
    xposAt = xposIn;
    yposIn = y - 25.0;
    yposAt = yposIn;
    speed = 3.0;
  }

  void update(float xpos) {
    xposIn = xpos;
    yposAt-=speed;
    if (yposAt < 0) {
      yposAt = yposIn;
      xposAt = xposIn;
    } else if (collisionDetected == true) {
      yposAt = yposIn;
      xposAt = xposIn;
      collisionDetected = false;
    } //Add quando tiro acertar um inimigo
    stroke(255);
    strokeWeight(shotW);
    line(xposAt, yposAt, xposAt, yposAt-shotH);
  }
}
