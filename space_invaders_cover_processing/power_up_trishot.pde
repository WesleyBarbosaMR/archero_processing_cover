public class PowerUpTrishot extends PowerUp {

  public PowerUpTrishot(float xpos) {
    super(xpos);

    this.update(this.xpos, this.ypos);
    this.drawActivePowerUp(this.xpos, this.ypos);
    this.status = true;
    this.type = 1;
    drawType1();
  }
  
  void drawType1 (){
    image(trishot, this.xpos-20, this.ypos-20, 40, 40);
  }
}
