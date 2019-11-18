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

public class MatchingCards extends PApplet {

//Name: Jack Power
//Course Name: Applied Computing

/*On starting the game the player is prompted to enter the number of
cards they wish to draw, limited to between 2 and 12 pairs. The cards
are then randomly generated in the first row, randomly mixed into the
second row and then hidden with a scaled pattern after waiting a few 
seconds to memorise the cards. The cards can then be selected in pairs,
only being revealed if it is the appropriate match for the first card
selected. Once all cards have been revealed, the game is won.*/


Card card;
Player player;
int numPairs = 0;
int[] activeCard = new int[2];
int t;

public void setup(){
  
  background(57,163,8);
  card = new Card(numPairs);
  player = new Player();
  setNumPairs();
  t = millis();
  card.dealCards(numPairs);
  activeCard[0] = -1;
  activeCard[1] = -1;
  
}

public void draw(){
  if(millis()-t > 2000 && millis()-t < 2500){
    for(int i=0;i<numPairs;i++){
      card.hide(i, 20);
      card.hide(i, height-(20+card.getCardHeight()));
    }
  }
  player.setPMouseX(mouseX);
  player.setPMouseY(mouseY);
  gameOver();
}

public void mousePressed(){
  clicked();
  card.setActiveCard(activeCard[0],activeCard[1]);
  card.reveal();
}

public void setNumPairs(){
  while(numPairs<2 || numPairs>12){
    String pairString = (String)JOptionPane.showInputDialog("How many pairs would you like?");
    //added by siobhan for open day. 
    if (pairString == null)
    {
       JOptionPane.showMessageDialog(null, "Cancel pressed...exiting game!");
       System.exit(0);
    }
    else
    {
       numPairs = PApplet.parseInt(pairString);
    }
  }
}

public int[] clicked(){
  int cardWidth = card.getCardWidth();
  int cardHeight = card.getCardHeight();
  int gapSize = card.getGapSize();
  float PMouseX = player.getPMouseX();
  float PMouseY = player.getPMouseY();
  int cardX;
  int c = 0;
  if(mousePressed){
    for(int i=1;i<3;i++){
      if(PMouseY > card.getRowY(i) && PMouseY < (card.getRowY(i)+cardHeight)){
        c++;
        for(int j=0;j<numPairs;j++){
          cardX = card.getStartPoint()+((cardWidth+gapSize)*j);
          if(PMouseX > cardX && PMouseX < cardX+cardWidth){
            c++;
            activeCard[1] = j;
            activeCard[0] = i;
          }
        }
      }
    }
    if(c != 2){
      activeCard[0] = -1;
      activeCard[1] = -1;
  }
  }else{
    activeCard[0] = -1;
    activeCard[1] = -1;
  }
  return(activeCard);
}

public void gameOver(){
  if(card.getCounter() == 1){
    fill(255,0,0);
    textSize(140);
    textAlign(LEFT,TOP);
    text("YOU",140,100);
    text("WIN!",150,250);
  }
}
public class Card
{
  private int numPairs;
  private int[] rowOneSuit;
  private int[] rowOneRank;
  private int[] rowTwoSuit;
  private int[] rowTwoRank;
  private int startPoint;
  private int shift;
  private int cardWidth;
  private int cardHeight;
  private int rowY;
  private int gapSize;
  private int pos;
  private String cardRank;
  private int[] activeCard = new int[2];
  private int[][] cardsClicked;
  private int counter;

  Card(int numPairs){
    this.numPairs = numPairs;
  }

  public void dealCards(int numPairs){//fills rows with cards
    this.numPairs = numPairs;
    rowOneSuit = new int[numPairs];//top row suits
    rowOneRank = new int[numPairs];//top row ranks
    rowOneSuit[0] = PApplet.parseInt(random(4));//set first suit to random
    rowOneRank[0] = PApplet.parseInt(random(1,14));//set first rank to random
    int checker = 0;
    int i=1;
    while(i<numPairs){
      checker = 0;
      int suit = PApplet.parseInt(random(4));//pick new random suit
      int rank = PApplet.parseInt(random(1,14));//pick new random rank
        for(int j=i-1;j>-1;j--){
          if(suit == rowOneSuit[j] && rank == rowOneRank[j]){//check if new suit and rank match any previous card
            checker++;
          }
        }
        if(checker == 0){
          rowOneSuit[i] = suit;
          rowOneRank[i] = rank;
          i++;
        }
    }
    rowTwoSuit = new int[numPairs];
    rowTwoRank = new int[numPairs];
    i = PApplet.parseInt(random(numPairs));
    rowTwoSuit[i] = rowOneSuit[0];
    rowTwoRank[i] = rowOneRank[0];
    i=1;
    while(i<numPairs){
      int j = PApplet.parseInt(random(numPairs));
      if(rowTwoRank[j] == 0){
        rowTwoSuit[j] = rowOneSuit[i];
        rowTwoRank[j] = rowOneRank[i];
        i++;
      }
    }
    for(i=0;i<numPairs;i++){
      drawRows(i, 20);
      drawRows(i, height-(20+cardHeight));
    }
    cardsClicked = new int[numPairs*2][2];
  }
  
  public void drawRows(int pos, int rowY){//dimensions and draws cards
    this.pos = pos;
    this.rowY = rowY;
    if(numPairs>8){
      cardWidth = 40;
      gapSize = 5;
      textSize(10);
    }else if(numPairs>4){
      cardWidth = 60;
      gapSize = 10;
      textSize(18);
    }else{
      cardWidth = 90;
      gapSize = 20;
      textSize(30);
    }
    noStroke();
    cardHeight = cardWidth*11/8;
    startPoint = (width-((numPairs*cardWidth)+((numPairs-1)*gapSize)))/2;
    for(int i=0;i<numPairs;i++){
      pos = i;
      shift = pos*(cardWidth+gapSize);
      fill(255);
      rect(startPoint+((cardWidth+gapSize)*i),rowY,cardWidth,cardHeight);
      if(rowY == 20){
        drawSuit(rowOneSuit[i], rowY);
        drawRank(rowOneRank[i], rowY);
      }else{
        drawSuit(rowTwoSuit[i], rowY);
        drawRank(rowTwoRank[i], rowY);
      }
    }
  }
  
  public void drawSuit(int suit, int rowY){
    noStroke();
    this.rowY = rowY;
    if(suit == 0){
      //draw heart
      fill(255,0,0);
      ellipse(startPoint+shift+(cardWidth*2/5),rowY+(cardHeight*2/5),cardHeight*3/10,cardHeight*3/10);//top left circle
      ellipse(startPoint+shift+(cardWidth*3/5),rowY+(cardHeight*2/5),cardHeight*3/10,cardHeight*3/10);//top right circle
      triangle(startPoint+shift+(cardWidth*1/4),rowY+(cardHeight*1/2),startPoint+shift+(cardWidth*1/2),rowY+(cardHeight*3/4),startPoint+shift+(cardWidth*76/100),rowY+(cardHeight*1/2));//bottom triangle
    }else if(suit == 1){
      //draw diamond
      fill(255,0,0);
      quad(startPoint+shift+(cardWidth*1/2),rowY+(cardHeight*1/4),startPoint+shift+(cardWidth*3/4),rowY+(cardHeight*1/2),startPoint+shift+(cardWidth*1/2),rowY+(cardHeight*3/4),startPoint+shift+(cardWidth*1/4),rowY+(cardHeight*1/2));
    }else if(suit == 2){
      //draw spade
      fill(0);
      ellipse(startPoint+shift+(cardWidth*37/100),rowY+(cardHeight*53/100),cardWidth*1/4,cardWidth*1/4);//left circle
      ellipse(startPoint+shift+(cardWidth*63/100),rowY+(cardHeight*53/100),cardWidth*1/4,cardWidth*1/4);//right circle
      triangle(startPoint+shift+(cardWidth*1/4),rowY+(cardHeight*1/2),startPoint+shift+(cardWidth*1/2),rowY+(cardHeight*1/4),startPoint+shift+(cardWidth*3/4),rowY+(cardHeight*1/2));//top triangle
      triangle(startPoint+shift+(cardWidth*2/5),rowY+(cardHeight*3/4),startPoint+shift+(cardWidth*1/2),rowY+cardHeight*2/5,startPoint+shift+(cardWidth*3/5),rowY+(cardHeight*3/4));//bottom triangle
    }else{
      //draw club
      fill(0);
      ellipse(startPoint+shift+(cardWidth*1/2),rowY+(cardHeight*7/20),cardWidth*3/10,cardWidth*3/10);//top circle
      ellipse(startPoint+shift+(cardWidth*36/100),rowY+(cardHeight*1/2),cardWidth*3/10,cardWidth*3/10);//left circle
      ellipse(startPoint+shift+(cardWidth*64/100),rowY+(cardHeight*1/2),cardWidth*3/10,cardWidth*3/10);//right circle
      triangle(startPoint+shift+(cardWidth*2/5),rowY+(cardHeight*3/4),startPoint+shift+(cardWidth*1/2),rowY+(cardHeight*1/2),startPoint+shift+(cardWidth*3/5),rowY+(cardHeight*3/4));//bottom triangle
    }
  }
  
  public void drawRank(int rank, int rowY){
    this.rowY = rowY;
    switch(rank){
      case 13:
        cardRank = "K";
      break;
      case 12:
        cardRank = "Q";
      break;
      case 11:
        cardRank = " J";
      break;
      case 1:
        cardRank = "A";
      break;
      default:
        cardRank = Integer.toString(rank);
    }
    textAlign(LEFT, TOP);
    text(cardRank,startPoint+shift,rowY);
    textAlign(RIGHT, BOTTOM);
    text(cardRank,startPoint+shift+(cardWidth),rowY+(cardHeight));
  }
  
  public void hide(int pos, int rowY){
    this.pos = pos;
    this.rowY = rowY;
    strokeWeight(1);
    fill(165,35,3);
    rect(startPoint+((cardWidth+gapSize)*pos),rowY,cardWidth,cardHeight);
    stroke(198,161,13);
    for(int i=0;i<=(cardWidth/10);i++){
      line((startPoint+(cardWidth+gapSize)*pos),rowY+(cardHeight/(cardWidth/10)*i),(startPoint+((cardWidth+gapSize)*pos)+cardWidth-(cardWidth/(cardWidth/10)*i)),rowY+cardHeight);
      line((startPoint+((cardWidth+gapSize)*pos)+(cardWidth/(cardWidth/10)*i)),rowY,(startPoint+((cardWidth+gapSize)*pos)+cardWidth),rowY+cardHeight-(cardHeight/(cardWidth/10)*i));
      line((startPoint+(cardWidth+gapSize)*pos),rowY+cardHeight-(cardHeight/(cardWidth/10)*i),(startPoint+((cardWidth+gapSize)*pos)+cardWidth-(cardWidth/(cardWidth/10)*i)),rowY);
      line((startPoint+((cardWidth+gapSize)*pos)+(cardWidth/(cardWidth/10)*i)),rowY+cardHeight,(startPoint+((cardWidth+gapSize)*pos)+cardWidth),rowY+(cardHeight/(cardWidth/10)*i));
    }
  }
  
  public void reveal(){
    if(activeCard[0] == 1){
      rowY = 20;
    }else{
      rowY = height-(20+cardHeight);
    }
    if(activeCard[0] != -1 && activeCard[1] != -1){// if a card is being clicked
      println("card clicked");
      int i = 0;
      int k = 0;
      while(i<numPairs*2){//start check if card being clicked has already been clicked
        if(cardsClicked[i][0] == activeCard[0] && cardsClicked[i][1] == activeCard[1]){
          println("already revealed");
          k = 1;
        }
        break;
      }
      if(k == 0){
        println("not revealed");
        i++;
        counter = 0;
        for(int j=0;j<numPairs*2;j++){//start check if card is first of pair
          if(cardsClicked[j][0] == 0){
            counter++;
          }         
        }
        if(counter%2 == 0){ //if first of pair allow to be revealed
          println("first of pair");
          pos = activeCard[1];
          shift = pos*(cardWidth+gapSize);
          fill(255);
          noStroke();
          rect(startPoint+((cardWidth+gapSize)*activeCard[1]),rowY,cardWidth,cardHeight);
          if(rowY == 20){
            drawSuit(rowOneSuit[activeCard[1]], rowY);
            drawRank(rowOneRank[activeCard[1]], rowY);
          }else{
            drawSuit(rowTwoSuit[activeCard[1]], rowY);
            drawRank(rowTwoRank[activeCard[1]], rowY);
          }
          cardsClicked[(numPairs*2-counter)][0] = activeCard[0]; //add card to cardsClicked
          cardsClicked[(numPairs*2-counter)][1] = activeCard[1];
        }else{
        int[] cardOne = new int[2];
        int[] cardTwo = new int[2];
        if(cardsClicked[(numPairs*2-counter-1)][0] != activeCard[0]){
          if(cardsClicked[(numPairs*2-counter-1)][0] == 1){// check if pair is correct 
            cardOne[0] = rowOneSuit[cardsClicked[(numPairs*2-counter-1)][1]];
            cardOne[1] = rowOneRank[cardsClicked[(numPairs*2-counter-1)][1]];
            cardTwo[0] = rowTwoSuit[activeCard[1]];
            cardTwo[1] = rowTwoRank[activeCard[1]];
          }else{
            cardOne[0] = rowTwoSuit[cardsClicked[(numPairs*2-counter-1)][1]];
            cardOne[1] = rowTwoRank[cardsClicked[(numPairs*2-counter-1)][1]];
            cardTwo[0] = rowOneSuit[activeCard[1]];
            cardTwo[1] = rowOneRank[activeCard[1]];
          }
          if(cardOne[0] == cardTwo[0] && cardOne[1] == cardTwo[1]){
            println("pair is correct");
            pos = activeCard[1];
            shift = pos*(cardWidth+gapSize);
            fill(255);
            noStroke();
            rect(startPoint+((cardWidth+gapSize)*activeCard[1]),rowY,cardWidth,cardHeight);
            if(rowY == 20){
              drawSuit(rowOneSuit[activeCard[1]], rowY);
              drawRank(rowOneRank[activeCard[1]], rowY);
              noFill();
              stroke(0,255,0);
              int strokeWeight = (gapSize/4);
              strokeWeight(strokeWeight);
              rect(startPoint+((cardWidth+gapSize)*cardsClicked[(numPairs*2-counter-1)][1])-(strokeWeight/2),height-(20+cardHeight)-(strokeWeight/2),cardWidth+strokeWeight,cardHeight+strokeWeight);
              rect(startPoint+((cardWidth+gapSize)*activeCard[1])-(strokeWeight/2),rowY-(strokeWeight/2),cardWidth+strokeWeight,cardHeight+strokeWeight);
            }else{
              drawSuit(rowTwoSuit[activeCard[1]], rowY);
              drawRank(rowTwoRank[activeCard[1]], rowY);
              noFill();
              stroke(0,255,0);
              int strokeWeight = (gapSize/4);
              strokeWeight(strokeWeight);
              rect(startPoint+((cardWidth+gapSize)*cardsClicked[(numPairs*2-counter-1)][1])-(strokeWeight/2),20-(strokeWeight/2),cardWidth+strokeWeight,cardHeight+strokeWeight);
              rect(startPoint+((cardWidth+gapSize)*activeCard[1])-(strokeWeight/2),rowY-(strokeWeight/2),cardWidth+strokeWeight,cardHeight+strokeWeight);
            }
            cardsClicked[(numPairs*2-counter)][0] = activeCard[0]; //add card to cardsClicked
            cardsClicked[(numPairs*2-counter)][1] = activeCard[1];
          }
          else{
            println("pair is not correct");
          }
        }
        }
      }
    }
  }
  
  public int getCardHeight(){
    return cardHeight;
  }
  
  public int getCardWidth(){
    return cardWidth;
  }
  
  public int getGapSize(){
    return gapSize;
  }
  
  public int getStartPoint(){
    return startPoint;
  }
  
  public int getRowY(int rowNum){
    if(rowNum > 1){
      return height-(20+cardHeight);
    }else{
      return 20;
    }
  }
  
  public int getCounter(){
    return this.counter;
  }
  
  public int[] setActiveCard(int row, int pos){
    this.activeCard[0] = row;
    this.activeCard[1] = pos;
    return this.activeCard;
  }
}
public class Player
{
  private float PMouseX;
  private float PMouseY;
 
  public void setPMouseX(float PMouseX){
    if(PMouseX>0 && PMouseX<565){
      this.PMouseX = PMouseX;
    }
  }
  
  public void setPMouseY(float PMouseY){
    if(PMouseY>0 && PMouseY<565){
      this.PMouseY = PMouseY;
    }
  }
  
  public float getPMouseX(){
    return PMouseX;
  }
  
  public float getPMouseY(){
    return PMouseY;
  }
}
  public void settings() {  size(565,500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "MatchingCards" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
