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

import javax.swing.*;

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

void setup() {
  size(800, 600);
  noCursor();
  bg = new Background(#ccccff, #dddddd); //sky color, ground color
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

void draw() {  
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

void shootBullets() { // this is  a method to draw the delay in shot/hit
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
void bulletHoles() {  //draws bullet holes when your shots hit the ground
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
void victory() { //if you hit the tank u win essentially
  if (explos.explosionRadius==100 && explos.explosionX>=enemy.xCoord && explos.explosionX<=enemy.xCoord+enemy.hitbox
    && explos.explosionY>=enemy.yCoord && explos.explosionY<=enemy.yCoord+enemy.hitbox) {
    JOptionPane.showMessageDialog(null, "Mission accomplished general "+p1.getSoldierName()+"!\n\n You took "+index+" round(s) to make our victory");
    exit();
  }
}