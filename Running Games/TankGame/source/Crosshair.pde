public class Crosshair {
  private float xCoord; //x coordinate of the crosshair
  private float yCoord; //y coordinate of the crosshair
  private int crosshairCircle; //determines the circle of the crosshair


  //Constructor to default the initial position of the crosshair
  public Crosshair(int crosshairCircle) {
    setCrosshairCircle(crosshairCircle);
  }

  //draws crosshair
  public void display() {
    //dark area
    fill(0);
    noStroke();
    rect(0, 0, xCoord-200, height); 
    rect(width, 0, xCoord-600, height);
    rect(0, 0, width, yCoord-100);
    rect(0, height, width, yCoord-500);
    //crosshair
    noFill();
    stroke(1);
    strokeWeight(99);
    ellipse(xCoord, yCoord, 460, 360);
    strokeWeight(1);
    ellipse(xCoord, yCoord, crosshairCircle, crosshairCircle);
    line(xCoord, yCoord-100, xCoord, yCoord+100);
    line(xCoord-200, yCoord, xCoord+200, yCoord);
  }

  //Aiming with the crosshair
  public void live() {
    xCoord = mouseX;
    yCoord = mouseY;
  }

  //getter methods
  public float getXCoord() {
    return xCoord;
  }

  public float getYCoord() {
    return yCoord;
  }

  //setter methods
  public void setCrosshairCircle(int crosshairCircle) {
    if ((crosshairCircle>=30)&&(crosshairCircle<=200)) {
      this.crosshairCircle = crosshairCircle;
    } else {
      this.crosshairCircle = 100;
    }
  }
}
