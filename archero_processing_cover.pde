

// Trabalho Final MAMI - Equipe: Enrico Damasceno e Wesley Barbosa

//Definição das variáveis globais
// * Para os assets a serem carregadas no jogo
PImage archer, arrow, grass, carnivorous_plant, skeleton;

// * Para a pontuação da partida
int hiScore=0;

// * E para o registro das colisões durante a partida
boolean collisionDetected = false;

// * Declaração dos objetos utilizados (Arqueiro, Flecha e uma matriz para objetos do tipo Monstro)
Archer p1;
Arrow a1;
Monster e1[][];
void setup() {
  /*
  No setup() temos o carregamento dos elementos do jogo
  * Como as dimensões da tela definidas
    proporcionalmente ao tamanho da tela de um Atari
  * O carregamento dos assets do jogo
    em suas respectivas variáveis
  * E a definição do posicionamento inicial
    do arqueiro e dos monstros(dispostos em uma matriz 5x6) 
  */
  size(640, 480);
  
  archer = loadImage("archer-up.png");
  arrow = loadImage("arrow-up.png");
  grass = loadImage("grass-bg.png");
  carnivorous_plant = loadImage("carnivorous-plant.png");
  skeleton = loadImage("skeleton.png");

  p1 = new Archer(width/2);
  e1 = new Monster[5][6];
  for (int i = 0; i < e1.length; i++) {
    for (int j = 0; j < e1[i].length; j++) {
      e1[i][j] = new Monster((j*90)+30, i*60+10);
    }
  }
}

void draw() {
  /*
  Aqui no draw() teremos a atualização dos
  elementos, já criados, na tela durante a partida.
    * Como:
      - o background;
      - a exibição da pontuação, atualizada durante a partida
        sempre que ojogador acertar um inimigo; 
      - o próprio jogador e o tiro disparado,
        que é invocado pelo jogador após a sua criação
        e atualização na tela
  */
  background(0);
  image(grass, 0, 0);
  
  textSize(25);
  textAlign(CENTER, CENTER);
  text("HI-SCORE  " + hiScore, width/2, height/25);
  
  p1.update();
  p1.shotting(p1.xpos);
  
  /* 
     E por fim a atualização dos inimigos na tela
     caso ainda não tenham sido mortos pelo jogador
  */
  for (int i = 0; i < e1.length; i++) {
    for (int j = 0; j < e1[i].length; j++) {
      if (e1[i][j].enemyAlive == true) {
        e1[i][j].update(e1[i][j].posX+45, e1[i][j].posY+40);
      }
    }
  }
}

class Monster {
  /* Na classe monstro temos a definição dos atributos e construção dos objetos
     que vão permitir que o monstro:
     * assuma posições randomicas iniciais;
     * defina o status, tipo e a velocidade do monstro.
  */
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
    /* Os monstros contam com 2 tipos de assets
       que são escolhidos randomicamente
       dentro de um intervalo que permite
       uma variabilidade visual dos monstros do jogo 
    */
    if (monsterType < 6) {
      image(carnivorous_plant, x, y);
    } else {
      image(skeleton, x, y);
    }
    
    /* Ainda no update do monstro
       foi definido que ele iria alterar continuamente
       sua posição na direção do jogador para atacá-lo.
       Assim como no jogo original.*/
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
    
    /* E por fim a função de update irá verificar
       após cada atualização, 
       se o monstro colidiu com a flecha do jogador
       chamando a função collision
       e passando a posição atual da flecha do jogador.
    */ 
    collision(p1.a1.xposAt, p1.a1.yposAt);
  }
  /* Ao que a função collision irá verificar
     a distância da flecha até o monstro
     através do teorema de pitágoras. */
  boolean collision(float xShot, float yShot) {
    float distX = xShot - (posX+45);
    float distY = yShot - (posY+120);
    float distHipotenusa = sqrt(sq(distX) + sq(distY) );
    if (distHipotenusa <= enemyR) {
      /*
        Quando a colisão é então detectada o monstro
      tem a seu atributo de vida registrado como falso
      e passa a não ser mais atualizado.
        Além disso a pontuação do jogador é registrada.
      */ 
      collisionDetected = true;
      enemyAlive = false;
      hiScore++;
      return true;
    } else {
      // Se a colisão não é registrada o monstro continua vivo
      enemyAlive = true;
      return false;
    }
  }
}

class Arrow {
  // Na classe Arrow é definido a existência, atualização e comportamento da flecha
  float xposIn, xposAt, yposIn, yposAt, speed=5.0;
  int shotH=45, shotW=6;

  Arrow(float x, float y) {
    // Onde a flecha será construída a partir da posição do jogador
    /* Mas com dois campos para posição,
       para permitir q a flecha permaneça no caminho em que foi atirada
       até que suma ou colida com os monstros
       mesmo se o jogador mudar de posição
    */  
    xposIn = x;
    xposAt = xposIn;
    yposIn = y - 25.0;
    yposAt = yposIn;
  }

  void update(float xpos) {
    /* A flecha tem a sua posição atualizada
       a partir da posição do jogador e o limite superior do campo.
    */ 
    xposIn = xpos;
    yposAt-=speed;
    if (yposAt < 0) {
      /* Caso a flecha ultrapasse o limite superior do mapa
         outra flecha é lançada a partir da nova posição do jogador
      */
      yposAt = yposIn;
      xposAt = xposIn;
    } else if (collisionDetected == true) {
      /* Além disso, caso haja uma colisão com algum monstro
         outra flecha também é lançada a partir da nova posição do jogador
      */
      yposAt = yposIn;
      xposAt = xposIn;
      collisionDetected = false;
    }
    image(arrow, xposAt+30, yposAt-shotH);
  }
  
}
class Archer {
  // Na classe Archer estão definido o jogador
  float xpos=width/2, ypos=height-100, speed=4.0;
  int archerH=97, archerW=65;
  Arrow a1 = new Arrow(xpos, ypos);

  Archer(float x) {
    xpos = x;
    // Em sua criação ele invoca imediatamente a função de tiro
    shotting(xpos);
  }

  void update() {
    /* Tem também a sua movimentação regulada
       por uma função de update.
       Permitindo o jogador se movimentar
       tanto no eixo X quanto o eixo Y
    */
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
    // Porém com a limitação de não ultrapassar o mapa de jogo
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
    /* Também essa função é responsável por atualizar a posição Y
       inicial da próxima flecha atirada 
    */
    a1.yposIn = ypos;
  }
  // E por fim terá a função que invoca a flecha a partir da posição do jogador. 
  void shotting(float xpos) {
    a1.update(xpos);
  }
}
