//  John Burke
//  BSc Information Technology Year 1


/*
This animation is a game of downhill skiing.
Its functions are broken down as follows:

Arrays were used to create a set of coordinates for the trees, both x and y coordinates.
A loop then calls the tree methods and populates it with the variables from the array.
As the game runs, these values are adjusted and redrawn to create the affect of movement.
at restart, the array is repopulated again.
*/

import javax.swing.*; // import swing classes.
PFont gameFont;  
PImage startScreen; 


int speed;
// arrays for tree locations
int [] treeY = new int [11]; // ycoordinates for rows of trees in use in program
int [] tree1X = new int [11];  // xcoordinates for left fow of trees in use in program
int [] tree2X = new int [11];  //  xcoordinates for right row of trees in use in program
int [] treeYOrigional = {650,720,790,860,960,1060,1130,1200,1280,1350,1450};  //values used in program y coordinates for trees
int [] tree1XOrigional = {220,160,90,60,40,60,90,160,230,290,300};   //values used in program x coordinates for left trees
int [] tree2XOrigional = {620,570,500,420,370,400,450,530,590,630,680};   //values used in program x coordinates for right trees

int stage =1;  // stage restricts program to parts
int skiX = 365;  // x coord for skier
int skiY = 400;  // y coord of skier
int directionX = 0;  // set direction movement of skier
int directionY = 0;  // set direction movement of skier
int currentTime = millis()+1000;  // timer
int sec, min;  // monitor time in game
String message;  // used in JOption to populate output
String title;  //   used in JOption to populate output
String player1;//   used in JOption, set to returned inputted value



void setup()
{
  gameFont = loadFont("Bauhaus93-48.vlw");  // load created font
  textFont(gameFont);
  background(255);
  size(730,800);
  frameRate(100);
  for (int i =0; i<treeYOrigional.length ; i++)  // set values for trees array from populated array
  {    
    treeY[i] = treeYOrigional[i];
    tree1X[i] = tree1XOrigional[i];
    tree2X[i] = tree2XOrigional[i];
  }
}


void draw() 
{
  if (stage ==1)  // on startup
  {
    welcome();   // call welcome method
  }
  else if (stage ==2)  // start main program when stage = 2
  {  
    background(255);
    strokeWeight(1);
    stroke(0); 
// calling methods dor direction, speed of game, sreate trees and others
    difficulty(); 
    skiDirection(); 
    createTrees(); 
    boundryCheck();
    timer();   
  }
}   // end draw method



void difficulty()  // gradually move trees towards centre
{
  if ((tree1X[1]) <250)
  {
    if (frameCount % 60 == 0)  // every half second trees move 1px closer together
    {
      int i = 0;
      while (i<treeY.length)
      {
        tree1X[i] ++ ;
        tree2X[i] -- ; 
        i++;
  //      println(tree1X[1]);  // added to check values during construction
      }
    }
  }
}


void timer()  // method to keep time for game 
{
  if(millis()>=currentTime)
  {
    currentTime = millis()+1000;
    sec ++;
    if (sec == 60)
    {
      sec=0;
      min ++;    
    }
  }
  fill(#db150a);  // method to display time on top of screen
  textAlign(CENTER);
  if (min >0)
  {
    text(min +":mins  " +sec+ ":secs",width/2,50);
  }
  else
  {
    text(sec+ ":secs",width/2+80,50);
  } 
}

 
void welcome()  // text on welcome screen
{
  background(255);
  startScreen = loadImage("ski.jpg");
  image(startScreen,0,0,width,height);
  fill(0);
  textSize(40);
  textAlign(CENTER);
  text("Welcome to Downhill Skiing", width/2, 50);
  textSize(32);
  text("Use Arrow keys to move and \n'ctrl' to stop moving.", width/2, 650);
  text("Press any key over this screen to continue....", width/2, 770);
  if (keyPressed)
  {
    stage=2;
    player1 = playerName();
    speed = chooseLevel();  // returning value from method to set value for variable speed
  }
}
 
 
String playerName()  // method to request players name and return it to method as string 
{
  String message = "Please enter your name :";
  String player= JOptionPane.showInputDialog(null, message);
  return player; 
}


int chooseLevel()  // method to select difficulty by speed, called and returned value inside welcome method as integer
{
  message = "Select difficulty level\n\n" + "1: Easy\n" + "2: Medium\n" + "3: Difficult\n" + "4: Extreme\n";
  //error handling put in for open day....siobhan.
  int level = 1;
  try{
    level=Integer.parseInt(JOptionPane.showInputDialog(null, message,"2"));
  }
  catch(Exception e){
  }
  return level; 
}


void skiDirection()  // show different ski method display depending on direction travelling
{
  if (directionX == 1)
  {
    skiRight();
  }
  else if (directionX == -1)
  {
    skiLeft();
  }
  else
  {
    skiStraight();  // displayed if traveling in vertical direction as x=0
  }
}  


void boundryCheck() // check boundaries, reverse direction at boundries
{
  if  (skiX<14)
  {   
    directionX=1;
  }
   if  (skiX>width-14)
  {   
    directionX=-1; 
  }
  if (skiY>height-42)
  {   
    directionY=-1;
  } 
  if (skiY<42)
  {   
    directionY=1;
  } 
} // end boundry check


void createTrees()  //  create method for lines of trees
{
  for(int i=0;i<treeY.length;i++)
  {
    if(treeY[i] > -60)  // if trees scrolling, not yet y= -60
    {
      tree(tree1X[i],treeY[i]);   // call method to display left trees
      tree(tree2X[i],treeY[i]);  // call method to display right trees
      treeY[i] = treeY[i]-speed;    // adjust values for y coordinates for trees
      collision( tree1X[i], tree2X[i], treeY[i]);  // call method to check for collision with trees
      }
      else  //if values less than -60, then set values to 800
      {
         treeY[i] = 800;   // add to each value of tree to place at bottom of screen again
      }
   }
}


// method for checking collision between trees and skier, calls in values, no return
void collision( int tree1XIn, int tree2XIn, int treeYIn)
{
  int distLeft = int(sqrt(sq(skiX-tree1XIn)+sq(skiY-treeYIn)));
  int distRight = int(sqrt(sq(skiX-tree2XIn)+sq(skiY-treeYIn)));
  if ( distLeft < 50 || distRight < 50)
  {
    crash(treeYOrigional, tree1XOrigional, tree2XOrigional);  // call crash method with array values, no return value
  }
}


void crash(int treeYOrigionalIn[], int tree1XOrigionalIn[], int tree2XOrigionalIn[] )  // checks about replay and sets tree values to origionals from array.
{
  if (min>0)
  {
    message = "Congratulations " +player1+ " !!!! \n You stayed on your skis for " +min+ " mins and " +sec+ " seconds";
  }
  else
  {
    message = "Congratulations " +player1+ " !!!! \n You stayed on your skis for " +sec+ " seconds"; 
  }  
  title = "Ski Resort";
  JOptionPane.showMessageDialog(null, message , title, JOptionPane.PLAIN_MESSAGE); 
  message = "Would you like to play again? ";
  title = "Continue with game";
  int reply = JOptionPane.showConfirmDialog(null, message, title, JOptionPane.YES_NO_OPTION);
  if ( reply == JOptionPane.NO_OPTION)   // if no to replay
  {
    System.exit(0);  // program stops
  }
  if ( reply == JOptionPane.YES_OPTION)  // if yes to replay
  {
    for (int i =0; i<treeYOrigional.length ; i++)  // reset tree locations in arrays
    {
      treeY[i] = treeYOrigionalIn[i];
      tree1X[i] = tree1XOrigionalIn[i];
      tree2X[i] = tree2XOrigionalIn[i];
    }
  // reset game variables
    min=0;
    sec=0;
    skiX = 365;
    skiY = 400;
    directionX = 0; 
    directionY = 0;
  }
}


void keyPressed()  // controls for the ski
{
  if (key == CODED)
  {
    if (keyCode == LEFT)
    {
      directionX=-1;
      directionY=0;
    }
    else if (keyCode == RIGHT)
    {
      directionX=1;
      directionY=0;
    }
    else if (keyCode == UP)
    {
      directionY=-1;
      directionX=0;
    }
    else if (keyCode == DOWN)
    {
      directionY=1;
      directionX=0;
    }
    else if (keyCode == CONTROL)
    {
      directionY=0;
      directionX=0;
    }
  }
}


void skiStraight()  //  ski straight character.
{
  skiX = skiX+(directionX*speed);
  skiY = skiY+(directionY*speed);  
  fill(0);
  ellipse(skiX, skiY, 13,13);    // head
  stroke(0);
  strokeWeight(4);
  line(skiX, skiY+7, skiX, skiY+18);    //  body
  line(skiX-3, skiY+18, skiX-3, skiY+29);  // leg
  line(skiX+3, skiY+18, skiX+3, skiY+29);  // leg
  line(skiX-11, skiY+9, skiX-7, skiY+13);  // forearm
  line(skiX+11, skiY+9, skiX+7, skiY+13); // forearm 
  strokeWeight(2);
  line(skiX-6, skiY+9,skiX+6, skiY+9);   // arms
  stroke(#CB2727);
  strokeWeight(3);
  line(skiX-10, skiY+16, skiX-2, skiY+35);  // skees
  line(skiX+10, skiY+16, skiX+2, skiY+35);  // skees 
  line(skiX-2, skiY+35, skiX,skiY+32);  // skees
  line(skiX+2, skiY+35, skiX, skiY+32);  // skees 
  strokeWeight(2);
  line(skiX-11, skiY, skiX-7, skiY+13);  // poles
  line(skiX+11, skiY, skiX+7, skiY+13);  //poles 
  noStroke();
  fill(255);
  ellipse(skiX-3, skiY, 3,3);  // eyes
  ellipse(skiX+3, skiY, 3,3);  //eyes
}


void skiLeft()  //  ski left character.
{
  skiX = skiX+(directionX*speed);
  skiY = skiY+(directionY*speed);  
  fill(0);
  ellipse(skiX-5, skiY, 13,13);    // head
  stroke(0);
  strokeWeight(4);
  line(skiX-1, skiY+7, skiX+8, skiY+12);    //  body
  line(skiX+8, skiY+12, skiX+2, skiY+21);  // leg
  line(skiX+2, skiY+21, skiX+8, skiY+25);  // leg
  line(skiX+8, skiY+25, skiX+3, skiY+28);  // leg
  line(skiX-1, skiY+7, skiX+5, skiY+9);  // forearm
  line(skiX+5, skiY+9, skiX, skiY+15); // forearm
  strokeWeight(2);
  stroke(#CB2727);  // give a red colour
  line(skiX, skiY+16, skiX+12, skiY);  // poles
  line(skiX, skiY+16, skiX+14, skiY);  // poles
  line(skiX-4, skiY+32, skiX-7, skiY+29);  // ski front
  line(skiX-4, skiY+32, skiX+16, skiY+22);  //ski back
  noStroke();
  fill(255);
  ellipse(skiX-7, skiY+1, 3,3);  //eyes
}


void skiRight()  //  ski right character.
{
  skiX = skiX+(directionX*speed);
  skiY = skiY+(directionY*speed);  
  fill(0);
  ellipse(skiX+5, skiY, 13,13);    // head
  stroke(0);
  strokeWeight(4);
  line(skiX+1, skiY+7, skiX-8, skiY+12);    //  body
  line(skiX-8, skiY+12, skiX-2, skiY+21);  // leg
  line(skiX-2, skiY+21, skiX-8, skiY+25);  // leg
  line(skiX-8, skiY+25, skiX-3, skiY+28);  // leg
  line(skiX+1, skiY+7, skiX-5, skiY+9);  // forearm
  line(skiX-5, skiY+9, skiX, skiY+15); // forearm
  strokeWeight(2);
  stroke(#CB2727);  // give a red colour
  line(skiX, skiY+16, skiX-12, skiY);  // poles
  line(skiX, skiY+16, skiX-14, skiY);  // poles
  line(skiX+4, skiY+32, skiX+7, skiY+29);  // ski front
  line(skiX+4, skiY+32, skiX-16, skiY+22);  //ski back
  noStroke();
  fill(255);
  ellipse(skiX+7, skiY+1, 3,3);  //eyes
}


//  create a tree
void tree(int treeX,int treeY)  //  tree design
{
  noStroke();
  fill(#1DCE27);
  beginShape();  // overall measurements 80 wide, 80 high
  vertex(treeX, -40+treeY);
  vertex(20+treeX, -15+treeY);
  vertex(10+treeX, -15+treeY);
  vertex(30+treeX, 5+treeY);
  vertex(20+treeX, 5+treeY);
  vertex(40+treeX, 25+treeY);
  vertex(-40+treeX, 25+treeY);
  vertex(-20+treeX, 5+treeY);
  vertex(-30+treeX, 5+treeY);
  vertex(-10+treeX, -15+treeY);
  vertex(-20+treeX, -15+treeY);
  endShape(CLOSE);
  fill(#6A4804);
  rect(-5+treeX, 25+treeY,10,15);
}
