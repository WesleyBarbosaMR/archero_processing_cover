public class PowerUp {
  float xpos, ypos;
  int cooldown, type;
  boolean status;

  public PowerUp(float xpos) {
    this.xpos = xpos;
    this.ypos = height/15;
    this.type = 0;
    this.cooldown = 0;
    this.status = false;
  }

  public void update(float x, float y) {
    if (this.status == true && cooldown < 300 && (type != 2 || type != 0)) {
      drawActivePowerUp(x, y);
    } else {
      cooldown = 0;
      drawInactivePowerUp(x, y);
    }
  }

  public void drawActivePowerUp(float x, float y) {
    noFill();
    stroke(255);
    strokeWeight(5);
    arc(x, y, 50, 50, 0, radians(360), OPEN);
    cooldown++;
  }
  public void drawInactivePowerUp(float x, float y) {
    noFill();
    stroke(60);
    strokeWeight(5);
    arc(x, y, 50, 50, 0, radians(360), OPEN);
  }
}
