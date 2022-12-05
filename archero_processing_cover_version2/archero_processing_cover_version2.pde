PImage archer, arrow, grass, carnivorous_plant, skeleton; 
int hiScore=0;
boolean collisionDetected = false;
Archer p1;
Arrow a1;
Monster e1[][];

void setup() {
  size(640, 480);
  archer = loadImage("archer-up.png");
  arrow = loadImage("arrow-up.png");
  grass = loadImage("grass-bg.png");
  carnivorous_plant = loadImage("carnivorous-plant.png");
  skeleton = loadImage("skeleton.png");

  p1 = new Archer(width/2);
  e1 = new Monster[5][6];
  for (int i = 0; i < e1.length; i++) {//Colunas de Inimigos
    for (int j = 0; j < e1[i].length; j++) {//Linhas de inimigos
      e1[i][j] = new Monster((j*90)+30, i*60+10);
    }
  }
}

void draw() {
  background(0);
  image(grass, 0, 0);
  textSize(25);
  textAlign(CENTER, CENTER);
  text("HI-SCORE  " + hiScore, width/2, height/25);
  p1.update();
  p1.shotting(p1.xpos);

  for (int i = 0; i < e1.length; i++) {//Colunas de Inimigos
    for (int j = 0; j < e1[i].length; j++) {//Linhas de inimigos
      if (e1[i][j].enemyAlive == true) {
        e1[i][j].update(e1[i][j].posX+45, e1[i][j].posY+40);
      }
    }
  }
}

class Monster {
  float posX= int(random(50, width - 50)), posY= int(random(50, height - 50)), monsterType;
  int enemyR=30;
  boolean enemyAlive;
  float velocityX, velocityY, v;

  Monster(float x, float y) {
    while (posX > width - 10 && posX < width + 10) {
      posX = int(random(50, width - 50));
      x = posX;
    }
    while (posY > height - 10 && posY < height + 10) {
      posY = int(random(50, height - 50));
      y = posY;
    }
    enemyAlive = true;
    monsterType = int(random(0, 10));
    v = 1;
  }

  void update(float x, float y) {
    if (monsterType < 6) {
      image(carnivorous_plant, x, y);
    } else {
      image(skeleton, x, y);
    }

    posX += velocityX;
    posY += velocityY;
    if (abs(posX - p1.xpos) > abs(posY - p1.ypos)) {
      velocityY = 0;
      if (posX > p1.xpos) {
        velocityX = -v;
      } else if (posX < p1.xpos) {
        velocityX = v;
      } else {
        velocityX = 0;
      }
    } else {
      velocityX = 0;
      if (posY > p1.ypos) {
        velocityY = -v;
      } else if (posY < p1.ypos) {
        velocityY = v;
      } else {
        velocityY = 0;
      }
    }
    collision(p1.a1.xposAt, p1.a1.yposAt);
  }

  boolean collision(float xShot, float yShot) {
    float distX = xShot - (posX+45);
    float distY = yShot - (posY+120);
    float distHipotenusa = sqrt( sq(distX) + sq(distY) );

    if (distHipotenusa <= enemyR) {
      rect(posX+45, posY+120, 25, 25);
      collisionDetected = true;
      enemyAlive = false;
      hiScore++;
      return true;
    } else {
      enemyAlive = true;
      return false;
    }
  }
}

class Arrow {
  float xposIn, xposAt, yposIn, yposAt, speed=5.0;
  int shotH=45, shotW=6;

  Arrow(float x, float y) {
    xposIn = x;
    xposAt = xposIn;
    yposIn = y - 25.0;
    yposAt = yposIn;
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
    image(arrow, xposAt+30, yposAt-shotH);
    /*yposAt+=speed;
    if (yposAt > height) {
      yposAt = yposIn;
      xposAt = xposIn;
    } else if (collisionDetected == true) {
      yposAt = yposIn;
      xposAt = xposIn;
      collisionDetected = false;
    } //Add quando tiro acertar um inimigo
    image(arrow, xposAt+30, yposAt+shotH);
    */
  }
  
}
class Archer {
  float xpos=width/2, ypos=height-100, speed=4.0;
  int archerH=97, archerW=65;
  Arrow a1 = new Arrow(xpos, ypos);

  Archer(float x) {
    xpos = x;
    shotting(xpos);
  }

  void update() {
    if (keyPressed == true) {
      if (keyCode == RIGHT) {
        xpos+=speed;
      } else if (keyCode == LEFT) {
        xpos-=speed;
      } else if (keyCode == UP) {
        ypos-=speed;
      } else if (keyCode == DOWN) {
        ypos+=speed;
      }
    }
    if (xpos > width-(archerW)) {
      xpos = width-(archerW);
    } else if (xpos < 0) {
      xpos = 0;
    }
    if (ypos > height-(archerH)) {
      ypos = height-(archerH);
    } else if (ypos < height/12) {
      ypos = height/12;
    }
    image(archer, xpos, ypos);
    a1.yposIn = ypos;
  }

  void shotting(float xpos) {
    a1.update(xpos);
  }
}
