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

void setup()
{
  myFont = createFont("impact", 32);
  textFont(myFont);
  frameRate(60);
  size (1000 , 1000);
  for(int i = 0; i < numOfBalls; i++) 
  {
    balls[i] = new Ball
      (int (random(25,height-50)),int(random(25,width -50)),int(random(-3,5)), int(random(-3,5)),40);
  }
}

void draw() 
{
  background(35);
  for(int i = 0; i < numOfBalls; i++)
  {
    balls[i].display();
    balls[i].update();
  }
    textOnScreen();
}
