class NaveEnemy {
  float enemXpos=0, enemYpos=0, speed=4.0, enemDropXpos, enemDropYpos;
  int enemyR, scoreMultiplier, cooldownDrop;
  boolean enemyAlive, dropAcquired;
  int i = int(random(0, 30));


  NaveEnemy(float x, float y) {
    enemXpos = x;
    enemYpos = y;
    enemDropXpos =  enemXpos;
    enemDropYpos =  enemYpos;
    enemyR = 30;
    scoreMultiplier = 0;
    enemyAlive = true;
    dropAcquired = false;
  }

  void update(float x, float y) {
    if (enemyAlive == true) {
      drawEnemies(x, y);
    } else {
      if (i<=15) {
        if (dropAcquired == false) {
          bonusDrop(x);
        } else {
        }
      }
    }
  }

  void drawEnemies(float x, float y) {
    fill(255);
    ellipseMode(CENTER);
    circle(x, y, enemyR);
    collision(p1.t1.xposAt, p1.t1.yposAt);
  }

  void bonusDrop(float x) {
    enemDropXpos = x;
    enemDropYpos += 2;
    fill(255);
    image(randomPower, enemDropXpos-13, enemDropYpos-14, 28, 28);
    noFill();
    stroke(255);
    strokeWeight(4);
    arc(enemDropXpos, enemDropYpos, 30,30,0,radians(360), OPEN);
    if (collisionDrop(p1.xpos, p1.ypos) == true && cooldownDrop == 0) {
    } else {
      cooldownDrop++;
    }
  }


  boolean collision(float xShot, float yShot) {
    float distX = xShot - (enemXpos+45);
    float distY = yShot - (enemYpos+120);
    float distHipotenusa = sqrt( sq(distX) + sq(distY) );

    if (distHipotenusa <= enemyR) {
      collisionDetected = true;
      enemyAlive = false;
      if (scoreMultiplier > 0) {
        hiScore+=(scoreMultiplier*2);
      } else {
        hiScore++;
      }
      return true;
    } else {
      enemyAlive = true;
      return false;
    }
  }

  boolean collisionDrop(float xPlayer, float yPlayer) {
    float distX = xPlayer - (enemDropXpos);
    float distY = yPlayer - (enemDropYpos);
    float distHipotenusa = sqrt( sq(distX) + sq(distY) );

    if (distHipotenusa <= 15) {
      dropAcquired = true;
      return true;
    } else {
      return false;
    }
  }
}
