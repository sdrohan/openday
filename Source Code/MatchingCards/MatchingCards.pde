//Name: Jack Power
//Course Name: Applied Computing

/*On starting the game the player is prompted to enter the number of
cards they wish to draw, limited to between 2 and 12 pairs. The cards
are then randomly generated in the first row, randomly mixed into the
second row and then hidden with a scaled pattern after waiting a few 
seconds to memorise the cards. The cards can then be selected in pairs,
only being revealed if it is the appropriate match for the first card
selected. Once all cards have been revealed, the game is won.*/

import javax.swing.*;
Card card;
Player player;
int numPairs = 0;
int[] activeCard = new int[2];
int t;

void setup(){
  size(565,500);
  background(57,163,8);
  card = new Card(numPairs);
  player = new Player();
  setNumPairs();
  t = millis();
  card.dealCards(numPairs);
  activeCard[0] = -1;
  activeCard[1] = -1;
  
}

void draw(){
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

void mousePressed(){
  clicked();
  card.setActiveCard(activeCard[0],activeCard[1]);
  card.reveal();
}

void setNumPairs(){
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
       numPairs = int(pairString);
    }
  }
}

int[] clicked(){
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

void gameOver(){
  if(card.getCounter() == 1){
    fill(255,0,0);
    textSize(140);
    textAlign(LEFT,TOP);
    text("YOU",140,100);
    text("WIN!",150,250);
  }
}