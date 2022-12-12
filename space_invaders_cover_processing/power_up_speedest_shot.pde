public class PowerUpSpeedestShot extends PowerUp {

  public PowerUpSpeedestShot(float xpos) {
    super(xpos);

    this.update(this.xpos, this.ypos);
    this.drawActivePowerUp(this.xpos, this.ypos);
    this.status = true;
    this.type = 2;
    drawType2();
  }
  
  void drawType2 (){
    image(speedestShot, this.xpos-20, this.ypos-20, 40, 40);
  }
}
