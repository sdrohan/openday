import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class FroggerGame extends PApplet {

//Name : James Richardson
//Programme Name: Computer Forensics and Security
 
/* Frog begins at the left side of the screen
 if hit by one of the cars, the frog resets to the left. 
 */

Frog frog;
Car[] cars = new Car[8];

int i;//for loop-cars
boolean hitFrog;
boolean collision;
int[] x = {215, 265, 315, 365, 415, 465, 515, 565};//eight cars

//variables for the objects
public void setup() {

  
  noCursor();
  for (int i=0; i < 8; i++) {
    cars[i] = new Car(255, 0, 0, x[i], 0, random(3, 10));//random speed of 8 cars
  }
  frog = new Frog(140, 227, 169, 10, 400, 25);
} //void setup


//methods for the objects
public void draw() {
  background(200);//road
  fill(0, 200, 0);
  rect(0, 0, 200, 800);//starting grass
  fill(0, 200, 0);
  rect(600, 0, 200, 800);//far side grass
  for (i=200; i<700; i=i+50) {//road lines
    line(i, 0, i, 800);
  } //lines

  for (int x = 0; x < 8; x++) {
    boolean collision = hitFrog(frog, cars[x]);
    if (collision == true) { 
      frog.resetFrog(); //resets frog to left side
    }
    cars[x].down();
    cars[x].display();
  }
  frog.move();
  frog.show();
}//void draw

public boolean hitFrog(Frog frog, Car car) {
  //These variables measure the magnitude of the gap between the paddle and the ball.  
  float circleDistanceX = abs(frog.getXfrog() - car.getXpos());
  float circleDistanceY = abs(frog.getYfrog() - car.getYpos() - car.getCarHeight()/2);

  //The Ball is too far away from the Paddle on the X axis to have a collision, so abandon collision detection
  if (circleDistanceX > (frog.getDiameter()/2)) {
    return false;
  }

  //The Ball is too far away from the Paddle on the Y axis to have a collision, so abandon collision detection
  if (circleDistanceY > (car.getCarHeight()/2 + frog.getDiameter()/2)) {
    return false;
  }

  return true;
}    
public class Car { 
  private int red, green, blue, carHeight;
  private float xpos, ypos, yspeed;

  public Car(int red, int green, int blue, float xpos, float ypos, float yspeed) {
    if ((red>-1)&&(red<256)) {
      this.red = red;
    } else {
      this.red=200;
    }
    if ((green>-1)&&(green<256)) {
      this.green = green;
    } else {
      this.green=200;
    }
    if ((blue>-1)&&(blue<256)) {
      this.blue = blue;
    } else {
      this.blue=200;
    }
    if ((carHeight>0)&&(carHeight<40)) {
      this.carHeight = carHeight;
    } else {
      this.carHeight = 30;
    }
    if ((xpos>0)&&(xpos<width)) {
      this.xpos = xpos;
    } else {
      this.xpos=300;
    }
    if ((ypos>-1)&&(ypos<1)) {
      this.ypos = ypos;
    } else {
      this.ypos=ypos;
    }
    if ((yspeed>0)&&(yspeed<12)) {
      this.yspeed = yspeed;
    } else {
      this.yspeed=4;
    }
  } // car arguments 



  //variables for method "display"
  public void display() {
    stroke(0);
    fill(this.red, this.green, this.blue);
    rect(this.xpos, this.ypos, 20, this.carHeight);
  } //void display

  //variables for method "down"
  public void down() {
    this.ypos = this.ypos + this.yspeed;
    if (this.ypos > height) {
      this.ypos = 0; // vans repeat at end of screen
    } //if
  }//void down

  //getters
  public int getRed() {
    return red;
  }

  public int getGreen() {
    return green;
  }

  public int getBlue() {
    return blue;
  }

  public int getCarHeight() {
    return carHeight;
  }

  public float getXpos() {
    return xpos;
  }

  public float getYpos() {
    return ypos;
  }

  public float getYspeed() {
    return yspeed;
  }

  //setters

  public void setRed(int red) {
    if ((red>-1)&&(red<256)) {
      this.red=red;
    } else {
      this.red=200;
    }
  }

  public void setGreen(int green) {
    if ((green>-1)&&(green<256)) {
      this.green=green;
    } else {
      this.green=200;
    }
  }

  public void setBlue(int blue) {
    if ((blue>-1)&&(blue<256)) {
      this.blue=blue;
    } else {
      this.blue=200;
    }
  }

  public void setCarHeight(int carHeight) {
    if ((carHeight>0)&&(carHeight<40)) {
      this.carHeight=carHeight;
    } else {
      this.carHeight = 30;
    }
  }

  public void setXpos(float xpos) {
    if ((xpos>0)&&(xpos<800)) {
      this.xpos=xpos;
    } else {
      this.xpos=0;
    }
  }

  public void setYpos(float ypos) {
    if ((ypos>0)&&(ypos<800)) {
      this.ypos=ypos;
    } else {
      this.ypos=400;
    }
  }

  public void setYspeed(float yspeed) {
    if ((yspeed>0)&&(yspeed<12)) {
      this.yspeed=yspeed;
    } else {
      this.yspeed=4;
    }
  }
}//class car
public class Frog {//class frog
  private int red, green, blue;
  private float xfrog, yfrog, diameter;



  public Frog(int red, int green, int blue, float xpos, float ypos, float diameter) {
    if ((red>-1)&&(red<255)) {
      this.red = red;
    } else {
      this.red=200;
    }
    if ((green>-1)&&(green<255)) {
      this.green = green;
    } else {
      this.green=200;
    }
    if ((blue>-1)&&(blue<255)) {
      this.blue = blue;
    } else {
      this.blue=200;
    }
    if ((xfrog>0)&&(xfrog<800)) {
      this.xfrog = xpos;
    } else {
      this.xfrog=0;
    }
    if ((yfrog>0)&&(yfrog<800)) {
      this.yfrog = ypos;
    } else {
      this.yfrog=400;
    }
    if ((diameter>0)&&(diameter<40)) {
      this.diameter=diameter;
    } else {
      this.diameter=25;
    }
  }//frog

  public void resetFrog() {//resets frog to left side
    xfrog=10;
    yfrog=400;
  }

  public void show() { //Draw Frog
    stroke(0);
    fill(255);
    ellipse(this.xfrog-8, this.yfrog-12, 10, 10); //Left Eye
    ellipse(this.xfrog+8, this.yfrog-12, 10, 10); //Right Eye
    fill(this.red, this.green, this.blue); 
    ellipse(this.xfrog-13, this.yfrog+5, 8, 10); //Left Leg
    ellipse(this.xfrog+13, this.yfrog+5, 8, 10); //Right Leg
    ellipse(this.xfrog, this.yfrog, this.diameter, this.diameter);//Body
  }//voidShow

  public void move() {//move frog around the screen
    if (keyPressed==true) {
      if (key == CODED) {
        if (keyCode == UP) {
          this.yfrog = this.yfrog-5;
        }//up
        if (keyCode == DOWN) {
          this.yfrog = this.yfrog +5;
        }//down
        if (keyCode == LEFT) {
          this.xfrog = this.xfrog -5;
        }//left
        if (keyCode == RIGHT) {
          this.xfrog = this.xfrog +5;
        } //right
      }//if key coded
    }//if key pressed
    if (this.yfrog > height) {//frog resets at top of screen if goes off the bottom
      this.yfrog = 10;
    }
    if (this.xfrog> width) {//frog resets to left of screen if scores point and
      //goes off the right side
      this.xfrog = 10;
    }
  }//void move

  //getters
  public int getRed() {
    return red;
  }//getRed

  public int getGreen() {
    return green;
  }//getGreen

  public int getBlue() {
    return blue;
  }//getBlue

  public float getXfrog() {
    return xfrog;
  }//getXfrog

  public float getYfrog() {
    return yfrog;
  }//getYfrog

  public float getDiameter() {
    return diameter;
  }//getDiameter

  //setters
  public void setRed(int red) {
    if ((red>-1)&&(red<255)) {
      this.red=red;
    } else {
      this.red=200;
    }
  }//setRed

  public void setGreen(int green) {
    if ((green>-1)&&(green<255)) {
      this.green=green;
    } else {
      this.green=200;
    }
  }//setGreen

  public void setBlue(int blue) {
    if ((blue>-1)&&(blue<255)) {
      this.blue=blue;
    } else {
      this.blue=200;
    }
  }//setBlue

  public void setXfrog(float xfrog) {
    if ((xfrog>0)&&(xfrog<800)) {
      this.xfrog=xfrog;
    } else {
      this.xfrog=0;
    }
  }//set Xfrog

  public void setYfrog(float yfrog) {
    if ((yfrog>0)&&(yfrog<800)) {
      this.yfrog=yfrog;
    } else {
      this.yfrog=400;
    }
  }//set Yfrog

  public void setDiameter(float diameter) {
    if ((diameter>0)&&(diameter<40)) {
      this.diameter=diameter;
    } else {
      this.diameter=25;
    }
  }//set Diameter
}//class frog
/*

 Name : James Richardson
 Student Number: 20079103
 Programme Name: Computer Forensics and Security
 
 Brief description of the animation achieved: Frog begins at the left side of the screen
 if hit by one of the cars, the frog resets to the left. 
 
 Known bugs/problems: if game isnt started from the froggerGame tab, the frog doesn't move
 
 Any sources referred to during the development of the assignment: Mostly class notes, especially
 pong game as far as the collision detection. Some Processing.org inspiration as well
 
 
 */
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "FroggerGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
