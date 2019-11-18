public class Background {
  private int horizon; //adjustable sky color
  private int ground; //adjustable ground color

  //Constructor for inputs of colours
  public Background(int horizon, int ground) {
    setHorizon(horizon);
    setGround(ground);
  }

  //draws background
  public void display() {
    //HORIZON
    noStroke();
    fill(horizon);
    for (int i=0; i<200; i+=35) {
      ellipse(width/2, i, 1000, 100);
    }
    //GROUND
    fill(ground);
    for (int i=200; i<height; i+=35) {
      ellipse(width/2, i, 1000, 100);
    }
  }

  //getter methods
  public float getHorizon() {
    return horizon;
  }

  public float getGround() {
    return ground;
  }

  //setter methods
  public void setHorizon(int horizon) {
    if (horizon>=#c8c8ff) {
      this.horizon = horizon;
    } else {
      this.horizon = #c8c8ff;
    }
  }
  public void setGround(int ground) {
    if (ground>=#c8c8ff) {
      this.ground = ground;
    } else {
      this.ground = #c8ffc8;
    }
  }
}