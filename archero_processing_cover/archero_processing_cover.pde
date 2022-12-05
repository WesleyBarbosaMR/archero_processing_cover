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
    a1.reset();
    for (int i = 0; i <  numOfMonsters; i ++) {
      monsterArray[i].reset();
    }
  }
}

class Archer {
  int d, health, fireRate, posX, posY, score;
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
  String direction;
  int posX, posY;
  Arrow() {
    posX = a1.posX;
    posY = a1.posY;
    v = 1;
  }

  void update() {
    cooldown -= 1;
    posX += velocityX;
    posY += velocityY;
    println(posX, posY, velocityX, velocityY, cooldown);
  }

  void shoot() {
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
  int health, posX, posY;
  float velocityX, velocityY, v;

  Monsters() {
    health = 1;
    while (posX > width - 10 && posX < width + 10) {
      posX = int(random(width - 50, width + 50));
    }
    while (posY > height - 10 && posY < height + 10) {
      posY = int(random(height - 50, height + 50));
    }
    v = 2;
  }

  void update() {
    fill(100);
    rect(posX, posY, 20, 20);
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
  if (key == 'W' || key == 'w') {
    a1.velocityY = -a1.v;
    arrow.direction = "UP";
  } else if (key == 'S' || key == 's') {
    a1.velocityY = a1.v;
    arrow.direction = "DOWN";
  }
  if (key == 'A' || key == 'a') {
    a1.velocityX = -a1.v;
    arrow.direction = "LEFT";
  } else if (key == 'D' || key == 'd') {
    a1.velocityX = a1.v;
    arrow.direction = "RIGHT";
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
