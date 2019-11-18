import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import javax.swing.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class AsteroidBelt extends PApplet {

//Name : Mantas Rajackas
//Course Name: Applied Computing

/*  A game where the player must survive as long as possible in 
    an asteroid field */



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

public void setup() {
  background(0);
  
  
  //Generates space ship
  spaceShip = new Ship(width/2,height-height/8, 10);
  
  //Generates array of Star objects
  for (int i = 0; i < starCount; i++) {
    stars[i] = new Star(random(0,width),random(-10,height),random(1,3),random(0.5f,15));
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
public void keyPressed() {
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

public void keyReleased() {
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


public void draw() {
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
        asteroids[i].setSpeedMultiplier(0.5f);
      }
      fill(0,255,0);
    }
    text("[1] - Easy", width/2,height/2+height/32);
    fill(255);
    
    //MEDIUM
    if(gameDifficulty == 2) {
      for (int i = 0; i < asteroids.length; i++) {
        asteroids[i].setSpeedMultiplier(0.8f);
      }
      fill(0,255,0);
    }
    text("[2] - Medium", width/2, height/2+height/32*2);
    fill(255);
    
    //HARD
    if(gameDifficulty == 3) {
      for (int i = 0; i < asteroids.length; i++) {
        asteroids[i].setSpeedMultiplier(1.2f);
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
public class Asteroid {
  //Asteroid obstacles which can collide with the ship's hitbox
  private float xCoord;
  private float yCoord;
  private float size;
  private float speed;
  private float speedMultiplier;

  public Asteroid() {

  }

  public Asteroid(float x,float y,float astSize, float astSpeed) {
    //Limits x values to the width of the window
    if ((x > 0) && (x < width)) {
      this.xCoord = x;
    }
    //Defaults to x being in the centre of the screen
    else {
      this.xCoord = width/2;
    }
    if (y+astSize < 0) {
      this.yCoord = y;
    }
    //Limits of asteroid sizes
    if ((astSize > 50) && (astSize < 200)) {
      this.size = astSize;
    }
    //Defaults to 100 if the asteroid's too big/small
    else {
      this.size = 100;
    }
    //Limits astSpeed to positive values
    if (astSpeed > 0) {
      this.speed = astSpeed;
    }
    //Defaults astspeed to 10
    else {
      this.speed = 10;
    }
    
    this.speedMultiplier = 1;
  }

  public void drawAsteroid() {
    fill(102,64,20);
    ellipse(this.xCoord,this.yCoord,this.size,this.size);
    fill(150,86,30);
    ellipse(this.xCoord-this.size/20,this.yCoord,this.size-this.size/10,this.size-this.size/20);
  }

  public void moveAsteroid() {
    //Moves the asteroids down the screen
    this.yCoord += this.speed*this.speedMultiplier;
    if (this.yCoord-this.size > height) {
      this.yCoord = -400;
      this.xCoord = random(0,width);
      this.speed = random(5,20);
      this.size = random(50,200);
    }
  }
  
  //Checks for collision between two circles (Used for Ship and Asteroid)
  public boolean collide(float x1, float y1, float x2, float y2, float r1, float r2) {
    //Gets the distance of a line between 2 circles, true if length of 2 radii > length of line between the ellipses
    if(dist(x1,y1,x2,y2) > (r1+r2)) {
      return false;
    }
    else {
      //Explosion
      fill(255,0,0);
      ellipse(x1,y1,250,250);
      return true;
    }
  }
  
  //Removes the asteroid once it collides
  public void despawn() {
    this.yCoord = height+height;
  }
  
  //Getters
  public float getXCoord() {
    return this.xCoord;
  }
  
  public float getYCoord() {
    return this.yCoord;
  }
  
  public float getSize() {
    return this.size;
  }
  
  //Setters
  public void setXCoord(float newX) {
    //Limits new asteroid X so at least half the asteroid is on screen
    if ((newX > 0 - this.size/2) && (newX < width+this.size/2)) {
      this.xCoord = newX;
    }
  }
  
  public void setYCoord(float newY) {
    //No lower limit as asteroids past the bottom respawn automatically
    if (newY > 0 - height) {
      this.yCoord = newY;
    }
  }
  public void setSpeed(float spd) {
    if (spd > 0) {
      this.speed = spd;
    }
  }
  public void setSize(float newSize) {
    this.size = newSize;
  }
  public void setSpeedMultiplier(float multiplier) {
    this.speedMultiplier = multiplier;
  }
}
public class BackgroundAsteroid {
  //Very similar to Star, for asteroids in the background with no collision
  private float xCoord;
  private float yCoord;
  private float size;
  private float speed;
  
  
  public BackgroundAsteroid() {
    
  }
  
  public BackgroundAsteroid(float x,float y,float astSize,float astSpeed) {
    this.xCoord = x;
    this.yCoord = y;
    if (astSize > 0) {
      this.size = astSize;
    }
    if (astSpeed > 0) {
      this.speed = astSpeed;
    }
  }
  
  public void drawBackgroundAsteroid() {
    fill(102,64,19);
    ellipse(this.xCoord,this.yCoord,this.size,this.size);
  }
  
  public void moveBackgroundAsteroid() {
    this.yCoord += this.speed;
    //If asteroid leaves screen
    if ((this.yCoord - this.size) > height) {
      this.yCoord = -20;
      this.xCoord = random(0,width);
      this.size = random(5,15);
    }
  }
}
public class Ship {
  private float xCoord;
  private float yCoord;
  private float hitX;
  private float hitY;
  private float hitRad;
  private int health;
  private float score;
  private String name = "____";

  //New Movement Fields
  //Check if ship's x/y shoud be updated 
  //in their respective directions
  private boolean yUp = false;
  private boolean yDown = false;
  private boolean xLeft = false;
  private boolean xRight = false;

  public Ship() {
  }

  public Ship(float xPos, float yPos, int hp) {
    if ((xPos > 25) && (xPos < width-25)) {
      this.xCoord = xPos;
    } else {
      this.xCoord = width/2;
    }
    if ((yPos > 25) && (yPos < height-25)) {
      this.yCoord = yPos;
    } else {
      this.yCoord = width/3;
    }
    if (hp > 0) {
      this.health = hp;
    } else {
      this.health = 10;
    }
    this.score = 0;
  }

  public void drawHealthBar() {
    //Draws player's health bar
    //Border
    fill(50);
    rect(0, height-30, 210, 40);
    //Red bar - HP missing
    fill(128, 0, 0);
    rect(5, height-25, 200, 20);
    //Green bar - HP left
    fill(0, 255, 0);
    //Prevents bar from bugging at 0 hp
    if (this.health > 0) {
      rect(5, height-25, this.health*20, 20);
    }
  }

  public void drawShip() {
    //Draws the player's ship

    for (float i = 0; i < 50; i++) {
      //Smoke
      fill(50, 50, 50, 5);
      ellipse(this.xCoord+random(-10, 10), this.yCoord+55+i, random(20, 30), random(20, 30));
      //Flames
      fill(255, 0, 0, 128);
      ellipse(this.xCoord+random(-5, 5), this.yCoord+55+i, random(5, 10)-i/10, random(5, 30));
      fill(200, 200, 0.128f);
      ellipse(this.xCoord+random(-3, 3), this.yCoord+55+i/1.5f, random(3, 8)-i/10, random(2, 10));
    }
    noStroke();

    //Main Body
    fill(255);
    triangle(this.xCoord, this.yCoord, this.xCoord-10, this.yCoord+40, this.xCoord+10, this.yCoord+40);
    //Window
    fill(0);
    triangle(this.xCoord, this.yCoord+5, this.xCoord-5, this.yCoord+25, this.xCoord+5, this.yCoord+25);
    fill(255);
    //Left Fin
    triangle(this.xCoord, this.yCoord+20, this.xCoord, this.yCoord+35, this.xCoord+25, this.yCoord+50);
    //Right Fin
    triangle(this.xCoord, this.yCoord+20, this.xCoord, this.yCoord+35, this.xCoord-25, this.yCoord+50);
    //Booster
    fill(128);
    rect(this.xCoord-7, this.yCoord+40, 14, 7);
    
    //Shield (Visible hitbox until player's HP is reduced to 1)
    if(this.health > 1) {
    fill(50, 50, 255, map(sin(millis()/75), -1, 1, 100,150));
    ellipse(this.xCoord, this.yCoord+30, this.hitRad*2, this.hitRad*2);
    }
    this.hitX = this.xCoord;
    this.hitY = this.yCoord+30;
    this.hitRad = 25;

    //Name
    fill(255);
    textSize(20);
    text(this.name, this.xCoord, this.yCoord-10);
  }

  //Moves ship and checks collision with borders
  public void moveShip() {
    if (this.yUp == true) {
      if (this.yCoord > 0) {
        this.yCoord -= 6;
      }
    }
    if (this.yDown == true) {
      if (this.yCoord+50 < height) {
        this.yCoord += 6;
      }      
    }
    if (this.xLeft == true) {
      if (this.xCoord - 25 > 0) {
        this.xCoord -= 6;
      }
    }
    if (this.xRight == true) {
      if (this.xCoord + 25 < width) {
        this.xCoord += 6;
      }
    }
  }

  //Getters
  
  public float getHitX() {
    return this.hitX;
  }
  public float getHitY() {
    return this.hitY;
  }
  public float getHitRad() {
    return this.hitRad;
  }
  public int getHealth() {
    return this.health;
  }
  public float getScore() {
    return this.score;
  }
  public String getShipName() {
    return this.name;
  }

  //Setters

  public void setHealth(int hp) {
    if (hp > -1) {
      this.health = hp;
    }
  }

  public void setXCoord(int x) {
    if ((x > 25) && (x < width - 25)) {
      this.xCoord = x;
    }
  }

  public void setYCoord(int y) {
    if ((y > 0) && (y < height)) {
      this.yCoord = y;
    }
  }

  public void setScore(float score) {
    if (score > -1) {
      this.score = score;
    }
  }

  public void setShipName() {
    //Prompts user to set name. Doesn't allow < 3 or > 3 characters
    this.name = JOptionPane.showInputDialog("Enter your name (3 chars)", "AAA");
    if (this.name == null) {
      this.setShipName();
    }
    if (this.name.length() != 3) {
      this.setShipName();
    }
  }
}
// White stars in the background
public class Star {
  private float xCoord;
  private float yCoord;
  private float starSize;
  private float starSpeed;
  
  public Star() {
  }
  
  public Star(float x, float y, float size, float spd) {
    this.xCoord = x;
    this.yCoord = y;
    this.starSize = size;
    this.starSpeed = spd;
  }
  
  // Draws the visible star
  public void drawStar() {
    fill(255);
    ellipse(this.xCoord,this.yCoord,this.starSize,this.starSize);
  }
  
  //Moves star down the screen and resets once they leave the screen
  public void moveStar() {
    this.yCoord += this.starSpeed;
    //If star leaves screen
    if ((this.yCoord + this.starSize) > height) {
      this.yCoord = -20;
      this.xCoord = random(0,width);
    }
  }
}
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "AsteroidBelt" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
