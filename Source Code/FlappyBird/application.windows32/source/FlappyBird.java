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

public class FlappyBird extends PApplet {

//Name: VARUN JAIN
//Programme Name: B.Sc(H) in Applied Computing



Player player = new Player();
bird b = new bird();
pipe[] p = new pipe[3];
boolean start=true, end=false;
int i, k=0, score=0, flag=0, count=0;

class Player // Class for all the player information
{
  private String playerName;
  private int[] scores=new int[20]; 
  private int highestScore=0;
  public void addScore(int score) // Function to add the score to the score array
  {
    if (score >= 0) 
    {
      scores[count] = score;
      count++;
    }
  }
  public String toString()  // Function to display the score and player name
  {
    String str = "Scores for " + playerName + ":\n";
    for (int i = 0; i < count; i++) 
    {
      str = str + "►Score " + (i+1) + ": " +
        scores[i] + "\n";
    }
    return str;
  }
  public int highestScore()  // Function to calculate the high score
  {
    int highestScore = scores[0];
    for (int i = 1; i < count; i++)
    {
      if (scores[i] > highestScore)
      {
        highestScore = scores[i];
      }
    }
    return highestScore;
  }
  public int lowestScore()  // Function to calculate the low score
  {
    int lowestScore = scores[0];
    for (int i = 1; i < count; i++)
    {
      if (scores[i] < highestScore)
      {
        lowestScore = scores[i];
      }
    }
    return lowestScore;
  }
  public float averageScore()   // Function to calculate the average score
  {
    float total = 0.0f;
    for (int i = 0; i < count; i++)
    {
      total = total + scores[i];
    }
    return (total / count);
  }
  public String getplayerName()  // Function to get the player name
  {
    return playerName;
  }
  public void setplayerName(String playerName)  // Function to set the player name
  {
    this.playerName = playerName;
  }
  public int[] getScores()  // Function to get the score array
  {
    return scores;
  }
  public void setScores(int[] scores)  // Function to set the score array
  {
    this.scores = scores;
  }
  public int getCount()  // Function to get the count(or the no. of games played)
  {
    return count;
  }
}

class bird // Class for all the bird actions
{
  float xPos, yPos, ySpeed; 
  bird() // Constructor
  {
    xPos = 150; 
    yPos = 400;
  }
  public void drawBird() // Function to draw the bird
  {
    stroke(255, 255, 0); 
    noFill(); 
    strokeWeight(2); 
    ellipse(xPos, yPos, 20, 20);
  }
  public void jump() // Function to make the bird jump or go up
  {
    ySpeed=-10;
  }
  public void drag() // Function to make the bird fall or go down
  {
    ySpeed+=0.5f;
  }
  public void move() // Function to move the bird forward and pipes backward
  {
    yPos+=ySpeed; 
    for ( i=0; i<3; i++) 
    {
      p[i].xPos-=3;
    }
  }
  public void touch() // Function to check if the bird hits any pipe or not
  {
    if (yPos>800)
    {
      end=false;
    }
    for (i=0; i<3; i++)
    {
      if (((xPos<p[i].xPos+10)&&(xPos>p[i].xPos-10))&&((yPos<p[i].gap-100)||(yPos>p[i].gap+100))) 
      {
        end=false;
      }
    }
  }
}

class pipe // Class for all the pipe actions
{
  float xPos, gap; 
  boolean added = false; 
  pipe(int i) // Constructor  
  {
    xPos = 100+(i*200); 
    gap = random(600)+100;
  }
  public void drawPipe() // Function to draw the pipe
  {
    strokeWeight(5);
    stroke(0, 255, 0); 
    line(xPos, 0, xPos, gap-100); 
    line(xPos, gap+100, xPos, 800);
  }
  public void currentPos() // Function to check the position of the bird with relavance to the pipe and to increase the score
  {
    if (xPos<0) {
      xPos+=(200*3); 
      gap = random(600)+100; 
      added=false;
    } 
    if (xPos<150&&added==false)
    {
      added=true; 
      score++;
    }
  }
}

public void reset() // Function to reset the game and start again
{
  end=true; 
  score=0; 
  b.yPos=400; 
  for ( i=0; i<3; i++)
  {
    p[i].xPos+=550; 
    p[i].added = false;
  }
}

public void mousePressed() // Function to start the game if mouse is clicked
{
  b.jump(); 
  start=false; 
  if (end==false)
  {
    reset();
  }
}

public void keyPressed() // Function to start the game if any key is pressed
{
  b.jump(); 
  start=false; 
  if (end==false)
  {
    reset();
  }
}

public void setup() // Function to initialize the game screen and the pipe object
{
  
  player.setplayerName(JOptionPane.showInputDialog(null, "Welcome to Flappy Bird Game!\n\n " +"Please enter your name: ", "Flappy Bird", JOptionPane.PLAIN_MESSAGE));
  for (i=0; i<3; i++) 
  {
    p[i]=new pipe(i);
  }
}

public void draw() // Function to call the functions of classes bird and pipe and to run the game 
{
  background(0);
  k++;
  fill(0);
  stroke(255);
  textSize(32);
  if (end) 
  {
    stroke(0, 0, 255);
    rect(20, 20, 100, 50);
    fill(255, 0, 0);
    text(score, 30, 58);
  } else 
  {
    if (start)
    {
      rect(150, 300, 180, 50);
      rect(85, 425, 345, 45);
      fill(255);
      text("Flappy Bird", 155, 340);
      if (k%2==0)
        fill(0);
      else
        fill(255);
      text("Press any key to Play", 100, 460);
      delay(300);
      stroke(255, 255, 0);
      fill(0);
      strokeWeight(3);
      ellipse(330, 281, 30, 30);
    } else 
    {
      flag=0;
      player.addScore(score);
      print(player.toString());
      int dialogButton = JOptionPane.YES_NO_OPTION;
      int dialogResult = JOptionPane.showConfirmDialog (null, "Player Name: "+player.getplayerName()+"\n\nCurrent Score: "+score+"\n\n"+player.toString()+
        "\n\nNumber of games played: " +count+"\n\nHighest Score: " + player.highestScore() +"\nLowest Score: "+
        player.lowestScore()+"\nAverage Score: "+player.averageScore()+"\n\nPlay Again?", "Stats", dialogButton);
      if (dialogResult == JOptionPane.YES_OPTION)
      {  
        start=true;
      } else
        exit();
    }
  }
  if (keyPressed || mousePressed)
  {
    flag=1;
  }
  if (flag==1)
  {
    if (end) 
    {
      b.move();
    }
    b.drawBird(); 
    if (end) 
    {
      b.drag();
    }
    b.touch(); 
    for (i=0; i<3; i++)
    {
      p[i].drawPipe(); 
      p[i].currentPos();
    }
  }
}
  public void settings() {  size(500, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "FlappyBird" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
