/* Name : Michael Stokluska  Student Number: 20079174  Programme Name: Ryu Hoshiro

First user enters her/his name and 3 differenet countries
after which is taken to main menu where game can be started/quit.
Next slide is just few words of introduction including players name and 
name of creature called Ryu Hoshiro.
next slide shows how Ryu travels to work - he works as a border guard 
to country X. Next Ryu approaches his booth to which player has 
to enter the code to enter the booth. Afterwards small creatures 
approach booth and show Ryu their papers. During paper check 
phase player is shown Orders and Passport of the creature. Orders 
are to NOT allow creature from certain country enter countryX. 
Player must look at orders and passport country. If they dont match
he marks OK and creature is being let in to country X, if players 
answers NOT OK creature is send away. Depending on which option 
player choosed creature will say something different. Both, 
country from Order list and country on Passport are randomly
generated from 3 of countries that user had entered when 
programme started. 
*/

import javax.swing.*;

//stars spawn arrays
int [] starsArray={80, 200, 350, -430, 500, 400, -300, 200};
int [] starsArrayY={100, 20, 15, 30, -50, 100, 120, 150};
//small Ryu's spawn arrays
int [] ryuArrayX={50, 50, 50, -200, 100};
int [] ryuArrayY={0, -5, 20, 0, 0};

int timeMap;
//string used for Name of player
String newName;
//strings used for random countries entered by players
String country1c;
String country2c;
String country3c;
//random selection of countries during papers check phase
int randomCountry=int (random(0, 3));
int randomPassport=int(random(0, 3));
//speed of Ryu
float ryuSpeed=1;
//Ryu starting coord
float ryuX=1250;
//random opacity used for different colors
float randomOpacity;
float random1=1;
float random255=255;
//creates font variable
PFont fontMainScreen; 
PFont fontMainScreenButtons;
PFont fontButtonMap3;
//changing colors during introduction phase of Ryu
float oD3=255;
float oD2=0;
float oD=255;
//variables used during keypad phase
int set1Number=0;
int set2Number=0;
int set3Number=0;
int hideKeyX1=500;
int hideKeyY1=400;
int hideKeyX2=560;
int hideKeyY2=400;
int hideKeyX3=620;
int hideKeyY3=400;
//small creature x, speed
int smallRyuX=1200;
int smallRyuXSpeed=2;
//variables used to control the marking square during paper check phase
int markingRectX=500;
int markingRectY=300;
//creature after paper check 
int smallRyuHappy=740;
//creatures coors after paper check
int smallRyuXSpeedHappy=2;
int smallRyuHappyY=650;
int smallRyuXSpeedHappyY=2;
//variable used to check if player decision during paper check phase was correct or not.
int checkIfok;
//blinking of small creatures.
int timer;
//start of the programme
int initialize=0;
//method used for chaning and creating time of map to navigate through different maps.
int timeMap(int timeMaps){
  int result;
  int time[]={1,2,3,4,5,6,7,10,11};
  result=time[timeMaps];
  println(result);
  return result;} 



//tree draw method
void tree(float xTree, float yTree, float treeSize, float treeRcolor, float treeGcolor, float treeBcolor) {
  stroke(0);
  strokeWeight(3);
  fill(139, 69, 19);
  rect(xTree, yTree, 50*treeSize, 50*treeSize);
  fill(treeRcolor, treeGcolor, treeBcolor);
  triangle(xTree-60*treeSize, yTree, xTree+60*treeSize, yTree, xTree, yTree-50*treeSize);
  triangle(xTree-50*treeSize, yTree-40*treeSize, xTree+50*treeSize, yTree-40*treeSize, xTree, yTree-100*treeSize);
  triangle(xTree-30*treeSize, yTree-80*treeSize, xTree+30*treeSize, yTree-80*treeSize, xTree, yTree-150*treeSize);}
  
//small creatures draw method
void Ryu(int xRyu, int yRyu, int colorR) {
  fill(colorR);
  arc(xRyu, yRyu+160, 100, 260, -PI, 0);
  ellipse(xRyu, yRyu, 100, 100);                      
  fill(255);
  triangle(xRyu-20, yRyu, xRyu-30, yRyu-20, xRyu, yRyu-20);
  triangle(xRyu+5, yRyu-20, xRyu+35, yRyu-20, xRyu+25, yRyu);
  if (millis()-timer>10) {
    fill(colorR);
    ellipse(xRyu, yRyu, 100, 100);
    timer=millis();}}

//Ryu draw method
void Ryu(float xRyu, float yRyu) {
  fill(0);//body color
  arc(xRyu, yRyu, 200, 480, -PI, 0);//body
  ellipse(xRyu, yRyu-300, 150, 150);//head
  fill(255);//color of the eyes
  triangle(xRyu-13, yRyu-280, xRyu-13, yRyu-310, xRyu+30, yRyu-310);//eyes
  triangle(xRyu-31, yRyu-310, xRyu-31, yRyu-280, xRyu-58, yRyu-310);}
  
//stars draw method
void stars(int xStar, int yStar) {
  int randomOpacity=int (random(200, 255));
  stroke(255, 255, 255, randomOpacity);
  line(xStar, yStar, xStar+10, yStar);          
  line(xStar+5, yStar-5, xStar+5, yStar+5);
  line(xStar+2, yStar-3, xStar+8, yStar+3);
  line(xStar+8, yStar-3, xStar+2, yStar+3);}
  
//moon draw method
void moon(float xMoon, float yMoon) {
  fill(240, 240, 240 );
  stroke(240, 240, 240 );
  strokeWeight(2);
  ellipse(xMoon, yMoon, 80, 80);
  stroke(250, 250, 250);
  fill(255, 255, 255);
  ellipse(xMoon-5, yMoon-20, 20, 20);
  ellipse(xMoon+25, yMoon-15, 20, 20);
  ellipse(xMoon+15, yMoon+20, 20, 20);
  ellipse(xMoon-25, yMoon, 20, 20);}
  
//rain drops draw method
void rainDrop(float xRain, float yRain) {
  float randomOpacity;
  float randomWeight;
  randomWeight=random(1, 5);
  randomOpacity=random(1, 255);
  stroke(255, randomOpacity);
  strokeWeight(randomWeight);
  line(xRain, yRain, xRain+5, yRain+10);}
  
//method returning Name entered, had to use method to avoid JOption going into loop
String nameMethod(String nameEntered) {
  String nameReturn=nameEntered;
  println(nameReturn);
  return nameReturn;}
  
//method returning country name and setting it as gameplay country
String countryMethod(String country) {
  String countryReturn=country;
  return countryReturn;}

void setup() {
  size(1200, 800);
  ellipseMode(CENTER);
  rectMode(CENTER); 
  textAlign(CENTER);
}

void draw() {
  //countries spawn arrays
  String[] country={country1c, country2c, country3c};
  //Starting time - user inputs name/3 countries  
  if (initialize==0) {    
    String name=JOptionPane.showInputDialog(
      "Welcome\n\n " + "What is Your Name?","");
    newName=nameMethod(name);
//country 1 user input
    String country1=JOptionPane.showInputDialog(
      "Please enter 3 different countries\n\n " +  "COUNTRY no 1:", "");
    country1c=countryMethod(country1);
//country 2 user input
    String country2=JOptionPane.showInputDialog(
      "Please enter 3 different countries\n\n " +  "COUNTRY no 2:", "");
    country2c=countryMethod(country2);
//country 3 user input
    String country3=JOptionPane.showInputDialog(
      "Please enter 3 different countries\n\n " +"COUNTRY no 3:", "");
    country3c=countryMethod(country3); 
    initialize=2;
 timeMap=timeMap(0);
  }
  //MAIN MENU
  if (timeMap==1) { 
    fill(0);
    stroke(255);
    rect(width/2, height/2, width, height);
    //buttons
    rect(600, 580, 200, 70);
    rect(600, 500, 200, 70);
    fill(255);
    //creating font
    fontMainScreen=loadFont("mainTitle.vlw");
    textFont(fontMainScreen); //assigning desired font
    text("Ryu Hoshiro", 600, 300);
    fontMainScreenButtons=loadFont("mainButtons.vlw");
    textFont(fontMainScreenButtons);
    text("Start", 600, 510);
    fontMainScreenButtons=loadFont("mainButtons.vlw");
    textFont(fontMainScreenButtons);
    text("Quit", 600, 590);
    //buttons input
    if ((mouseX>500&&mouseX<700)&&(mouseY>=465)&&(mouseY<=535)) {
      fill(255);
      rect(600, 500, 200, 70);
      fill(0);
      fontMainScreenButtons=loadFont("mainButtons.vlw");
      textFont(fontMainScreenButtons);
      text("Start", 600, 510);
    } else if ((mouseX>500&&mouseX<700)&&(mouseY>550&&mouseY<615)) {
      fill(255);
      rect(600, 580, 200, 70);
      fill(0);
      text("Quit", 600, 590);}
    if ((mouseX>500&&mouseX<700)&&(mouseY>=465)&&(mouseY<=535)&&(mousePressed)) {
      timeMap=timeMap(1);}
    if ((mouseX>500&&mouseX<700)&&(mouseY>550&&mouseY<615)&&(mousePressed)) {
      exit();}}

  //ryu introduction
  if (timeMap==2) {
    background(255); 
    fill(0, oD);
    rect(width/2, height/2, width, height);
    oD=oD-1;
    fill(0);
    text("Hello "+newName+", I'm Ryu", 350, 150);
    //shading during introduction phase
    if ((oD==1)||(oD<1)) {
      background(255);
      fill(0, oD2);
      rect(width/2, height/2, width, height);
      oD2=oD2+0.5;
      fill(255);
      text("Ryu Hoshiro", 500, 250);
      if ((oD2==255)||(oD2>255)) {
        background(255);
        fill(0, oD3);
        rect(width/2, height/2, width, height);
        oD3=oD3-0.5;
        fill(0);
        textSize(25);
        text("I am a border guard and today's my shift...", 700, 500);
        if ((oD3==1)||(oD3<1)) {
          timeMap=timeMap(2);}}}}
  //intro screen - Ryu going to work
  if (timeMap==3) {  
    //sky
    background( 0, 51, 102);
    //moon
    moon(200, 100);
    //stars   
    int arrayNo=0;
    int starsY=0;
    int starsX=0;
    for (int i=0; i<7; i++) {
      stars(starsX, starsY);
      starsX=starsX+starsArray[arrayNo];
      starsY=starsY+starsArrayY[arrayNo];
      arrayNo=arrayNo+1;}
    //road Ryu walks
    noStroke();
    fill(144, 108, 63);
    rect(width/2, height-50, width, 100);
    fill(0, 102, 51);
    rect(width/2, height-200, width, 200);
    //road to Ryu home
    strokeWeight(10);
    stroke(144, 108, 63);
    line(1060, 550, 1200, 580);
    tree(1000, 500, 0.5, 0, 80, 0);
    tree(1100, 480, 0.5, 0, 80, 0);
    tree(1150, 500, 0.5, 0, 80, 0);
    //ryu's house front
    fill(51, 25, 0);
    strokeWeight(2);
    stroke(0);
    rect(1060, 520, 80, 60);
    //windows
    rect(1040, 505, 20, 20);
    rect(1080, 505, 20, 20);
    fill(255, 255, 0);
    //lights in windows
    rect(1035, 510, 10, 10);
    rect(1035, 500, 10, 10);
    rect(1045, 510, 10, 10);
    rect(1045, 500, 10, 10);
    rect(1075, 510, 10, 10);
    rect(1075, 500, 10, 10);
    rect(1085, 500, 10, 10);
    rect(1085, 510, 10, 10);
    //doors
    strokeWeight(1);
    fill(51, 0, 0);
    rect(1060, 532, 20, 25);
    strokeWeight(10);
    stroke(51, 25, 0);
    //side wall  
    int wallLineX=1100;
    int wallLineY=495;
    int wallLineY2=465;
    int wallLineX2=1130;
    for (int sideWall=1; sideWall<7; sideWall=sideWall+1) {
      line(wallLineX, wallLineY, wallLineX2, wallLineY2);
      wallLineY=wallLineY+10;
      wallLineY2=wallLineY2+10;}
    //roof
    stroke(0);   
    //need local var for "for" to draw in "draw"
    int roofLineX1=1110;
    int roofLineY1=490;
    int roofLineX2=1135;
    int roofLineY2=465;
    for (int roof=1; roof<12; roof=roof+1) {    
      line(roofLineX1, roofLineY1, roofLineX2, roofLineY2);
      roofLineX1=roofLineX1-5;
      roofLineY1=roofLineY1-5;
      roofLineX2=roofLineX2-5;
      roofLineY2=roofLineY2-5;}
    fill(0);
    strokeWeight(1);
    line(1100, 550, 1100, 450);
    triangle(1010, 495, 1110, 495, 1060, 434);
    //Ryu's familly
    noStroke();
    fill(0);
    ellipse(1120, 535, 15, 15);
    arc(1120, 560, 15, 40, -PI, 0);
    ellipse(1140, 530, 15, 15);
    arc(1140, 560, 15, 50, -PI, 0);
    strokeWeight(2);
    stroke(255);
    line(1116, 532, 1117, 532);
    line(1121, 532, 1122, 532);
    line(1136, 528, 1137, 528);
    line(1141, 528, 1142, 528);
    noStroke();
    //blinking of creatures standing by Ryu's house
    if ((ryuX<950)&&(ryuX>850)||(ryuX<680)&&(ryuX>630)||(ryuX<380)&&(ryuX>330)||(ryuX<320)&&(ryuX>270)) {
      ellipse(1120, 535, 15, 15);}
    if ((ryuX<1000)&&(ryuX>950)||(ryuX<650)&&(ryuX>600)||(ryuX<400)&&(ryuX>350)||(ryuX<330)&&(ryuX>290)) {
      ellipse(1140, 530, 15, 15);}
    //trees in the back of Ryu
    tree(600, 500, 0.25, 0, 100, 0);
    tree(620, 510, 0.25, 0, 60, 0);
    tree(650, 520, 0.35, 0, 70, 0);
    tree(670, 550, 0.45, 0, 120, 0);
    tree(450, 610, 1.6, 0, 110, 0);
    tree(590, 560, 1.1, 0, 100, 0);
    tree(520, 650, 1.4, 0, 100, 0);
    tree(360, 630, 2, 0, 120, 0);
    tree(300, 640, 2, 0, 60, 0);
    tree(900, 500, 0.25, 0, 100, 0);
    tree(850, 510, 0.5, 0, 100, 0);
    tree(870, 520, 0.5, 0, 100, 0);
    tree(800, 560, 1.1, 0, 100, 0);
    tree(720, 630, 2, 0, 120, 0);
    //ryu 1st map movement
    Ryu(ryuX, 800);
    ryuX=ryuX-ryuSpeed;
    if (ryuX==0) {
      timeMap=timeMap(3);
      ryuX=1250;}
    //trees in front of Ryu
    tree(200, 780, 3, 0, 80, 0);
    tree(0, 800, 6, 0, 100, 0);
    //rain method 
    fill(255);
    for (float iRain=0; iRain<50; iRain=iRain+1) {  
      float rainX=random(5, width);  
      float rainY=random(5, height);
      rainDrop(rainX, rainY);}}
  //ryu arrives at work place
  if (timeMap==4) {
    //code repeats. 
    fill(0);
    rect(width/2, height/2, width, height);
    //sky
    background( 0, 51, 102);
    //moon
    moon(200, 100);
    //stars
    int arrayNo=0;
    int starsY=0;
    int starsX=0;
    for (int i=0; i<7; i++) {
      stars(starsX, starsY);
      starsX=starsX+starsArray[arrayNo];
      starsY=starsY+starsArrayY[arrayNo];
      arrayNo=arrayNo+1;}
    //road that Ryu walks
    noStroke();
    fill(0, 102, 51);
    rect(width/2, height-200, width, 255);
    fill(144, 108, 63);
    rect(width/2, height-40, width, 100);
    //trees - different POS than map3.
    tree(0, 500, 2, 0, 100, 0);
    tree(150, 500, 1.5, 0, 80, 0);
    tree(410, 500, 2, 0, 160, 0);
    tree(480, 550, 2.5, 0, 120, 0);
    tree(1200, 550, 2.5, 0, 120, 0);
    tree(1100, 550, 2, 0, 150, 0);
    tree(900, 500, 2, 0, 160, 0);
    tree(700, 500, 3, 0, 160, 0);
    //road to X country
    strokeWeight(150);
    stroke(144, 108, 63);
    line(380, 720, 200, 530);
    //gate - mouse movement operational
    strokeWeight(3);
    stroke(0);
    int gateYbar=250;
    while (gateYbar<mouseX) {
      line(gateYbar, 450, gateYbar, 720);
      gateYbar=gateYbar+15;}
    int gateXbar=250;
    strokeWeight(6);
    while (gateXbar<mouseX) {
      line(250, 500, gateXbar, 500);
      line(250, 660, gateXbar, 660);
      gateXbar=gateXbar+2;}
    strokeWeight(1);
    stroke(255);
    fill(120);
    //wall left
    for (int wallRectX=0; wallRectX<250; wallRectX=wallRectX+20) {
      for (int wallRectY=460; wallRectY<720; wallRectY=wallRectY+10) {
        rect(wallRectX, wallRectY, 20, 20);}}
    //wall right
    for (int wallRectX=475; wallRectX<1700; wallRectX=wallRectX+20) {
      for (int wallRectY=460; wallRectY<720; wallRectY=wallRectY+10) {
        rect(wallRectX, wallRectY, 20, 20);}}
        //gate ellipse
    strokeWeight(3);
    stroke(0);
    ellipse(250, 500, 20, 20);
    ellipse(250, 660, 20, 20);
    //ACCEPTED button
    fill(0, 255, 0);
    rect(150, 550, 100, 100);
    fill(0);
    fontButtonMap3=loadFont("fontButtonMap3.vlw");
    textFont(fontButtonMap3);
    text("Open", 150, 550);
    //ryu booth
    fill(170);
    rect(750, 600, 260, 360);
    //side wall of Ryu booth
    strokeWeight(2);
    stroke(170);
    int xLine=880;
    int yLine=780;
    int x1Line=960;
    int y1Line=720;
    for (int boothSide=0; boothSide<180; boothSide++) {
      line(xLine, yLine, x1Line, y1Line);
      yLine=yLine-2;
      y1Line=y1Line-2;}
    //variables for drawing roof 3d
    int xLineRoof=900;
    int yLineRoof=430;
    int x1LineRoof=990;
    int y1LineRoof=360;
    //roof 3d booth
    stroke(0);
    for (int boothRoof=0; boothRoof<162; boothRoof++) {
      line(xLineRoof, yLineRoof, x1LineRoof, y1LineRoof);
      xLineRoof=xLineRoof-1;
      yLineRoof=yLineRoof-1;
      x1LineRoof=x1LineRoof-1;
      y1LineRoof=y1LineRoof-1;}
    fill(0);
    triangle(600, 430, 900, 430, 738, 270);
    //doors booth
    stroke(80);
    int xBoothD=905;
    int yBoothD=765;
    int x1BoothD=950;
    int y1BoothD=730;
    for (int boothDoor=0; boothDoor<250; boothDoor++) {
      line(xBoothD, yBoothD, x1BoothD, y1BoothD);
      yBoothD--;
      y1BoothD--;}
    strokeWeight(10);
    stroke(20);
    line(920, 650, 925, 646);
    //booth window
    stroke(130);
    fill(0);
    rect(750, 550, 180, 180);
    strokeWeight(1);
    stroke(0);
    Ryu(ryuX, 750);
    ryuX=ryuX-ryuSpeed;
    if (ryuX==1050){
      timeMap=timeMap(8);}
    fill(255);
    for (float iRain=0; iRain<50; iRain=iRain+1) {  
      float rainX=random(5, width);  
      float rainY=random(5, height);
      rainDrop(rainX, rainY);}}
  if (timeMap==11) {
   //message with Code for the booth
    JOptionPane.showMessageDialog(null, "CODE IS 472", "Code to the booth", 
      JOptionPane.PLAIN_MESSAGE);
    timeMap=timeMap(4);
  }
  //code request
  if (timeMap==5) {      
    background(0);
    strokeWeight(4);
    stroke(120);
    fill(170);
    rect(width/2, height/2, 400, 200);
    fill(255);
    text("ENTER CODE TO ENTER", width/2, 150);
    line(480, 420, 520, 420);
    line(540, 420, 580, 420);
    line(600, 420, 640, 420);  
    if (keyPressed) {
      text(key, hideKeyX1, hideKeyY1);
      if (key=='4') {
        set1Number=4;
        hideKeyX1=-200;
        hideKeyY1=-200;}}
    if (set1Number==4) {
      //user input code - I have done it before lectures re user input JOption otherwise would have simply use JOption
      text("4", 500, 400);}      
    if ((keyPressed)&&(set1Number==4)) {
      text(key, hideKeyX2, hideKeyY2);
      if (key=='7') {
        set2Number=7;
        hideKeyX2=-200;
        hideKeyY2=-200;}}
    if (set2Number==7) {
      text("7", 560, 400);}           
    if ((keyPressed)&&(set2Number==7)) {
      text(key, hideKeyX3, hideKeyY3);
      if (key=='2') {
        set3Number=2;
        hideKeyX3=-200;
        hideKeyY3=-200;}}
    if (set3Number==2) {
      text("2", 620, 400);}
    if ((set1Number==4)&&(set2Number==7)&&(set3Number==2)) {
      timeMap=timeMap(5);}}
      //creture approach booth phase
  if (timeMap==6){
    //lot of code repeats from phase 4. New code marked with --------------------------------------------------------------------------- below
    fill(0);
    rect(width/2, height/2, width, height);
    //sky
    background( 0, 51, 102);
    //moon
    moon(200, 100);
    //stars
    int arrayNo=0;
    int starsY=0;
    int starsX=0;
    for (int i=0; i<7; i++) {
      stars(starsX, starsY);
      starsX=starsX+starsArray[arrayNo];
      starsY=starsY+starsArrayY[arrayNo];
      arrayNo=arrayNo+1;}
    //road Ryu walks
    noStroke();
    fill(0, 102, 51);
    rect(width/2, height-200, width, 255);
    fill(144, 108, 63);
    rect(width/2, height-40, width, 100);
    tree(0, 500, 2, 0, 100, 0);
    tree(150, 500, 1.5, 0, 80, 0);
    tree(410, 500, 2, 0, 160, 0);
    tree(480, 550, 2.5, 0, 120, 0);
    tree(1200, 550, 2.5, 0, 120, 0);
    tree(1100, 550, 2, 0, 150, 0);
    tree(900, 500, 2, 0, 160, 0);
    tree(700, 500, 3, 0, 160, 0);
    //road to X country
    strokeWeight(150);
    stroke(144, 108, 63);
    line(380, 720, 200, 530);
    //gate
    strokeWeight(3);
    stroke(0);
    int gateYbar=250;
    while (gateYbar<mouseX) {
      line(gateYbar, 450, gateYbar, 720);
      gateYbar=gateYbar+15;}
    int gateXbar=250;
    strokeWeight(6);
    while (gateXbar<mouseX) {
      line(250, 500, gateXbar, 500);
      line(250, 660, gateXbar, 660);
      gateXbar=gateXbar+2;}
    strokeWeight(1);
    stroke(255);
    fill(120);
    //wall left
    for (int wallRectX=0; wallRectX<250; wallRectX=wallRectX+20) {
      for (int wallRectY=460; wallRectY<720; wallRectY=wallRectY+10) {
        rect(wallRectX, wallRectY, 20, 20);}}
    //wall right
    for (int wallRectX=475; wallRectX<1700; wallRectX=wallRectX+20) {
      for (int wallRectY=460; wallRectY<720; wallRectY=wallRectY+10) {
        rect(wallRectX, wallRectY, 20, 20);}}
    strokeWeight(3);
    stroke(0);
    ellipse(250, 500, 20, 20);
    ellipse(250, 660, 20, 20);
    //ACCEPTED
    fill(0, 255, 0);
    rect(150, 550, 100, 100);
    fill(0);
    fontButtonMap3=loadFont("fontButtonMap3.vlw");
    textFont(fontButtonMap3);
    text("Open", 150, 550);    
    //ryu booth
    noStroke();
    fill(170);
    rect(750, 600, 260, 360);
    //side wall
    strokeWeight(2);
    stroke(170);
    int xLine=880;
    int yLine=780;
    int x1Line=960;
    int y1Line=720;
    for (int boothSide=0; boothSide<180; boothSide++) {
      line(xLine, yLine, x1Line, y1Line);
      yLine=yLine-2;
      y1Line=y1Line-2;}
    int xLineRoof=900;
    int yLineRoof=430;
    int x1LineRoof=990;
    int y1LineRoof=360;
    //roof booth
    stroke(0);
    for (int boothRoof=0; boothRoof<162; boothRoof++) {
      line(xLineRoof, yLineRoof, x1LineRoof, y1LineRoof);
      xLineRoof=xLineRoof-1;
      yLineRoof=yLineRoof-1;
      x1LineRoof=x1LineRoof-1;
      y1LineRoof=y1LineRoof-1;}
    fill(0);
    triangle(600, 430, 900, 430, 738, 270);
    //doors booth
    stroke(80);
    int xBoothD=905;
    int yBoothD=765;
    int x1BoothD=950;
    int y1BoothD=730;
    for (int boothDoor=0; boothDoor<250; boothDoor++) {
      line(xBoothD, yBoothD, x1BoothD, y1BoothD);
      yBoothD--;
      y1BoothD--;}
      
      
      //--------------------------------------------------------------------------------PART OF NEW CODE------------------------------------------------------------------------------------
    //booth window with Ryu
    stroke(130);
    fill(0);
    rect(750, 550, 180, 180);
    noStroke();
    //ryus eyes in booth
    fill(255);
    triangle(700, 515, 735, 515, 735, 540);
    triangle(755, 515, 790, 515, 755, 540); 

    //little creatures
    stroke(160);
    strokeWeight(2);  
    int arrayNoRyu=0;
    int ryuXsmall=1050;
    int ryuYsmall=635;
    //draw of multiple creatures standing in queue
    for (int i=0; i<5; i++) {
      Ryu(ryuXsmall, ryuYsmall, 50);
      ryuXsmall=ryuXsmall+ryuArrayX[arrayNoRyu];
      ryuYsmall=ryuYsmall+ryuArrayY[arrayNoRyu];
      arrayNoRyu=arrayNoRyu+1;
      println(ryuXsmall);} 
    Ryu(1100, 650, 50);      
    Ryu(smallRyuX, 650, 50);
    smallRyuX=smallRyuX-smallRyuXSpeed;
    //blinking Ryu
    if ((smallRyuX<=1200)&&(smallRyuX>=1150)||(smallRyuX<=1000)&&(smallRyuX>=950)) {
      fill(0);
      rect(750, 550, 180, 180);}
      if ((smallRyuX<900)&&(smallRyuX>750)) {
      ellipse(900, 500, 200, 50);
      ellipse(850, 530, 20, 20);
      ellipse(840, 545, 10, 10);
      ellipse(830, 550, 5, 5);    
      fill(0);
      //Ryu papers req
      text("Papers little man", 900, 500);}
//small creature stops at booth
    if (smallRyuX<=745) {             
      smallRyuXSpeed=0;
      smallRyuX=745;     
      timeMap=timeMap(6);}
      //rain
    for (float iRain=0; iRain<50; iRain=iRain+1) {  
      float rainX=random(5, width);  
      float rainY=random(5, height);
      rainDrop(rainX, rainY);}}
  //papers please phase
  if (timeMap==7) {
    //graphics
    stroke(0);
    strokeWeight(3);
    fill(166);
    rect(600, 400, 600, 600);
    strokeWeight(2);
    fill(131, 139, 131);
    rect(450, 400, 260, 560);
    rect(750, 400, 260, 560);
    fill(255);
    textSize(15);
    //text on papers
    text("ORDERS", 450, 150);
    text("Do not let people in from:", 450, 200);
    text("Country of Origin", 750, 200);
    text("PASSPORT", 750, 150);
    //CONDITIONS   ---UPDATE -  I wanted to create multiple conditions however, project scope got bigger than I thought and had to resign from adding more conditions.
    text("1.", 340, 300);
    line(340, 310, 450, 310);
    //moving box to tick
    stroke(0, 0, 255);
    strokeWeight(2);
    fill(255, 0, 0, 0);
    rect(markingRectX, markingRectY, 25, 25);
    //ticks
    fill(255, 255);
    text("NOT OK", 550, 280);
    text("OK", 500, 280);  
    rect(500, 300, 20, 20);    
    rect(550, 300, 20, 20);
    if (randomCountry==0) {  
      text(country[0], 400, 300);} 
      else if (randomCountry==1) {
      text(country[1], 400, 300);} 
      else if (randomCountry==2) {
      text(country[2], 400, 300);}

    if (randomPassport==0) {
      text(country[0], 750, 300);} 
      else if (randomPassport==1) {
      text(country[1], 750, 300);} 
      else if (randomPassport==2) {
      text(country[2], 750, 300);}} 
//final phase where creature is either accepted or refuse entry to X Country through the gate.
  if (timeMap==10) {
    //code repeats after passport phase. Please go to ------------------------------------------------------------------------------------------------ to see added code.
    fill(0);
    rect(width/2, height/2, width, height);
    //sky
    background( 0, 51, 102);
    //moon
    moon(200, 100);
    //stars   
    int arrayNo=0;
    int starsY=0;
    int starsX=0;
    for (int i=0; i<7; i++) {
      stars(starsX, starsY);
      starsX=starsX+starsArray[arrayNo];
      starsY=starsY+starsArrayY[arrayNo];
      arrayNo=arrayNo+1;}
    //road Ryu walks
    noStroke();
    fill(0, 102, 51);
    rect(width/2, height-200, width, 255);
    fill(144, 108, 63);
    rect(width/2, height-40, width, 100);
    tree(0, 500, 2, 0, 100, 0);
    tree(150, 500, 1.5, 0, 80, 0);
    tree(410, 500, 2, 0, 160, 0);
    tree(480, 550, 2.5, 0, 120, 0);
    tree(1200, 550, 2.5, 0, 120, 0);
    tree(1100, 550, 2, 0, 150, 0);
    tree(900, 500, 2, 0, 160, 0);
    tree(700, 500, 3, 0, 160, 0);
    //road to X country
    strokeWeight(150);
    stroke(144, 108, 63);
    line(380, 720, 200, 530);
    //gate
    strokeWeight(3);
    stroke(0);
    int gateYbar=250;
    while (gateYbar<mouseX) {
      line(gateYbar, 450, gateYbar, 720);
      gateYbar=gateYbar+15;}
    int gateXbar=250;
    strokeWeight(6);
    while (gateXbar<mouseX) {
      line(250, 500, gateXbar, 500);
      line(250, 660, gateXbar, 660);
      gateXbar=gateXbar+2;}
    strokeWeight(1);
    stroke(255);
    fill(120);
    //wall right
    for (int wallRectX=475; wallRectX<1700; wallRectX=wallRectX+20) {
      for (int wallRectY=460; wallRectY<720; wallRectY=wallRectY+10) {
        rect(wallRectX, wallRectY, 20, 20);}}
    strokeWeight(3);
    stroke(0);
    ellipse(250, 500, 20, 20);
    ellipse(250, 660, 20, 20);
    //ryu booth
    noStroke();
    fill(170);
    rect(750, 600, 260, 360);
    //side wall
    strokeWeight(2);
    stroke(170);
    int xLine=880;
    int yLine=780;
    int x1Line=960;
    int y1Line=720;
    for (int boothSide=0; boothSide<180; boothSide++) {
      line(xLine, yLine, x1Line, y1Line);
      yLine=yLine-2;
      y1Line=y1Line-2;}
    int xLineRoof=900;
    int yLineRoof=430;
    int x1LineRoof=990;
    int y1LineRoof=360;
    //roof booth
    stroke(0);
    for (int boothRoof=0; boothRoof<162; boothRoof++) {
      line(xLineRoof, yLineRoof, x1LineRoof, y1LineRoof);
      xLineRoof=xLineRoof-1;
      yLineRoof=yLineRoof-1;
      x1LineRoof=x1LineRoof-1;
      y1LineRoof=y1LineRoof-1;}
    fill(0);
    triangle(600, 430, 900, 430, 738, 270);
    //doors booth
    stroke(80);
    int xBoothD=905;
    int yBoothD=765;
    int x1BoothD=950;
    int y1BoothD=730;
    for (int boothDoor=0; boothDoor<250; boothDoor++) {
      line(xBoothD, yBoothD, x1BoothD, y1BoothD);
      yBoothD--;
      y1BoothD--;}
    //booth window with Ryu
    stroke(130);
    fill(0);
    rect(750, 550, 180, 180);
    noStroke();
    fill(255);
    triangle(700, 515, 735, 515, 735, 540);
    triangle(755, 515, 790, 515, 755, 540); 
    //little Ryu'2
    stroke(160);
    strokeWeight(2);        
    Ryu(1050, 635, 50);
    Ryu(1100, 635, 50);
    Ryu(1150, 630, 50);
    Ryu(1200, 650, 50);
    Ryu(1000, 650, 50);
    Ryu(1100, 650, 50); 
    Ryu(smallRyuHappy, smallRyuHappyY, 50);
//blinking Ryu
    if ((smallRyuHappy<=600)&&(smallRyuHappy>=550)||(smallRyuHappy<=450)&&(smallRyuHappy>=402)||(smallRyuHappy>900)&&(smallRyuHappy<950)) {
      fill(0);
      rect(750, 550, 180, 180);}
    fill(255);
    //--------------------------------------------------------------------------------------------------------------------------------------------PART OF NEW CODE
    //conditions to what will creature respond and where will it go based on players input. Wanted to add scoring and lives but as above, project scope got bigger than I thought and did not want to add any more "if's" to the code.
    if ((randomCountry!=randomPassport)&&(smallRyuHappy>400)&&(checkIfok==1)) { 
      ellipse(smallRyuHappy+10, 580, 20, 10);
      ellipse(smallRyuHappy, 550, 100, 50);
      ellipse(smallRyuHappy+5, 600, 10, 5);
      ellipse(smallRyuHappy+10, 590, 15, 5);
      fill(0);
      textSize(10);
      text("Thank you Ryu!!!", smallRyuHappy, 550);
      smallRyuHappy=smallRyuHappy-smallRyuXSpeedHappy;}     
    if ((randomCountry==randomPassport)&&(smallRyuHappy>400)&&(checkIfok==1)) {
      fill(255);
      ellipse(smallRyuHappy+10, 580, 20, 10);
      ellipse(smallRyuHappy, 550, 100, 50);
      ellipse(smallRyuHappy+5, 600, 10, 5);
      ellipse(smallRyuHappy+10, 590, 15, 5);
      fill(0);
      textSize(10);
      text("LOL - he let me go!!!", smallRyuHappy, 550);
      smallRyuHappy=smallRyuHappy-smallRyuXSpeedHappy;}
    if ((randomCountry==randomPassport)&&(smallRyuHappy>400)&&(checkIfok==0)) {
      fill(255);
      ellipse(smallRyuHappy+10, 580, 20, 10);
      ellipse(smallRyuHappy, 550, 100, 50);
      ellipse(smallRyuHappy+5, 600, 10, 5);
      ellipse(smallRyuHappy+10, 590, 15, 5);
      fill(0);
      textSize(10);
      text("Ok..I will try tomorrow!", smallRyuHappy, 550);
      smallRyuHappy=smallRyuHappy+smallRyuXSpeedHappy;}
   if ((randomCountry!=randomPassport)&&(smallRyuHappy>400)&&(checkIfok==0)) {
      fill(255);
      ellipse(smallRyuHappy+10, 580, 20, 10);
      ellipse(smallRyuHappy, 550, 100, 50);
      ellipse(smallRyuHappy+5, 600, 10, 5);
      ellipse(smallRyuHappy+10, 590, 15, 5);
      fill(0);
      textSize(10);
      text("What the hell Ryu?!", smallRyuHappy, 550);
      smallRyuHappy=smallRyuHappy+smallRyuXSpeedHappy;}
   if (smallRyuHappy==400) {
      ellipse(smallRyuHappy+10, smallRyuHappyY-70, 20, 10);
      ellipse(smallRyuHappy, smallRyuHappyY-100, 200, 50);
      ellipse(smallRyuHappy+5, smallRyuHappyY-50, 10, 5);
      ellipse(smallRyuHappy+10, smallRyuHappyY-60, 15, 5);
      textSize(10);
      fill(0);
      text("Now u have to open the gate for me", smallRyuHappy, 550);}  
    fill(255);  
    if ((mouseX<200)&&(mouseX>100)&&(mouseY>500)&&(mouseY<600)&&(smallRyuHappyY>=500)) {
      smallRyuHappyY=smallRyuHappyY-smallRyuXSpeedHappyY;
      smallRyuHappy=399;}        
    if (smallRyuHappyY<=500) {
      smallRyuHappy=smallRyuHappy-5;}
    strokeWeight(1);
    stroke(255);
    fill(120);
    for (int wallRectX=0; wallRectX<250; wallRectX=wallRectX+20) {
      for (int wallRectY=460; wallRectY<720; wallRectY=wallRectY+10) {
        rect(wallRectX, wallRectY, 20, 20); }}
    strokeWeight(3);
    stroke(0);
    ellipse(250, 500, 20, 20);
    ellipse(250, 660, 20, 20);
    //ACCEPTED
    fill(0, 255, 0);
    rect(150, 550, 100, 100);
    fill(0);
    fontButtonMap3=loadFont("fontButtonMap3.vlw");
    textFont(fontButtonMap3);
    text("Open", 150, 550);
    //Gameplay resets to phase where creature approaches booth.
    if ((smallRyuHappy < 0)||(smallRyuHappy>1230)) {   
      smallRyuX=1200;
      smallRyuXSpeed=2;
      randomCountry=int (random(0, 3));
      randomPassport=int(random(0, 3));
      smallRyuHappy=740;
      smallRyuXSpeedHappy=2;
      smallRyuHappyY=650;
      smallRyuXSpeedHappyY=2;
      timeMap=timeMap(5);}
    for (float iRain=0; iRain<50; iRain=iRain+1) {  
      float rainX=random(5, width);  
      float rainY=random(5, height);
      rainDrop(rainX, rainY);}}}



void keyPressed() {
  //marking during phase with papers check. based on correct /incorrect player response different checkIfOk is tripped.
  if (timeMap==7);
  if (keyCode==CODED);
  if ((keyCode == RIGHT)&&(markingRectX<550)) {
    markingRectX=markingRectX+50;
  } else if ((keyCode == LEFT)&&(markingRectX>500)) {
    markingRectX=markingRectX-50;
  }
  if ((keyCode==ENTER)&&(markingRectX==500)&&(markingRectY==300)) {   
    timeMap=timeMap(7);
    checkIfok=1;
  }   
  if ((keyCode==ENTER)&&(markingRectX==550)&&(markingRectY==300)) {
    timeMap=timeMap(7);
    checkIfok=0;
  }
}