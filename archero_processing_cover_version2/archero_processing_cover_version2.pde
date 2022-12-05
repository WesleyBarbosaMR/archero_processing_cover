// AP1 - Programação 2
// Aluno: Wesley Barbosa - 536186
/*
Implemente pelo menos 1 elemento móvel controlado pelo jogador
 (mouse, teclado, etc) e a mecânica básica do jogo.
 Deve existir algum tipo de contagem (pontos, vidas, etc).
 O cenário deve restringir os movimentos de alguma maneira
 (paredes, obstáculos, etc).
 Não são necessários elemento visuais,
 use círculos e retângulos para representar os elementos do jogo.
 */
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
  image(grass,0,0);
  textSize(25);
  textAlign(CENTER, CENTER);
  text("HI-SCORE  " + hiScore, width/2, height/25);
  //rectMode(CENTER);
  //rect((height/2), height-100, 50, 20, 10,10,0,0);
  p1.update();
  p1.shotting(p1.xpos);

  for (int i = 0; i < e1.length; i++) {//Colunas de Inimigos
    for (int j = 0; j < e1[i].length; j++) {//Linhas de inimigos
    if(e1[i][j].enemyAlive == true){
      e1[i][j].update(e1[i][j].posX+45, e1[i][j].posY+40);
    }

      //collisionDetector(e1[i][j].enemXpos, e1[i][j].enemYpos, p1.a1.xposAt, p1.a1.ypos);
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
    collision(p1.a1.xposAt, p1.a1.ypos);
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
  //collisionDetector(e1[i][j].enemXpos, e1[i][j].enemYpos, p1.a1.xposAt, p1.a1.ypos);
}

class Arrow {
  float xposIn, xposAt, ypos, speed=5.0;
  int shotH=20, shotW=5;

  Arrow(float x, float y) {
    xposIn = x;
    xposAt = xposIn;
    ypos = y - 25.0;
  }

  void update(float xpos) {
    xposIn = xpos;
    ypos-=speed;
    if (ypos < 0) {
      ypos = height-100;
      xposAt = xposIn;
    } else if (collisionDetected == true) {
      ypos = height-100;
      xposAt = xposIn;
      collisionDetected = false;
    } //Add quando tiro acertar um inimigo
    image(arrow, xposAt+30, ypos-shotH);
    /*stroke(255);
    strokeWeight(shotW);
    line(xposAt, ypos, xposAt, ypos-shotH);*/
  }
}
class Archer {
  float xpos=width/2, ypos=height-100, speed=3.0;
  int naveH=20, naveW=50;
  Arrow a1 = new Arrow(xpos, ypos);

  Archer(float x) {
    xpos = x;
    shotting(xpos);
  }

  void update() {
    if (keyPressed == true) {
      if (keyCode == RIGHT) {
        xpos+=speed;
        //p1.Arrow(xpos);
      } else if (keyCode == LEFT) {
        xpos-=speed;
        //p1.Arrow(xpos);
      } else if (keyCode == UP) {
        ypos-=speed;
        //p1.Arrow(xpos);
      } else if (keyCode == DOWN) {
        ypos+=speed;
        //p1.Arrow(xpos);
      }
    }
    if (xpos > width-(naveW/2)) {
      xpos = width-(naveW/2);
    } else if (xpos < naveW/2) {
      xpos = naveW/2;
    }
    image(archer,xpos, ypos);
    /*noStroke();
    rectMode(CENTER);
    triangle(xpos, ypos-25.0, xpos+8.0, ypos-10.0, xpos-8.0, ypos-10.0);
    rect(xpos, ypos, naveW, naveH, 10, 10, 0, 0);*/
  }

  void shotting(float xpos) {
    a1.update(xpos);
  }
}
