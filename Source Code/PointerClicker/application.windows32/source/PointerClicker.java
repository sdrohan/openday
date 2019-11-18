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

public class PointerClicker extends PApplet {

/*
Name : Marcin Budzinski
Course Name: Entertainment Systems

  It's a simple game, click the moving balls to increase your score. 
  Balls moving faster give a higher score based on speed multiplier on points
  There's bonus points for how fast the balls get clicked.
  20 second multiplier, for the 1st second of the game all balls clicked give 20x points 2nd second give 19x
  3rd second gives 18x points and so on...
  Change the numOfBalls to however many balls you want to show up on the screen.
 */
 
  
PFont myFont;
int numOfBalls = 10;
int numOfBallsRemaining = numOfBalls;
int points = 0;

Ball[] balls = new Ball[numOfBalls];

public void setup()
{
  myFont = createFont("impact", 32);
  textFont(myFont);
  frameRate(60);
  
  for(int i = 0; i < numOfBalls; i++) 
  {
    balls[i] = new Ball
      (PApplet.parseInt (random(25,height-50)),PApplet.parseInt(random(25,width -50)),PApplet.parseInt(random(-3,5)), PApplet.parseInt(random(-3,5)),40);
  }
}

public void draw() 
{
  background(35);
  for(int i = 0; i < numOfBalls; i++)
  {
    balls[i].display();
    balls[i].update();
  }
    textOnScreen();
}
public class Ball 
{
  
  public  int y = 100;
  public  int x = 400;
  private int dy = 5;
  private int dx = 0;
  private int size = 15;
  
  public Ball(int x, int y, int dx,int dy, int size)
  {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.size = size;
  } 
    // This defines the class, it gives it the constructor values for, x and y pos
    // x and y speeds ( using dx dy ) and size of the ball.
  
public void update() 
  {  
    // method inside of a method to simplify the code on main page.
    move();
    wallCollision();
  }
  
public void move()
  {
    y += dy; 
    // Adds the given dy value to the given y value on the main page.
    x += dx; 
    // Adds the given dx value to the given y value on the main page.
  } 
  
public void wallCollision()
  {
    if (horizontalWall()) 
    {
        setdy(getdy() * -1); 
    }    
         // If boolean method horizontalWall() is true then multiplies speed of the ball by -1 
         // reversing it's direction and making it "bounce" otherwise if false then ball keeps moving in the same direction.
  
      if (verticalWall()) 
      {
        setdx(getdx() * -1);
      }  
         // If boolean method verticalWall() is true then multiplies speed of the ball by -1
         // reversing it's direction and making it "bounce" otherwise if false then ball keeps moving in the same direction.
  }
  
public boolean verticalWall()
  { 
    // Method called verticalWall checks collisions with the vertical walls.
     if (getX()+(getSize()/2) > width || getX()-(getSize()/2) < 0 ) 
    { 
       // True or false boolean statement if set X value - ball diameter /2 is more than width then the statement is true.
        return true;
    }
        return false;
  }
 
public boolean horizontalWall()
  {
      if (getY()+(getSize()/2) > height || getY()-(getSize()/2) < 0 ) 
    {
         return true;
    }
         return false;
  }
  
public void display()
  {  
    fill(0);
    strokeWeight(3);
    stroke(255,0,0);
    ellipse(x,y,size,size);
  } 
    // This code displays the ellipse , it's values are inputed in the new Ball.
  
  public void setdy(int dy)
  { 
    // dy in th bracket gets replaced by the dy on the very top.
    this.dy = dy;
    // takes the main dy value using "this." .
  } 
    //Accept a value of type integer, accepted value called dy only inside the current bracket.
  
  public void setdx(int dx)
  { 
    // dx in th bracket gets replaced by the dx on the very top.
    this.dx = dx;  
    // takes the main dx value using "this." .
  } 
    //Accept a value of type integer, accepted value called dy only inside the current bracket.
  
  public int getdy() 
  { 
    //when we call ball.getdy from the other file, we'll get 5
    return this.dy;  
  }
  
  public int getdx() 
  { 
    //when we call ball.getdy from the other file, we'll get 0 
    return this.dx;
  }
   
     
  public int getX() 
{
    return this.x;
}

public int getY() 
{
    return this.y;
}

  
public boolean pressingEllipse(int x, int y) 
{ 
    double distance = Math.sqrt(Math.pow((x - getX()), 2) + Math.pow((y - getY()), 2)); 
    // sqrt is square root and pow is all the numbers to the power of themselves inside the pow brackets.
    if(distance <= getSize()/2)
    { 
      // If x and y is less than or equal to the radius of the object then  statement = true
      return true;
      }
      return false;
}
  
  public void moveBall()
{
      float dist = sqrt((x - mouseX) * (x - mouseX) + (y - mouseY) * (y - mouseY)); 
      // distance formula, x (centre of the circle)  - mouseX squared, Y (centre of the circle) - mouseY squared
      if(dist <= 20) 
    { 
        // if  the distance from the mouse is less than or equal to 20 from the centre of the ball
        // then move ball to -100 -100
        x = -100;
        y = -100;
        int speedBonus = abs(PApplet.parseInt(dx + dy)); 
        // function inside a function, takes absolute value (-7 is 7 spaces from 0 so value is 7)
        // converts to int and  how fast the ball is moving
        int timeBonus = PApplet.parseInt((20000.0f / millis()) * 10); 
        // Up to 20 seconds we get a bonus multiplier. 
        // 20000 seconds divided by millis = 2 * 10 = our bonus value
        points =  points +10 + speedBonus + timeBonus;
        numOfBallsRemaining--;
    }
}

public int getSize()

     // Getter for the size of the ball.
{ 
        return this.size;
} 
  
  
  
}

public void textOnScreen()
{  
  textAlign(CENTER);
  textSize(32);
  fill(244);
  text("Points: "+ points + "\nBalls Remaining: "+ numOfBallsRemaining, width /2, 60);
  
  if(numOfBallsRemaining == 0)   
      {      
     textSize(50);
     text("Game Ended!" + "\nFinal Score : " + points ,width /2 , height/ 2);
      }
}

public void mousePressed() 
{
  for(int i = numOfBalls - 1; i >= 0; i--) 
  { 
    // -1 because you want to start on the last index
      if(balls[i].pressingEllipse(mouseX,mouseY))
    {
        balls[i].moveBall();
        break;
    }
    
  }
  
}
  
  public void settings() {  size (1000 , 1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PointerClicker" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}