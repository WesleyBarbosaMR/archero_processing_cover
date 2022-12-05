PImage archer, bow;
int numOfMonsters = 6;
Monsters [] monsterArray = new Monsters[numOfMonsters];
Archer a1;
Arrow arrow;

void setup() {
  size(640, 480);
  imageMode(CENTER);
  a1 = new Archer();
  for (int i = 0; i <  numOfMonsters; i++) {
    monsterArray[i] = new Monsters();
  }
  arrow = new Arrow();

  archer = loadImage("archer.png");
  bow = loadImage("bow.png");
}

void draw() {
  background(120);
  a1.showScore();

  playMatch();
}

void playMatch() {
  for (int i = 0; i <  numOfMonsters; i++) {
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

  arrow.update();
  if (arrow.cooldown <= 0 && key == ' ') {
    arrow.shoot();
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
    v = 3;
  }

  void update() {
    cooldown -= 1;
    posX += velocityX;
    posY += velocityY;
    println(posX, posY, velocityX, velocityY, cooldown);
    if (direction == "UP") {
      line(posX, posY, posX, posY - 10);
    } else if (direction == "DOWN") {
      line(posX, posY, posX, posY + 10);
    } else if (direction == "LEFT") {
      line(posX - 10, posY, posX, posY);
    } else if (direction == "RIGHT") {
      line(posX, posY, posX + 10, posY);
    }
  }

  void shoot() {
    cooldown = 120;
    posX = a1.posX;
    posY = a1.posY;
    if (direction == "UP") {
      velocityX = 0;
      velocityY = -v;
    } else if (direction == "DOWN") {
      velocityX = 0;
      velocityY = v;
    } else if (direction == "LEFT") {
      velocityX = -v;
      velocityY = 0;
    } else if (direction == "RIGHT") {
      velocityX = v;
      velocityY = 0;
    }
  }
}

class Monsters {
  int health, posX, posY;
  float velocityX, velocityY, v, distToArcher;


  Monsters() {
    health = 1;
    distToArcher = sqrt(sq(posX - a1.posX) + sq(posY - a1.posY));
    while (distToArcher < 200) {
      posX = int(random(0, width));
      posY = int(random(0, height));
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
