public class PowerUpLargeEnemies extends PowerUp {

  public PowerUpLargeEnemies(float xpos) {
    super(xpos);

    this.update(this.xpos, this.ypos);
    this.drawActivePowerUp(this.xpos, this.ypos);
    this.status = true;
    this.type = 3;
    drawType3();
  }
  void drawType3 (){
    image(largeEnemies, this.xpos-20, this.ypos-20, 40, 40);
  }
}
