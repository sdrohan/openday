public class Ship {
  private float xCoord;
  private float yCoord;
  private float hitX;
  private float hitY;
  private float hitRad;
  private int health;
  private float score;
  private String name = "____";

  //New Movement Fields
  //Check if ship's x/y shoud be updated 
  //in their respective directions
  private boolean yUp = false;
  private boolean yDown = false;
  private boolean xLeft = false;
  private boolean xRight = false;

  public Ship() {
  }

  public Ship(float xPos, float yPos, int hp) {
    if ((xPos > 25) && (xPos < width-25)) {
      this.xCoord = xPos;
    } else {
      this.xCoord = width/2;
    }
    if ((yPos > 25) && (yPos < height-25)) {
      this.yCoord = yPos;
    } else {
      this.yCoord = width/3;
    }
    if (hp > 0) {
      this.health = hp;
    } else {
      this.health = 10;
    }
    this.score = 0;
  }

  public void drawHealthBar() {
    //Draws player's health bar
    //Border
    fill(50);
    rect(0, height-30, 210, 40);
    //Red bar - HP missing
    fill(128, 0, 0);
    rect(5, height-25, 200, 20);
    //Green bar - HP left
    fill(0, 255, 0);
    //Prevents bar from bugging at 0 hp
    if (this.health > 0) {
      rect(5, height-25, this.health*20, 20);
    }
  }

  public void drawShip() {
    //Draws the player's ship

    for (float i = 0; i < 50; i++) {
      //Smoke
      fill(50, 50, 50, 5);
      ellipse(this.xCoord+random(-10, 10), this.yCoord+55+i, random(20, 30), random(20, 30));
      //Flames
      fill(255, 0, 0, 128);
      ellipse(this.xCoord+random(-5, 5), this.yCoord+55+i, random(5, 10)-i/10, random(5, 30));
      fill(200, 200, 0.128);
      ellipse(this.xCoord+random(-3, 3), this.yCoord+55+i/1.5, random(3, 8)-i/10, random(2, 10));
    }
    noStroke();

    //Main Body
    fill(255);
    triangle(this.xCoord, this.yCoord, this.xCoord-10, this.yCoord+40, this.xCoord+10, this.yCoord+40);
    //Window
    fill(0);
    triangle(this.xCoord, this.yCoord+5, this.xCoord-5, this.yCoord+25, this.xCoord+5, this.yCoord+25);
    fill(255);
    //Left Fin
    triangle(this.xCoord, this.yCoord+20, this.xCoord, this.yCoord+35, this.xCoord+25, this.yCoord+50);
    //Right Fin
    triangle(this.xCoord, this.yCoord+20, this.xCoord, this.yCoord+35, this.xCoord-25, this.yCoord+50);
    //Booster
    fill(128);
    rect(this.xCoord-7, this.yCoord+40, 14, 7);
    
    //Shield (Visible hitbox until player's HP is reduced to 1)
    if(this.health > 1) {
    fill(50, 50, 255, map(sin(millis()/75), -1, 1, 100,150));
    ellipse(this.xCoord, this.yCoord+30, this.hitRad*2, this.hitRad*2);
    }
    this.hitX = this.xCoord;
    this.hitY = this.yCoord+30;
    this.hitRad = 25;

    //Name
    fill(255);
    textSize(20);
    text(this.name, this.xCoord, this.yCoord-10);
  }

  //Moves ship and checks collision with borders
  public void moveShip() {
    if (this.yUp == true) {
      if (this.yCoord > 0) {
        this.yCoord -= 6;
      }
    }
    if (this.yDown == true) {
      if (this.yCoord+50 < height) {
        this.yCoord += 6;
      }      
    }
    if (this.xLeft == true) {
      if (this.xCoord - 25 > 0) {
        this.xCoord -= 6;
      }
    }
    if (this.xRight == true) {
      if (this.xCoord + 25 < width) {
        this.xCoord += 6;
      }
    }
  }

  //Getters
  
  public float getHitX() {
    return this.hitX;
  }
  public float getHitY() {
    return this.hitY;
  }
  public float getHitRad() {
    return this.hitRad;
  }
  public int getHealth() {
    return this.health;
  }
  public float getScore() {
    return this.score;
  }
  public String getShipName() {
    return this.name;
  }

  //Setters

  public void setHealth(int hp) {
    if (hp > -1) {
      this.health = hp;
    }
  }

  public void setXCoord(int x) {
    if ((x > 25) && (x < width - 25)) {
      this.xCoord = x;
    }
  }

  public void setYCoord(int y) {
    if ((y > 0) && (y < height)) {
      this.yCoord = y;
    }
  }

  public void setScore(float score) {
    if (score > -1) {
      this.score = score;
    }
  }

  public void setShipName() {
    //Prompts user to set name. Doesn't allow < 3 or > 3 characters
    this.name = JOptionPane.showInputDialog("Enter your name (3 chars)", "AAA");
    if (this.name == null) {
      this.setShipName();
    }
    if (this.name.length() != 3) {
      this.setShipName();
    }
  }
}
