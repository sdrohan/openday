//Name : Mantas Rajackas
//Course Name: Applied Computing

/*  A game where the player must survive as long as possible in 
    an asteroid field */

import javax.swing.*;

//Timer variables for score
float starTimer = 0;
float endTimer = 0;
float gameTimer = 0;

//Number of stars and asteroids
int starCount = 1000;
int asteroidCount = 10;
int backgroundAsteroidCount = 100;

/*
0 - Start Menu
1 - Game Running
2 - Controls Menu
>2 - Game Over
*/
int gameState = 0;

/*
0 - No difficulty (Can't start game yet)
1 - Easy
2 - Medium
3 - Hard
4 - Why Even Bother
5 - Seriously. Don't Bother.
*/
int gameDifficulty = 0;

//Initialising objects and arrays
Ship spaceShip;
Star[] stars = new Star[starCount];
Asteroid[] asteroids = new Asteroid[asteroidCount];
BackgroundAsteroid[] backgroundAsteroids = new BackgroundAsteroid[backgroundAsteroidCount];

void setup() {
  background(0);
  size(800, 800);
  
  //Generates space ship
  spaceShip = new Ship(width/2,height-height/8, 10);
  
  //Generates array of Star objects
  for (int i = 0; i < starCount; i++) {
    stars[i] = new Star(random(0,width),random(-10,height),random(1,3),random(0.5,15));
  }
  //Generates array of Asteroid objects
  for (int i = 0; i < asteroidCount; i++) {
    asteroids[i] = new Asteroid(random(0,width),-250-random(height),random(50,200), random(5,10));
  }
  //Generates array of BackgroundAsteroid objects
  for (int i = 0; i < backgroundAsteroidCount; i++) {
    backgroundAsteroids[i] = new BackgroundAsteroid(random(0,width),random(-50,height),random(5,20),random(3,15));
  }
  //Prompts user to set their name
  spaceShip.setShipName();
}

// CONTROLS
void keyPressed() {
  println(key);
  
  //Choosing Difficulty
  if(gameState == 0) {
    //Difficulty option determines speed of asteroids
    if (keyPressed) {
      if (key == '1') {
        gameDifficulty = 1;
      }
      else if (key == '2') {
        gameDifficulty = 2;
      }
      else if (key == '3') {
        gameDifficulty = 3;
      }
      else if (key == '4') {
        gameDifficulty = 4;
      }
      else if (key == '5') {
        gameDifficulty = 5;
      }
      else if ((key == 'C') || (key == 'c')) {
        gameState = 2;
      }
    }
  }
  
  //Controls Menu
  else if (gameState == 2) {
    if ((keyPressed) && ((key == 'b') || (key == 'B'))) {
      gameState = 0;
    }
  }
  
  
  //In-game
  //UP
  if (key == 'w' || key == 'W') {
    spaceShip.yUp = true;
  }
  //DOWN
  if (key == 's' || key == 'S') {
    spaceShip.yDown = true;
  }
  //LEFT
  if (key == 'a' || key == 'A') {
    spaceShip.xLeft = true;
  }
  //RIGHT
  if (key == 'd' || key == 'D') {
    spaceShip.xRight = true;
  }
}

void keyReleased() {
  //Controls
  switch(key) {
  case 'w':
  case 'W':
    spaceShip.yUp = false;
    break;
  case 's':
  case 'S':
    spaceShip.yDown = false;
    break;
  case 'a':
  case 'A':
    spaceShip.xLeft = false;
    break;
  case 'd':
  case 'D':
    spaceShip.xRight = false;
    break;
  }
}


void draw() {
  background(0);
  //Draws and updates the stars array
  for (int i = 0; i < starCount; i++) {
    stars[i].drawStar();
    stars[i].moveStar();
  }
  //Draws and updates the backgroundAsteroids array
  for (int i = 0; i < backgroundAsteroidCount; i++) {
    backgroundAsteroids[i].drawBackgroundAsteroid();
    backgroundAsteroids[i].moveBackgroundAsteroid();
  }
  fill(255);
  
    //START SCREEN
  if (gameState == 0) {
    textSize(25);
    textAlign(LEFT);
    text("[C] Controls",width/32,height-height/32);
    textSize(50);
    textAlign(CENTER);
    text("Asteroid Belt v1.21",width/2,height/3);
    textSize(15);
    text("By Mantas Rajackas",width/2,height/3+height/32);

    //Difficulties
    textSize(25);
    text("Choose a Difficulty", width/2,height/2);
    textSize(20);
    
    //EASY
    if(gameDifficulty == 1) {
      for (int i = 0; i < asteroids.length; i++) {
        asteroids[i].setSpeedMultiplier(0.5);
      }
      fill(0,255,0);
    }
    text("[1] - Easy", width/2,height/2+height/32);
    fill(255);
    
    //MEDIUM
    if(gameDifficulty == 2) {
      for (int i = 0; i < asteroids.length; i++) {
        asteroids[i].setSpeedMultiplier(0.8);
      }
      fill(0,255,0);
    }
    text("[2] - Medium", width/2, height/2+height/32*2);
    fill(255);
    
    //HARD
    if(gameDifficulty == 3) {
      for (int i = 0; i < asteroids.length; i++) {
        asteroids[i].setSpeedMultiplier(1.2);
      }
      fill(0,255,0);
    }
    text("[3] - Hard", width/2, height/2+height/32*3);
    fill(255);
    
    //WHY EVEN BOTHER
    if(gameDifficulty == 4) {
      for (int i = 0; i < asteroids.length; i++) {
        asteroids[i].setSpeedMultiplier(2);
      }
      fill(0,255,0);
    }
    text("[4] - Why Even Bother", width/2, height/2+height/32*4);
    fill(255);
    
    //SERIOUSLY. DON'T BOTHER.
    if(gameDifficulty == 5) {
      for (int i = 0; i < asteroids.length; i++) {
        asteroids[i].setSpeedMultiplier(4);
      }
      fill(0,255,0);
    }
    text("[5] - No, Seriously. Don't Bother.", width/2, height/2+height/32*5);
    
    //Draws ship on main menu
    spaceShip.drawShip();
    spaceShip.setXCoord(2);
    
    //Once difficulty chosen
    if (gameDifficulty != 0) {
      textSize(25);
      fill(255);
      text("Press [Space] to begin", width/2, height-height/4);
      if ((keyPressed) && (key == ' ')) {
        gameState = 1;
        starTimer = millis();
        println(starTimer);
      }
    }
  }
  
  //GAME RUNNING
  else if (gameState == 1) {
    for (int i = 0; i < asteroids.length; i++) {
      //Gets coordinates for asteroids and ship's hitbox
      float x1 = asteroids[i].getXCoord();
      float y1 = asteroids[i].getYCoord();
      float x2 = spaceShip.getHitX();
      float y2 = spaceShip.getHitY();
      float r1 = asteroids[i].getSize() / 2;
      float r2 = spaceShip.getHitRad();
      asteroids[i].drawAsteroid();
      asteroids[i].moveAsteroid();
      
      //Resets the asteroids and updates ship's health if collided
      if (asteroids[i].collide(x1,y1,x2,y2,r1,r2)) {
        asteroids[i].despawn();
        spaceShip.setHealth(spaceShip.getHealth() - 1);
      }
      
    }
    
    //Draws ship and checks for controls
    spaceShip.drawShip();
    spaceShip.moveShip();
    spaceShip.drawHealthBar();
    
    //Checks if player has lost
    if(spaceShip.getHealth() == 0) {
      gameState = 3;
      endTimer = millis();
    }
    gameTimer = endTimer - starTimer;
    
  }
  
  //CONTROLS MENU 
  else if (gameState == 2) {
    textSize(20);
    textAlign(CENTER);
    text("Controls:", width/2, height/2 - height/32);
    text("[WASD] to move", width/2,height/2);
    textAlign(LEFT);
    textSize(25);
    text("[B] to return", width/32,height-height/32);
  }
  else {
    //GAME OVER SCREEN
    
    //Determines final score (Time survived in seconds)
    spaceShip.setScore(gameTimer/1000);
    
    textSize(50);
    textAlign(CENTER);
    text("GAME OVER", width/2, height/2);
    textSize(15);
    String endName = "Name: " + spaceShip.getShipName();
    String endScore = "Seconds Survived: " + spaceShip.getScore();
    String endDifficulty = "";
    switch (gameDifficulty) {
      case 1:
        endDifficulty = "[Easy]";
        break;
      case 2:
        endDifficulty = "[Medium]";
        break;
      case 3:
        endDifficulty = "[Hard]";
        break;
      case 4:
        endDifficulty = "[Why Even Bother]";
        break;
      case 5:
        endDifficulty = "[Seriously. Don't Bother.]";
        break;
    }
    text(endName, width/2,height/2+height/16);
    text("Difficulty: " + endDifficulty, width/2, height/2+height/16+height/32);
    text(endScore, width/2,height/2+height/16+height/16);
    textSize(25);
    text("Press [space] to restart", width/2,height-height/4);
    
    //Restarting game
    if((keyPressed) && (key == ' ')) {
      //Resetting ship
      spaceShip.setHealth(10);
      spaceShip.setXCoord(width/2);
      spaceShip.setYCoord(height-height/6);
      spaceShip.setScore(0);
      gameState = 0;
      gameDifficulty = 0;
      for(int i = 0; i < asteroids.length; i++) {
        //Re-randomising asteroid locations
        asteroids[i].setXCoord(random(0,width));
        asteroids[i].setYCoord(0-(random(width)));
      }
    }
  }
}
