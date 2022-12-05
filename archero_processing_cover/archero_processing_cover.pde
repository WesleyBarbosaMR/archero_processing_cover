PImage archer, bow, arrowImg, grass, carnivorous_plant, skeleton;
//PImage archer, bow, arrowImg, grass, carnivorous_plant, skeleton;
PImage archer_positions[] = new PImage[4];
int numOfMonsters = 10;
Monsters [] monsterArray = new Monsters[numOfMonsters];
Archer a1;
Arrow arrow;

void setup() {
  size(640, 480);
  imageMode(CENTER);
  archer_positions[0] = loadImage("archer-left.png");
  archer_positions[1] = loadImage("archer-up.png");
  archer_positions[2] = loadImage("archer-right.png");
  archer_positions[3] = loadImage("archer-down.png");

a1 = new Archer();

for (int i = 0; i <  numOfMonsters; i ++) {
  monsterArray[i] = new Monsters();
}
arrow = new Arrow();

grass = loadImage("grass-bg.png");
archer = archer_positions[0];
//bow = loadImage("bow.png");
arrowImg = loadImage("arrow.png");
carnivorous_plant = loadImage("carnivorous-plant.png");
skeleton = loadImage("skeleton.png");
}

void draw() {
  background(120);
  image(grass, width/2, height/2);
  a1.showScore();
  arrow.update();
  if (arrow.cooldown <= 0 && key == ' ') {
    arrow.shoot();
  }
  playMatch();
}

void playMatch() {
  for (int i = 0; i <  numOfMonsters; i ++) {
    if (monsterArray[i].health > 0) {
      monsterArray[i].update();
    }
  }

  if (a1.health > 0) {
    a1.update();
  } else {
    println("gameover");
    gameOver();
  }
}

void gameOver() {
  text("GAME OVER", width/2, height/2);
  if (keyPressed) {
    if (key == ' ') {
      a1.reset();
      for (int i = 0; i <  numOfMonsters; i ++) {
        monsterArray[i].reset();
      }
    }
  }
}

class Archer {
  int d, health, fireRate, posX, posY, score, shotDirection=0;
  float velocityX, velocityY, v;

  Archer() {
    health = 1;
    posX = width/2;
    posY = height/4;
    v = 3;
    shotDirection = 0;
  }

  void update() {
    image(archer, posX, posY);
    //image(bow, posX, posY);


    posY += velocityY;
    posX += velocityX;
  }

  void reset() {
    health = 1;
    posX = width/2;
    posY = height/4;
    score = 0;
  }

  void showScore() {
  }
}

class Arrow {
  float cooldown, velocityX, velocityY, v;
  String direction;
  int posX, posY;
  Arrow() {
    posX = a1.posX;
    posY = a1.posY;
    v = 1;
  }

  void update() {
    image(arrowImg, posX, posY);
    cooldown -= 1;
    posX += velocityX;
    posY += velocityY;
    println(posX, posY, velocityX, velocityY, cooldown);
  }

  void shoot() {
    image(arrowImg, posX, posY);
    cooldown = 120;
    posX = a1.posX;
    posY = a1.posY;
    if (arrow.direction == "UP") {
      arrow.velocityX = 0;
      arrow.velocityY = -v;
    } else if (arrow.direction == "DOWN") {
      arrow.velocityX = 0;
      arrow.velocityY = v;
    } else if (arrow.direction == "LEFT") {
      arrow.velocityX = -v;
      arrow.velocityY = 0;
    } else if (arrow.direction == "RIGHT") {
      arrow.velocityX = v;
      arrow.velocityY = 0;
    }
  }
}

class Monsters {
  int health, posX= int(random(50, width - 50)), posY= int(random(50, height - 50)), monsterType;
  float velocityX, velocityY, v;

  Monsters() {
    health = 1;
    monsterType = int(random(0, 10));
    while (posX > width - 10 && posX < width + 10) {
      posX = int(random(50, width - 50));
    }
    while (posY > height - 10 && posY < height + 10) {
      posY = int(random(50, height - 50));
    }
    v = 1;
  }

  void update() {
    fill(100);
    if (monsterType < 6) {
      image(carnivorous_plant, posX, posY);
    } else {
      image(skeleton, posX, posY);
    }

    posX += velocityX;
    posY += velocityY;
    if (abs(posX - a1.posX) > abs(posY - a1.posY)) {
      velocityY = 0;
      if (posX > a1.posX) {
        velocityX = -v;
      } else if (posX < a1.posX) {
        velocityX = v;
      } else {
        velocityX = 0;
      }
    } else {
      velocityX = 0;
      if (posY > a1.posY) {
        velocityY = -v;
      } else if (posY < a1.posY) {
        velocityY = v;
      } else {
        velocityY = 0;
      }
    }
  }

  void reset() {
    //fazer uma colisão com o jogador
  }
}

void keyPressed() {
  if (key == 'W' || key == 'w' || keyCode == UP) {
    a1.velocityY = -a1.v;
    arrow.direction = "UP";
    archer = archer_positions[1];
  } else if (key == 'S' || key == 's' || keyCode == DOWN) {
    a1.velocityY = a1.v;
    arrow.direction = "DOWN";
    archer = archer_positions[3];
  }
  if (key == 'A' || key == 'a' || keyCode == LEFT) {
    a1.velocityX = -a1.v;
    arrow.direction = "LEFT";
    archer = archer_positions[0];
  } else if (key == 'D' || key == 'd' || keyCode == RIGHT) {
    a1.velocityX = a1.v;
    arrow.direction = "RIGHT";
    archer = archer_positions[2];
  }
}

void keyReleased() {
  if (key == 'W' || key == 'w' || key == 'S' || key == 's' || keyCode == UP || keyCode == DOWN) {
    a1.velocityY = 0;
  }
  if (key == 'A' || key == 'a' || key == 'D' || key == 'd' || keyCode == LEFT || keyCode == RIGHT) {
    a1.velocityX = 0;
  }
}
