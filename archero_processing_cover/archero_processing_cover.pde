PImage archer, bow;

int numOfMonsters = 10;
Monsters [] monsterArray = new Monsters[numOfMonsters];
Archer a1;

void setup() {
  size(640, 480);
  imageMode(CENTER);
  a1 = new Archer();
  for (int i = 0; i <  numOfMonsters; i ++) {
    monsterArray[i] = new Monsters();
  }

  archer = loadImage("archer.png");
  bow = loadImage("bow.png");
}

void draw() {
  background(120);
  a1.showScore();
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

class Arrows {
  float velocityX, velocityY;
  Arrows() {
  }

  void update() {
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
