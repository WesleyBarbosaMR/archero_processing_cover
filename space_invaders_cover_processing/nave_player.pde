class NavePlayer {
  float xpos=width/2, ypos=height-100, speed=3.0;
  int naveH=20, naveW=50;
  NaveShot t1 = new NaveShot(xpos, ypos);
  NaveShot t2 = new NaveShot(xpos, ypos);
  NaveShot t3 = new NaveShot(xpos, ypos);

  NavePlayer(float x) {
    xpos = x;
  }

  void update() {
    if (keyPressed == true) {
      if (keyCode == RIGHT) {
        xpos+=speed;
        drawNave(xpos, ypos, naveW, naveH);
        //p1.naveShot(xpos);
      } else if (keyCode == LEFT) {
        xpos-=speed;
        drawNave(xpos, ypos, naveW, naveH);
        //p1.naveShot(xpos);
      } else if (keyCode == UP) {
        ypos-=speed;
        drawNave(xpos, ypos, naveW, naveH);
        drawPropulsores(xpos, ypos);
      } else if (keyCode == DOWN) {
        ypos+=speed;
        drawNave(xpos, ypos, naveW, naveH);
        drawPropulsores(xpos, ypos);
      }
    }

    if (xpos > width-(naveW/2)) {
      xpos = width-(naveW/2);
    } else if (xpos < naveW/2) {
      xpos = naveW/2;
    }
    if (ypos > height-(naveH/2)) {
      ypos = height-(naveH/2);
    } else if (ypos < height/6) {
      ypos = height/6;
    }

    drawNave(xpos, ypos, naveW, naveH);

    //Atualização do PowerUp Trishot
    for (int i = 0; i < powerUps.length; i++) {
      if (powerUps[i].status == true && powerUps[i].type == 1) {
        t1.yposIn = ypos;
        t2.yposIn = ypos;
        t3.yposIn = ypos;
      } else {
        t1.yposIn = ypos;
        t2.yposIn = ypos;
        t3.yposIn = ypos;
      }
    }
  }

  void drawNave(float xpos, float ypos, int naveW, int naveH) {
    noStroke();
    rectMode(CENTER);
    fill(255);
    triangle(xpos, ypos-25.0, xpos+8.0, ypos-10.0, xpos-8.0, ypos-10.0);
    rect(xpos, ypos, naveW, naveH, 10, 10, 0, 0);
  }

  void drawPropulsores(float xpos, float ypos) {
    fill(125);
    bezier(xpos-20, ypos+10, xpos-10, ypos+30, xpos-10, ypos+30, xpos-5, ypos+10);
    fill(255);
    bezier(xpos-16, ypos+10, xpos-10, ypos+26, xpos-11, ypos+26, xpos-9, ypos+10);
    fill(125);
    bezier(xpos+20, ypos+10, xpos+10, ypos+30, xpos+10, ypos+30, xpos+5, ypos+10);
    fill(255);
    bezier(xpos+16, ypos+10, xpos+10, ypos+26, xpos+11, ypos+26, xpos+9, ypos+10);
  }

  void naveShot(float xpos) {
    t1.update(xpos);
  }

  void naveTriShot(float xpos) {
    noStroke();
    fill(255);
    triangle(xpos-20, ypos-25.0, (xpos+8.0)-20, ypos-10.0, (xpos-8.0)-20, ypos-10.0);
    triangle(xpos+20, ypos-25.0, (xpos+8.0)+20, ypos-10.0, (xpos-8.0)+20, ypos-10.0);
    t1.update(xpos);
    t2.update(xpos-20);
    t3.update(xpos+20);
  }
}
