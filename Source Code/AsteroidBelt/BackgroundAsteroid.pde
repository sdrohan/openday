public class BackgroundAsteroid {
  //Very similar to Star, for asteroids in the background with no collision
  private float xCoord;
  private float yCoord;
  private float size;
  private float speed;
  
  
  public BackgroundAsteroid() {
    
  }
  
  public BackgroundAsteroid(float x,float y,float astSize,float astSpeed) {
    this.xCoord = x;
    this.yCoord = y;
    if (astSize > 0) {
      this.size = astSize;
    }
    if (astSpeed > 0) {
      this.speed = astSpeed;
    }
  }
  
  public void drawBackgroundAsteroid() {
    fill(102,64,19);
    ellipse(this.xCoord,this.yCoord,this.size,this.size);
  }
  
  public void moveBackgroundAsteroid() {
    this.yCoord += this.speed;
    //If asteroid leaves screen
    if ((this.yCoord - this.size) > height) {
      this.yCoord = -20;
      this.xCoord = random(0,width);
      this.size = random(5,15);
    }
  }
}