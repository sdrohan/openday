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
    rowOneSuit[0] = int(random(4));//set first suit to random
    rowOneRank[0] = int(random(1,14));//set first rank to random
    int checker = 0;
    int i=1;
    while(i<numPairs){
      checker = 0;
      int suit = int(random(4));//pick new random suit
      int rank = int(random(1,14));//pick new random rank
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
    i = int(random(numPairs));
    rowTwoSuit[i] = rowOneSuit[0];
    rowTwoRank[i] = rowOneRank[0];
    i=1;
    while(i<numPairs){
      int j = int(random(numPairs));
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