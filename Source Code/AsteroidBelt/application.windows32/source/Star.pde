// White stars in the background
public class Star {
  private float xCoord;
  private float yCoord;
  private float starSize;
  private float starSpeed;
  
  public Star() {
  }
  
  public Star(float x, float y, float size, float spd) {
    this.xCoord = x;
    this.yCoord = y;
    this.starSize = size;
    this.starSpeed = spd;
  }
  
  // Draws the visible star
  public void drawStar() {
    fill(255);
    ellipse(this.xCoord,this.yCoord,this.starSize,this.starSize);
  }
  
  //Moves star down the screen and resets once they leave the screen
  public void moveStar() {
    this.yCoord += this.starSpeed;
    //If star leaves screen
    if ((this.yCoord + this.starSize) > height) {
      this.yCoord = -20;
      this.xCoord = random(0,width);
    }
  }
}
