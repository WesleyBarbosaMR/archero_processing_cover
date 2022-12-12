// AP1 - Programação 2 //<>// //<>//
// Aluno: Wesley Barbosa - 536186

int hiScore=0;
boolean collisionDetected = false;
NavePlayer p1;
NaveShot t1, t2, t3;
NaveEnemy e1[][];
PowerUp powerUps[];
PImage trishot, speedestShot, largeEnemies, pointsX2, randomPower;


void setup() {
  size(600, 600);
  
  trishot = loadImage("trishot.png");
  speedestShot = loadImage("speedest-shot.png");
  largeEnemies = loadImage("large-enemies.png");
  pointsX2 = loadImage("double-points.png");
  randomPower = loadImage("random-power.png");
  
  
  p1 = new NavePlayer(width/2);

  e1 = new NaveEnemy[5][6];
  for (int i = 0; i < e1.length; i++) {
    for (int j = 0; j < e1[i].length; j++) {
      e1[i][j] = new NaveEnemy((j*90)+25, i*60+10);
    }
  }

  powerUps = new PowerUp[4];
  for (int i = 0; i < 4; i++) {
    powerUps[i] = new PowerUp(i*60+(width-width/2.5));
  }
}

void draw() {
  background(0);
  textSize(25);
  textAlign(CENTER, CENTER);
  text("HI-SCORE\n" + hiScore, width/6, height/15);


  p1.update();

  for (int i = 0; i < e1.length; i++) {//Colunas de Inimigos
    for (int j = 0; j < e1[i].length; j++) {//Linhas de inimigos
      e1[i][j].update(e1[i][j].enemXpos+45, e1[i][j].enemYpos+120);
      if (e1[i][j].collisionDrop(p1.xpos, p1.ypos) == true && e1[i][j].cooldownDrop != 0) {
        int randomPower = int(random(0, 4));
        if (0 < powerUps[randomPower].cooldown && powerUps[randomPower].cooldown < 300) { //<>//
          powerUps[randomPower].cooldown++; //<>//
        } else { //<>//
          if (powerUps[randomPower].cooldown == 300) { //<>//
            powerUps[randomPower].cooldown = 0;
            e1[i][j].cooldownDrop = 0;
          } else {
            powerUps[randomPower].status = true;
            powerUps[randomPower].type = randomPower+1;
            e1[i][j].cooldownDrop++;
          }
        }
      } else {
      }
    }
  }

  for (int i = 0; i < powerUps.length; i++) {
    powerUps[i].update(powerUps[i].xpos, powerUps[i].ypos);
    if (powerUps[i].status == true && powerUps[i].type == 1) {
      powerUps[i] = new PowerUpTrishot(powerUps[i].xpos);
      p1.naveTriShot(p1.xpos);
    } else if (powerUps[i].status == true && powerUps[i].type == 2) {
      powerUps[i] = new PowerUpSpeedestShot(powerUps[i].xpos);
      p1.t1.speed = 5;
      p1.t2.speed = 5;
      p1.t3.speed = 5;
    } else if (powerUps[i].status == true && powerUps[i].type == 3) {
      powerUps[i] = new PowerUpLargeEnemies(powerUps[i].xpos);
      for (int j = 0; j < e1.length; j++) {//Colunas de Inimigos
        for (int k = 0; k < e1[j].length; k++) {//Linhas de inimigos
          if (e1[j][k].enemyAlive == true) {
            e1[j][k].enemyR = 40;
          }
        }
      }
    } else if (powerUps[i].status == true && powerUps[i].type == 4) {
      powerUps[i] = new PowerUpDoublePoints(powerUps[i].xpos);
      for (int j = 0; j < e1.length; j++) {//Colunas de Inimigos
        for (int k = 0; k < e1[j].length; k++) {//Linhas de inimigos
          if (e1[j][k].enemyAlive == true) {
            e1[j][k].scoreMultiplier+=1;
          }
        }
      }
    } else {
      p1.naveShot(p1.xpos);
    }
  }

  //Rodapé
  //line(0,height-100,width,height-100);
  for (int i = 0; i <= 40; i++) {
    float x = lerp(0, width, i/30.0) + 0;
    float y = lerp(height-80, height-80, i/60.0);
    strokeWeight(0.75);
    line(x, y, x+10, y);
  }
}
