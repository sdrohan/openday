//Name : Przemyslaw Pokorski
//Course Name: Entertainment Systems

/*Brief description of the animation achieved: Pong V11: Game of pong with 2 modes available:
- freeplay (squash style) with highscores
- tournament mode vs cpu controlled paddle
*/

import javax.swing.*;
import java.io.*;

//DECLARATION OF ALL THE GAME OBJECTS
Ball ball;
Paddle playerPaddle;
Paddle cpuPaddle;
Player player;
Player cpu;
scoreHandler scores; 


String[] highscores = new String[10];
int mode = 0;

void setup() {
  background(0);
  size(600, 600);
  noStroke();
  fill(255);  
  frameRate(60);  
  noCursor();
  scores = new scoreHandler();
  scores.loadScore();
}

void draw() {  

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
void gameMode() {  
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
void initTournament() {   
  int[] d = difficulty();
  ball = new Ball(d[0], d[1]); //diameter, velocity multiplier
  playerPaddle = new Paddle(d[4], 20, d[2], height - 5); //width, height, speed, mid point y
  cpuPaddle = new Paddle(100, 20, d[3], 15);

  player = new Player(namePlayer());
  cpu = new Player("CPU");
}

//FREE PLAY OBJECTS CREATION AND STARTING STATS
void initFreePlay() {  
  ball = new Ball(15, 5); //diameter, velocity
  playerPaddle = new Paddle(100, 20, 4, height - 5); //width, height, speed, mid point y  

  player = new Player(namePlayer());
}

//NAME PLAYER + MAKE SURE ITS PROPER + CHECK FOR RETURNING PLAYERS
String namePlayer(){
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
int[] difficulty() { 

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
void bg() {
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