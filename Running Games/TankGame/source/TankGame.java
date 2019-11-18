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

public class TankGame extends PApplet {

//Name : Jakub Rogalski
//Course Name: Entertainment Systems

/*This is a tank game where you take the role of a tank shooter.
Choose your name and how many chances you want...
Shoot the tank with the left mouse button
The delay in the shot is meant to give the player the depth of
distance between where you shoot from and the tank.
When you hit the tank it dies and you win.
You're going to be told how many shots it took you to kill the
tank if you didnt count.*/



//Objects used in the game
Crosshair cross;
Background bg;
Enemy enemy;
Explosion explos;
Player p1;

int bulletX[];
int bulletY[];
int index = 0; //keeps track of the array
int time = 0; //helps out with delay between shots
int magazineSize;
int difficulty;

public void setup() {
  
  noCursor();
  bg = new Background(0xffccccff, 0xffdddddd); //sky color, ground color
  cross = new Crosshair(150); //crosshair middle circle customizable size
  explos = new Explosion(-20, -20); // don't change

  //player name
  p1 = new Player(JOptionPane.showInputDialog("What is your name general?\n ")); //player name input

  //introduction and ammo
  //bug fix for open day...Siobhan
  String numberMagazine = JOptionPane.showInputDialog("This is war, and your soldier is at\na new mission to destroy one of the\nenemy tanks.\n\nHow much ammo do you require general?", "10");
  if (numberMagazine == null){
    magazineSize = 10;
  }
  else {
    try{
       magazineSize = Integer.parseInt(numberMagazine);
    }
    catch(Exception e){
      magazineSize = 10;
    }
  }

  bulletX = new int[magazineSize+1];
  bulletY = new int[magazineSize+1];
  for (int i = 0; i<=magazineSize; i++) {
    bulletX[i] = 0;
    bulletY[i] = 0;
    i++;
  }
  //difficulty
  String chosenDifficulty = JOptionPane.showInputDialog("What difficulty do you want?\n\n0 = Easy Peasy\n1-3 = Easy\n4-6 = Medium\n7-10 = Hard\n11-15 = Insane\n16-19 = Extreme\n20 = WARZONE\n ", "5");
  if (chosenDifficulty == null){
    difficulty = 1;
  }
  else {
    try{
       difficulty = Integer.parseInt(chosenDifficulty);
    }
    catch(Exception e){
      difficulty = 1;
    }
  }


  
  
  enemy = new Enemy(300, 300, 125, difficulty); // tank x,y starting pos, color, speed
}

public void draw() {  
  //everything together here
  bg.display();
  enemy.live();
  enemy.display();
  explos.fire();
  explos.explosion();
  cross.live();
  cross.display();
  //bullet firing and lose condition
  shootBullets();
  bulletHoles();
  //win condition
  victory();
}

public void shootBullets() { // this is  a method to draw the delay in shot/hit
  if (mousePressed && mouseButton==LEFT && millis() > time +1000) {
    time = millis();
    explos.setExplosionRadius(5);
    explos.setExplosionX(mouseX);
    explos.setExplosionY(mouseY);
    bulletX[index] = mouseX;
    bulletY[index] = mouseY;
    index++;
    if (index == magazineSize+1) {
      JOptionPane.showMessageDialog(null, "Mission failed, we'll get them next time");
      exit();
    }
  }
}
public void bulletHoles() {  //draws bullet holes when your shots hit the ground
  if (millis()>time+2200) {
    fill(0);
    for (int i =0; i<index; i++) {              //
      ellipse(bulletX[i], bulletY[i], 10, 10);  //    This is the only way i was able to draw 
    }                                           //    the bullet holes so they stay in place
  }                                             //    instead of disappearing
  for (int i =0; i<index; i++) {                //
    ellipse(bulletX[i], bulletY[i], 10, 10);    //
  }
}
public void victory() { //if you hit the tank u win essentially
  if (explos.explosionRadius==100 && explos.explosionX>=enemy.xCoord && explos.explosionX<=enemy.xCoord+enemy.hitbox
    && explos.explosionY>=enemy.yCoord && explos.explosionY<=enemy.yCoord+enemy.hitbox) {
    JOptionPane.showMessageDialog(null, "Mission accomplished general "+p1.getSoldierName()+"!\n\n You took "+index+" round(s) to make our victory");
    exit();
  }
}
public class Background {
  private int horizon; //adjustable sky color
  private int ground; //adjustable ground color

  //Constructor for inputs of colours
  public Background(int horizon, int ground) {
    setHorizon(horizon);
    setGround(ground);
  }

  //draws background
  public void display() {
    //HORIZON
    noStroke();
    fill(horizon);
    for (int i=0; i<200; i+=35) {
      ellipse(width/2, i, 1000, 100);
    }
    //GROUND
    fill(ground);
    for (int i=200; i<height; i+=35) {
      ellipse(width/2, i, 1000, 100);
    }
  }

  //getter methods
  public float getHorizon() {
    return horizon;
  }

  public float getGround() {
    return ground;
  }

  //setter methods
  public void setHorizon(int horizon) {
    if (horizon>=0xffc8c8ff) {
      this.horizon = horizon;
    } else {
      this.horizon = 0xffc8c8ff;
    }
  }
  public void setGround(int ground) {
    if (ground>=0xffc8c8ff) {
      this.ground = ground;
    } else {
      this.ground = 0xffc8ffc8;
    }
  }
}
public class Crosshair {
  private float xCoord; //x coordinate of the crosshair
  private float yCoord; //y coordinate of the crosshair
  private int crosshairCircle; //determines the circle of the crosshair


  //Constructor to default the initial position of the crosshair
  public Crosshair(int crosshairCircle) {
    setCrosshairCircle(crosshairCircle);
  }

  //draws crosshair
  public void display() {
    //dark area
    fill(0);
    noStroke();
    rect(0, 0, xCoord-200, height); 
    rect(width, 0, xCoord-600, height);
    rect(0, 0, width, yCoord-100);
    rect(0, height, width, yCoord-500);
    //crosshair
    noFill();
    stroke(1);
    strokeWeight(99);
    ellipse(xCoord, yCoord, 460, 360);
    strokeWeight(1);
    ellipse(xCoord, yCoord, crosshairCircle, crosshairCircle);
    line(xCoord, yCoord-100, xCoord, yCoord+100);
    line(xCoord-200, yCoord, xCoord+200, yCoord);
  }

  //Aiming with the crosshair
  public void live() {
    xCoord = mouseX;
    yCoord = mouseY;
  }

  //getter methods
  public float getXCoord() {
    return xCoord;
  }

  public float getYCoord() {
    return yCoord;
  }

  //setter methods
  public void setCrosshairCircle(int crosshairCircle) {
    if ((crosshairCircle>=30)&&(crosshairCircle<=200)) {
      this.crosshairCircle = crosshairCircle;
    } else {
      this.crosshairCircle = 100;
    }
  }
}
public class Enemy {
  private float xCoord; //x coordinate of the tank
  private float yCoord; //y coordinate of the tank
  private float hitbox = 90; //for being hit
  private int paint; //set color of the tank
  private int xSpeed; //set X axis speed of the tank
  private int ySpeed; //set Y axis speed of the tank
  private int speed; //both speeds are the same but need to be kept separate
  private int look; //direction of the rifle

  //Constructor to default position of the tank
  public Enemy(int xCoord, int yCoord, int paint, int speed) {
    setXCoord(xCoord);
    setYCoord(yCoord);
    setPaint(paint);
    setSpeed(speed);
  }

  //draws tank
  public void display() {
    noStroke();
    noFill();
    rect (xCoord, yCoord-20, hitbox, hitbox); //hitbox
    stroke(0);
    fill(paint); //colour
    rect(0+xCoord+look, 10+yCoord, 50, 10); //gun looking left
    ellipse(50+xCoord, 25+yCoord, 30, 50); //entrance
    rect(15+xCoord, 25+yCoord, 70, 30); //body
    for (int i = 0; i<80; i+=20) { //wheel loop
      ellipse(20+xCoord+i, 55+yCoord, 20, 20);
    }
  }

  //Tank movement
  public void live() {
    xCoord = xCoord + xSpeed;
    yCoord = yCoord + ySpeed;

    //if ball hits left or right
    if (xCoord+hitbox>width) {
      xSpeed = xSpeed * -1;
    } else if (xCoord<0) {
      xSpeed = xSpeed * -1;
    }

    //direction of the rifle
    if (xSpeed<0) {
      look = 0;
    } else {
      look = 50;
    }


    //if ball hits top or bottom
    if (yCoord+hitbox > height) {
      ySpeed = ySpeed * -1;
    } else if (yCoord < 200) {
      ySpeed = ySpeed * -1;
    }
  }

  //getter methods
  public float getXCoord() {
    return xCoord;
  }

  public float getYCoord() {
    return yCoord;
  }

  //setter methods
  public void setXCoord(int xCoord) {
    if ((xCoord<width)&&(xCoord>0)) {
      this.xCoord = xCoord;
    } else {
      this.xCoord = width/2;
    }
  }

  public void setYCoord(int yCoord) {
    if ((yCoord<height)&&(yCoord>200)) {
      this.yCoord = yCoord;
    } else {
      this.yCoord = height/2;
    }
  }
  public void setPaint(int paint) {
    this.paint = paint;
  }
  public void setSpeed(int speed) {
    if ((speed<=20)) {
      this.xSpeed = speed;
      this.ySpeed = speed-2;
    } else {
      this.xSpeed = 5;
      this.ySpeed = 3;
    }
  }
}
public class Explosion {
  private int timer = 0; //timer for delay of enemy hit
  private int explosionRadius = 0;//radius for the explosion
  private int explosionX; // positions of the shots 
  private int explosionY;
  private int shotsFiredX = 0;
  private int shotsFiredY = 0;

  public Explosion(int shotsFiredX, int shotsFiredY) {
    setExplosionX(shotsFiredX) ;
    setExplosionY(shotsFiredY);
  }

  public void fire() {  
    if (mousePressed && mouseButton==LEFT) {
      explosionRadius = 5;
    }
    stroke(0xffff0000);
    noFill();
    ellipse(explosionX, explosionY, explosionRadius, explosionRadius);
  }

  public void explosion() {
    if (millis() > timer + 100 && explosionRadius < 100 && explosionRadius > 0) {
      timer = millis();
      explosionRadius += 5;
    } else if (explosionRadius >= 100) {
      explosionRadius = 0;
      shotsFiredX++;
      shotsFiredY++;
    }
  }
  //getters
  public int getTimer() {
    return timer;
  }
  public int getExplosionRadius() {
    return explosionRadius;
  }
  public int getExplosionX() {
    return explosionX;
  }
  public int getExplosionY() {
    return explosionY;
  }
  public int getShotsFiredX() {
    return shotsFiredX;
  }
  public int getShotsFiredY() {
    return shotsFiredY;
  }
  //setters
  public void setExplosionX(int explosionX) {
    this.explosionX = explosionX;
  }
  public void setExplosionY(int explosionY) {
    this.explosionY = explosionY;
  }
  public void setExplosionRadius(int explosionRadius) {
    this.explosionRadius = explosionRadius;
  }
}
public class Player {
  private String soldierName;
  public Player(String soldierName) {
    //bug fix for open day...Siobhan
    if (soldierName != null){
      if (soldierName.length() < 8) { //name checking if it's too long
        this.soldierName = soldierName;
      } else {
          this.soldierName = soldierName.substring(0, 8);
      }
    }
    else{
      soldierName = "General WIT";
    }
  }
  //getter
  public String getSoldierName() {
    return soldierName;
  }
  
  //setter
  public void setSoldierName() {
    this.soldierName = soldierName.substring(0,8);
  }
  
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TankGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
