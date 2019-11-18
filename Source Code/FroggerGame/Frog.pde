public class Frog {//class frog
  private int red, green, blue;
  private float xfrog, yfrog, diameter;



  public Frog(int red, int green, int blue, float xpos, float ypos, float diameter) {
    if ((red>-1)&&(red<255)) {
      this.red = red;
    } else {
      this.red=200;
    }
    if ((green>-1)&&(green<255)) {
      this.green = green;
    } else {
      this.green=200;
    }
    if ((blue>-1)&&(blue<255)) {
      this.blue = blue;
    } else {
      this.blue=200;
    }
    if ((xfrog>0)&&(xfrog<800)) {
      this.xfrog = xpos;
    } else {
      this.xfrog=0;
    }
    if ((yfrog>0)&&(yfrog<800)) {
      this.yfrog = ypos;
    } else {
      this.yfrog=400;
    }
    if ((diameter>0)&&(diameter<40)) {
      this.diameter=diameter;
    } else {
      this.diameter=25;
    }
  }//frog

  public void resetFrog() {//resets frog to left side
    xfrog=10;
    yfrog=400;
  }

  public void show() { //Draw Frog
    stroke(0);
    fill(255);
    ellipse(this.xfrog-8, this.yfrog-12, 10, 10); //Left Eye
    ellipse(this.xfrog+8, this.yfrog-12, 10, 10); //Right Eye
    fill(this.red, this.green, this.blue); 
    ellipse(this.xfrog-13, this.yfrog+5, 8, 10); //Left Leg
    ellipse(this.xfrog+13, this.yfrog+5, 8, 10); //Right Leg
    ellipse(this.xfrog, this.yfrog, this.diameter, this.diameter);//Body
  }//voidShow

  public void move() {//move frog around the screen
    if (keyPressed==true) {
      if (key == CODED) {
        if (keyCode == UP) {
          this.yfrog = this.yfrog-5;
        }//up
        if (keyCode == DOWN) {
          this.yfrog = this.yfrog +5;
        }//down
        if (keyCode == LEFT) {
          this.xfrog = this.xfrog -5;
        }//left
        if (keyCode == RIGHT) {
          this.xfrog = this.xfrog +5;
        } //right
      }//if key coded
    }//if key pressed
    if (this.yfrog > height) {//frog resets at top of screen if goes off the bottom
      this.yfrog = 10;
    }
    if (this.xfrog> width) {//frog resets to left of screen if scores point and
      //goes off the right side
      this.xfrog = 10;
    }
  }//void move

  //getters
  public int getRed() {
    return red;
  }//getRed

  public int getGreen() {
    return green;
  }//getGreen

  public int getBlue() {
    return blue;
  }//getBlue

  public float getXfrog() {
    return xfrog;
  }//getXfrog

  public float getYfrog() {
    return yfrog;
  }//getYfrog

  public float getDiameter() {
    return diameter;
  }//getDiameter

  //setters
  public void setRed(int red) {
    if ((red>-1)&&(red<255)) {
      this.red=red;
    } else {
      this.red=200;
    }
  }//setRed

  public void setGreen(int green) {
    if ((green>-1)&&(green<255)) {
      this.green=green;
    } else {
      this.green=200;
    }
  }//setGreen

  public void setBlue(int blue) {
    if ((blue>-1)&&(blue<255)) {
      this.blue=blue;
    } else {
      this.blue=200;
    }
  }//setBlue

  public void setXfrog(float xfrog) {
    if ((xfrog>0)&&(xfrog<800)) {
      this.xfrog=xfrog;
    } else {
      this.xfrog=0;
    }
  }//set Xfrog

  public void setYfrog(float yfrog) {
    if ((yfrog>0)&&(yfrog<800)) {
      this.yfrog=yfrog;
    } else {
      this.yfrog=400;
    }
  }//set Yfrog

  public void setDiameter(float diameter) {
    if ((diameter>0)&&(diameter<40)) {
      this.diameter=diameter;
    } else {
      this.diameter=25;
    }
  }//set Diameter
}//class frog