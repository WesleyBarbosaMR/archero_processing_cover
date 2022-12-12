public class PowerUpDoublePoints extends PowerUp {

  public PowerUpDoublePoints(float xpos) {
    super(xpos);

    this.update(this.xpos, this.ypos);
    this.drawActivePowerUp(this.xpos, this.ypos);
    this.status = true;  
    this.type = 4;
    drawType4();
  }
  
  void drawType4 (){
    image(pointsX2, this.xpos-20, this.ypos-20, 40, 40);
  }
}
