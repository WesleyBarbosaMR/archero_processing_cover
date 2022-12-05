PImage archer, bow;

int numOfMonsters = 10;
Monsters [] monsterArray = new Monsters[numOfMonsters];
Archer a1;
Arrow arrow;

void setup() {
  size(640, 480);
  imageMode(CENTER);
  a1 = new Archer();
  for (int i = 0; i <  numOfMonsters; i ++) {
    monsterArray[i] = new Monsters();
  }
  arrow = new Arrow();

  archer = loadImage("archer.png");
  bow = loadImage("bow.png");
}

void draw() {
  background(120);
  a1.showScore();
  if (arrow.cooldown == 0) {
    arrow.shoot();
  }
  playMatch();
  println(arrow.posX, arrow.posY);
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
    a1.reset();
    for (int i = 0; i <  numOfMonsters; i ++) {
      monsterArray[i].reset();
    }
  }
}

class Archer {
  int health, fireRate, posX, posY, score;
  float velocityX, velocityY, v;

  Archer() {
    health = 1;
    posX = width/2;
    posY = height/4;
    v = 3;
  }

  void update() {
    image(archer, posX, posY);
    image(bow, posX, posY);
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
  int posX, posY;
  Arrow() {
    cooldown = 120;
    posX = a1.posX;
    posY = a1.posY;
  }

  void update() {
    cooldown -= 1;
    posX += velocityX;
    posY += velocityY;
  }

  void shoot() {
    cooldown = 120;
    posX = a1.posX;
    posY = a1.posY;
    if (key == 'W' || key == 'w') {
      velocityX = 0;
      velocityY = -v;
    } else if (key == 'S' || key == 's') {
      velocityX = 0;
      velocityY = v;
    } else if (key == 'A' || key == 'a') {
      velocityX = -v;
      velocityY = 0;
    } else if (key == 'D' || key == 'd') {
      velocityX = 0;
      velocityY = v;
    }
  }
}

class Monsters {
  int health, posX, posY, velocity, v;

  Monsters() {
    health = 1;
    while (posX > width - 10 && posX < width + 10) {
      posX = int(random(width - 50, width + 50));
    }
    while (posY > height - 10 && posY < height + 10) {
      posY = int(random(height - 50, height + 50));
    }
    v = 3;
  }

  void update() {
  }

  void reset() {
  }
}

void keyPressed() {
  if (key == 'W' || key == 'w') {
    a1.velocityY = -a1.v;
  } else if (key == 'S' || key == 's') {
    a1.velocityY = a1.v;
  }
  if (key == 'A' || key == 'a') {
    a1.velocityX = -a1.v;
  } else if (key == 'D' || key == 'd') {
    a1.velocityX = a1.v;
  }
}

void keyReleased() {
  if (key == 'W' || key == 'w' || key == 'S' || key == 's') {
    a1.velocityY = 0;
  }
  if (key == 'A' || key == 'a' || key == 'D' || key == 'd') {
    a1.velocityX = 0;
  }
}
