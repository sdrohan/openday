import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import javax.swing.*; 
import java.io.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Pong extends PApplet {

//Name : Przemyslaw Pokorski
//Course Name: Entertainment Systems

/*Brief description of the animation achieved: Pong V11: Game of pong with 2 modes available:
- freeplay (squash style) with highscores
- tournament mode vs cpu controlled paddle
*/




//DECLARATION OF ALL THE GAME OBJECTS
Ball ball;
Paddle playerPaddle;
Paddle cpuPaddle;
Player player;
Player cpu;
scoreHandler scores; 


String[] highscores = new String[10];
int mode = 0;

public void setup() {
  background(0);
  
  noStroke();
  fill(255);  
  frameRate(60);  
  noCursor();
  scores = new scoreHandler();
  scores.loadScore();
}

public void draw() {  

  if (mode == 2) {//tournament
    bg(); 

    playerPaddle.update();    
    cpuPaddle.update(ball);
    ball.update(playerPaddle, cpuPaddle);

    scores.scoreCount(ball.checkBounds());
  } else if (mode == 1) {//freeplay
    bg();

    playerPaddle.update();    
    if (ball.update(playerPaddle)) {
      player.scoreUp(1);
    }

    scores.scoreCount(ball.checkBounds());
  } else {
    gameMode();
  }
}

//MAIN MENU
public void gameMode() {  
  String[] options = { "Free Play", "Tournament", "Quit" }; 
  int choice = JOptionPane.showOptionDialog(frame, "Welcome to ye' old game of pong.\nChoose game mode:", "Pong StartMenu", JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE, null, options, null); //buttons for main menu

  switch(choice) {
  default:
    gameMode();
    break;
  case JOptionPane.YES_OPTION: 
    mode = 1;
    initFreePlay();
    frame.requestFocus();
    break;
  case JOptionPane.NO_OPTION:
    mode = 2;
    initTournament();
    frame.requestFocus();
    break;
  case JOptionPane.CANCEL_OPTION:    
    exit();
  }
}

//TOURNAMENT OBJECTS CREATION AND STARTING STATS
public void initTournament() {   
  int[] d = difficulty();
  ball = new Ball(d[0], d[1]); //diameter, velocity multiplier
  playerPaddle = new Paddle(d[4], 20, d[2], height - 5); //width, height, speed, mid point y
  cpuPaddle = new Paddle(100, 20, d[3], 15);

  player = new Player(namePlayer());
  cpu = new Player("CPU");
}

//FREE PLAY OBJECTS CREATION AND STARTING STATS
public void initFreePlay() {  
  ball = new Ball(15, 5); //diameter, velocity
  playerPaddle = new Paddle(100, 20, 4, height - 5); //width, height, speed, mid point y  

  player = new Player(namePlayer());
}

//NAME PLAYER + MAKE SURE ITS PROPER + CHECK FOR RETURNING PLAYERS
public String namePlayer(){
  String pname;
  if(player != null && player.getNam() != null){
    pname = player.getNam();
  }
  else{
    pname = "Player";
  }
  pname = JOptionPane.showInputDialog(frame, "Input player name: ", pname);
  if (pname == null || pname.length() == 0) {
    return "Player";
  }
  
  return pname;
}

//DIFFICULTY CHOICE MENU
public int[] difficulty() { 

  String[] options = {"Easy", "Normal", "Hard"};
  String choice = (String)JOptionPane.showInputDialog(frame, "Choose difficulty level:", "Difficulty Options", JOptionPane.PLAIN_MESSAGE, null, options, "Normal"); //why are options elements considered objects, but not strings? 
  if (choice == null) {
    return difficulty();
  }

  switch(choice) {
  default:
    return difficulty(); 

  case "Easy": //easy
    {
      int[] d = {15, 5, 5, 4, 120}; //Ball diameter, ball velocity, player paddle speed, cpu paddle speed, paddle width      
      return d;
    } 
  case "Normal"://normal
    {
      int[] d = {13, 6, 5, 5, 100};
      return d;
    }       
  case "Hard":
    {
      int[] d = {10, 8, 4, 6, 80};//hard
      return d;
    }
  }
}

//BACKGROUNDS
public void bg() {
  background(0);


  if (mode == 1) { //freeplay score display
    textSize(34);
    textAlign(LEFT);
    text(player.getScore(), 5, height - 45); //player score
    textSize(12);
    text(player.getNam(), 5, height - 80);
  }

  if (mode == 2) { //TOURNAMENT SCORE DISPLAY    
    for (int x = 0; x < width; x += width/8) { //midline
      rect(x + 5, height/2 - 1, width/8 - 10, 2);
    }
    textSize(34);
    textAlign(LEFT);
    text(player.getScore(), 5, height/2 + 35); //player score
    textSize(12);
    text(player.getNam(), 5, height/2 + 50);
    textSize(34);
    textAlign(RIGHT);
    text(cpu.getScore(), width - 5, height/2 - 10); //cpu score
    textSize(12);
    text(cpu.getNam(), width - 5, height/2 - 40);
  }
}
class Ball {

  private float diameter, velocityVal;
  private PVector position, velocity;  

  Ball(float diameter, float vel) {
    setDiam(diameter);
    setVelocity(vel);
    this.velocityVal = vel;
    position = new PVector(0, 0);    

    ballReset();
  }  


  //MAIN BALL LOGIC
  public boolean update(Paddle player) {//ball movement for freeplay
    boolean bounced = false;    

    if (position.y < (diameter/2)) { //bounce on ceiling   
      bounce(0);
    }
    if (position.x > width - (diameter/2) || position.x < (diameter/2)) { //bounce on right and left edge
      velocity.x *= -1; 
    }
    if (player.collision(position, diameter)) {
      bounced = true;
      bounce(player.direction()); //check for modifier dependant on paddle movement
    }       

    position.add(velocity);    //move the position of ball based on velocity
    ballDraw();

    return bounced;
  }

  public void update(Paddle player, Paddle cpu) {    
    if (position.x > width - (diameter/2) || position.x < (diameter/2)) { //bounce on right and left edge
      velocity.x *= -1;
    }
    if (player.collision(position, diameter)) {
      bounce(player.direction()); //check for modifier dependant on paddle movement
    }
    if (cpu.collision(position, diameter)) {
      bounce(cpu.direction()); //check for modifier dependant on paddle movement
    }

    position.add(velocity); //move the position of ball based on velocity
    ballDraw();
  }

  //MODIFIER TO X-SPEED, BALL CURVING
  public void bounce(float mod) { //when bounced from paddle    
    velocity.y *= -1;
    velocity.setMag(velocity.mag() + 0.5f);
    PVector rotated = velocity; //start with current velocity    
    rotated.rotate(mod); //rotate the vector by the mod from paddle class
    if (rotated.heading() < -0.6f && rotated.heading() > -2.45f) { //radian limits for ~25 and 155 degrees
      velocity = rotated;
    }    
  }

  //CHECK IF BALL PASSED Y-AXIS BOUNDS
  private int checkBounds() {
    if (position.y > height + diameter) {      
      ballReset();
      return 1; //if player lost
    } else if (position.y < - diameter) {
      ballReset();
      return 0; //if cpu lost
    }
    return 3; //if ball still in bounds
  }  

  //BALL GRAPHICS
  private void ballDraw() {        
    ellipse(position.x, position.y, diameter, diameter);
  }

  //BRING BACK BALL INTO PLAY
  public void ballReset() {    
    position.set(width/2, diameter/2 + 50);
    setVelocity(velocityVal); //set velocity magnitude to the starting value
  }

  //GETTERS
  public float getDiam() {
    return diameter;
  }  

  public PVector getPosition() {
    return position;
  }

  public PVector getVelocity() {
    return velocity;
  }

  //SETTERS
  public void setDiam(float diameter) {
    if (diameter < 10) {
      this.diameter = 20;
    } else {
      this.diameter = diameter;
    }
  }

  public void setVelocity(float v) {
    if (v < 0) {
      this.velocity = PVector.fromAngle(random(0.78f, 2.35f)).setMag(5); //SELF COMMENT - CHANGE LATER: No idea what is this warning suggesting. How to call it through class? Class of PVector?
    } else {
      this.velocity = PVector.fromAngle(random(0.78f, 2.35f)).setMag(v);
    }
  }
}
class Paddle {
  private float paddleH, paddleW, paddleS;  
  private PVector position;
  private int sequenceInd, sequenceMod;
  private float[] posXDiff = new float[2];

  private int hitTime = 0;

  Paddle(float paddleW, float paddleH, float paddleS, float posY) {    
    this.paddleW = paddleW;
    this.paddleH = paddleH;
    this.paddleS = paddleS;
    setMiddlePoint(posY);    

    sequenceInd = 0;
    sequenceMod = 1;
  }

  //UPDATE METHODS FOR PLAYER AND CPU PADDLES
  public void update() { //player move
    if (keyPressed && keyCode == LEFT && position.x > paddleW/2) {      
      position.x -= paddleS;
    }
    if (keyPressed && keyCode == RIGHT && position.x < width - paddleW/2) {
      position.x += paddleS;
    }

    sequence();
    display(); //update sequence for movement tracking and draw the paddle
  }

  public void update(Ball b) { //CPU move    
    if (b.velocity.y < 0) {
      if (position.x > b.position.x + 10 && position.x > paddleW/2) {
        position.x -= paddleS;
      }
      if (position.x < b.position.x - 10 && position.x < width - paddleW/2) {
        position.x += paddleS;
      }
    }

    sequence();
    display();//update sequence for movement tracking and draw the paddle
  }

  private void display() {    
    rect(position.x - paddleW/2, position.y - paddleH/2, paddleW, paddleH); //draw paddle relative from its middle point
  }

  //CHECK COLLISION DISTANCE
  public boolean collision(PVector ballPos, float ballDiam) {    
    float distX = abs(ballPos.x - position.x); //distance from middle of ball to middle of paddle X axis
    float distY = abs(ballPos.y - position.y); //distance from middle of ball to middle of paddle Y axis
    float cornerDistL = ballPos.dist(new PVector(position.x - paddleW/2, position.y - paddleH/2));
    float cornerDistR = ballPos.dist(new PVector(position.x + paddleW/2, position.y - paddleH/2));

    if (ballPos.y < height - ballDiam && ballPos.y > ballDiam) { //don't calculate if ball is behind the paddle
      if (distX < paddleW/2 && distY < ballDiam/2 + paddleH/2) { //check if ball hit corner for some additional precision
        if (millis() > hitTime + 500) { //only return true at most once every 500ms
          hitTime = millis();        
          return true;
        }
      }   

      if (cornerDistL < ballDiam/2 || cornerDistR < ballDiam/2) { //check if ball hit corner for some additional precision
        if (millis() > hitTime + 500) { //only return true at most once every 500ms
          hitTime = millis();        
          return true;
        }
      }
    }

    return false; //if distance is too high for any collision to happen
  }

  //SHOW DIRECTION PADDLE IS MOVING TO
  private float direction() {   
    if (posXDiff[sequenceInd] > posXDiff[sequenceInd + sequenceMod]) {            
      return -0.5f; //moving left - value in radians for use with ball curving
    } else if (posXDiff[sequenceInd] < posXDiff[sequenceInd + sequenceMod]) {      
      return 0.5f; //moving right
    } else return 0;//random(-0.5, 0.51);
  }  

  //HELPER METHOD FOR DETERMINING DIRECTION OF PADDLE
  private void sequence() {
    posXDiff[sequenceInd] = position.x; //save current x position
    sequenceInd += sequenceMod; //shift index 
    sequenceMod *= -1; //reverse mod, so index is only ever 1 or 0
  }

  //GETTERS
  public float getHeight() {
    return paddleH;
  }

  public float getWidth() {
    return paddleW;
  }

  public PVector getPosition() {
    return position;
  }

  //SETTERS
  public void setMiddlePoint(float y) {
    if (y > height - paddleH/2 || y < paddleH/2) {      
      position = new PVector().set(width/2, height - 5 - paddleH/2);
    } else {
      position = new PVector().set(width/2, y);
    }
  }
}
class Player {
  private String name, id;
  private int score;

  Player(String name) {    
    setNam(name);
    setID(name);
    score = 0;
  }  


  //SCORE CALCULATION
  public void scoreUp(int score) {
    this.score += score;
  }

  public boolean scoreUp(int score, int limit) {
    this.score += score;

    if (this.score >= limit) {
      return true;
    }

    return false;
  } 

  //GETTERS
  public String getNam() {
    return name;
  }

  public int getScore() {
    return score;
  }

  public String getID() {
    return id;
  }

  //SETTERS

  public void setNam(String name) {
    name = name.replaceAll(" ", "");    
    if (name.length() > 6) {
      this.name = name.substring(1, 6);//shorten name displayed to max of 6 characters after removing empty spaces
    } else this.name = name;
  }  

  public void setID(String name) {
    if (name.length() > 3) {
      id = ((name.toUpperCase()).replaceAll( "[AEIYOU]", "" )).substring(0, 3); //remove wovels and take 3 first letters to form player id for highscore table
    } else id = name.toUpperCase();
  }
}
class scoreHandler {

  //KEEPS SCORE FOR THE CURRRENT GAME
  public void scoreCount(int bounds) { //check if ball is in bounds
    if (mode == 2) {
      if (bounds == 0) { //if cpu loses in tournament 
        if (player.scoreUp(1, 11)) { //score increase, score limit
          gameOver(player.getNam());
        }
      } else if (bounds == 1) {    //if player loses in tournament
        if (cpu.scoreUp(1, 11)) {
          gameOver(cpu.getNam());
        }
      }
    } else {
      if (bounds == 1) { //if player loses in freeplay
        gameOver(player.getNam());
      }
    }
  }

  //ADD NEW PLAYER HS ONTO THE LIST
  public void highscoreUpdate(int i) {    
    if (i <= 9) {      //scores are kept at odd indexes in array of size 10
      if (parseInt(highscores[i]) <= player.getScore()) {   //if score lower than new score is found move all scores one place down and place the new score in position 
        for (int j = 9; j > i; j -= 2) {          
          highscores[j] = highscores[j-2];
        }
        highscores[i] = String.valueOf(player.getScore());
        highscores[i-1] = player.getID();
        return; //score updated - method can end
      } else {
        highscoreUpdate(i + 2); //check for next place if the previous score was higher than player score
      }
    }
  }


  //GAME OVER POP UP
  public void gameOver(String name) {
    highscoreUpdate(1); //compare highscores starting from index 1 in array (even index are players id)
    if (mode == 1) {    
      JOptionPane.showMessageDialog(null, "Game Over!\nScore for " + name + ": " + player.getScore()
        + "\nTOP 5 HIGH SCORES:"
        + scoreJoin());                                                     
      saveScore();
    } else {
      JOptionPane.showMessageDialog(null, "Game Over!\n" + name + " has won!");
    }

    mode = 3;
  }


  //CONVERT STRING ARRAY INTO A DISPLAY FORMATTED STRING
  public String scoreJoin() {
    String scDisp = "";
    for (int i = 0; i < 9; i += 2) {
      scDisp = String.join("", scDisp, "\n", String.valueOf(i/2 + 1), ". ", highscores[i], " - ", highscores[i+1]); //join player id and player score for display in high scores
    }

    return scDisp;
  }

  //READ/WRITE HIGHSCORES TO A FILE
  public void saveScore() {
    FileWriter writer = null;   //

    try {
      writer = new FileWriter(sketchPath() + "/highscore.txt");    //initialize new writeer for the file in sketch location
      for (String str : highscores) {
        writer.write(str + ",");
      }
    } 
    catch (IOException e) { //if there's IO exception - show stack trace and print an error
      println(e + ": Error writing to file");
      e.printStackTrace();
    }
    finally
    { //if no exceptions were thrown
      try {
        if (writer != null) { //try closing the writer if it exists
          writer.close();
        }
      } 
      catch(IOException e) {//if there's IO exception - show stack trace and print an error
        println(e + ": Error closing file");
        e.printStackTrace();
      }
    }
  }

  public void loadScore() { 
    BufferedReader reader = null;  //declare new file reader

    try {
      reader = new BufferedReader(new FileReader(sketchPath() + "/highscore.txt"));   //using buffered reader instead of filereader fot the readline function 
      highscores = reader.readLine().split(","); //try with new file reader initialized for file in the sketch folder
    } 
    catch (IOException e) {//if there's IO exception - show stack trace and print an error
      e.printStackTrace();
    }
    finally
    { 
      try {
        if (reader != null) { //try closing reader if it exists
          reader.close();
        }
      } 
      catch(IOException e) {//if there's IO exception - show stack trace and print an error
        println(e + ": Error closing file");
      }
    }
  }
}
  public void settings() {  size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Pong" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
