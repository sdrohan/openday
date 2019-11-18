public class Enemy {
  private float xCoord; //x coordinate of the tank
  private float yCoord; //y coordinate of the tank
  private float hitbox = 90; //for being hit
  private int paint; //set color of the tank
  private int xSpeed; //set X axis speed of the tank
  private int ySpeed; //set Y axis speed of the tank
  private int speed; //both speeds are the same but need to be kept separate
  private int look; //direction of the rifle

  //Constructor to default position of the tank
  public Enemy(int xCoord, int yCoord, int paint, int speed) {
    setXCoord(xCoord);
    setYCoord(yCoord);
    setPaint(paint);
    setSpeed(speed);
  }

  //draws tank
  public void display() {
    noStroke();
    noFill();
    rect (xCoord, yCoord-20, hitbox, hitbox); //hitbox
    stroke(0);
    fill(paint); //colour
    rect(0+xCoord+look, 10+yCoord, 50, 10); //gun looking left
    ellipse(50+xCoord, 25+yCoord, 30, 50); //entrance
    rect(15+xCoord, 25+yCoord, 70, 30); //body
    for (int i = 0; i<80; i+=20) { //wheel loop
      ellipse(20+xCoord+i, 55+yCoord, 20, 20);
    }
  }

  //Tank movement
  public void live() {
    xCoord = xCoord + xSpeed;
    yCoord = yCoord + ySpeed;

    //if ball hits left or right
    if (xCoord+hitbox>width) {
      xSpeed = xSpeed * -1;
    } else if (xCoord<0) {
      xSpeed = xSpeed * -1;
    }

    //direction of the rifle
    if (xSpeed<0) {
      look = 0;
    } else {
      look = 50;
    }


    //if ball hits top or bottom
    if (yCoord+hitbox > height) {
      ySpeed = ySpeed * -1;
    } else if (yCoord < 200) {
      ySpeed = ySpeed * -1;
    }
  }

  //getter methods
  public float getXCoord() {
    return xCoord;
  }

  public float getYCoord() {
    return yCoord;
  }

  //setter methods
  public void setXCoord(int xCoord) {
    if ((xCoord<width)&&(xCoord>0)) {
      this.xCoord = xCoord;
    } else {
      this.xCoord = width/2;
    }
  }

  public void setYCoord(int yCoord) {
    if ((yCoord<height)&&(yCoord>200)) {
      this.yCoord = yCoord;
    } else {
      this.yCoord = height/2;
    }
  }
  public void setPaint(int paint) {
    this.paint = paint;
  }
  public void setSpeed(int speed) {
    if ((speed<=20)) {
      this.xSpeed = speed;
      this.ySpeed = speed-2;
    } else {
      this.xSpeed = 5;
      this.ySpeed = 3;
    }
  }
}
