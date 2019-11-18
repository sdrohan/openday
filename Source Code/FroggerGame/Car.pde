public class Car { 
  private int red, green, blue, carHeight;
  private float xpos, ypos, yspeed;

  public Car(int red, int green, int blue, float xpos, float ypos, float yspeed) {
    if ((red>-1)&&(red<256)) {
      this.red = red;
    } else {
      this.red=200;
    }
    if ((green>-1)&&(green<256)) {
      this.green = green;
    } else {
      this.green=200;
    }
    if ((blue>-1)&&(blue<256)) {
      this.blue = blue;
    } else {
      this.blue=200;
    }
    if ((carHeight>0)&&(carHeight<40)) {
      this.carHeight = carHeight;
    } else {
      this.carHeight = 30;
    }
    if ((xpos>0)&&(xpos<width)) {
      this.xpos = xpos;
    } else {
      this.xpos=300;
    }
    if ((ypos>-1)&&(ypos<1)) {
      this.ypos = ypos;
    } else {
      this.ypos=ypos;
    }
    if ((yspeed>0)&&(yspeed<12)) {
      this.yspeed = yspeed;
    } else {
      this.yspeed=4;
    }
  } // car arguments 



  //variables for method "display"
  public void display() {
    stroke(0);
    fill(this.red, this.green, this.blue);
    rect(this.xpos, this.ypos, 20, this.carHeight);
  } //void display

  //variables for method "down"
  public void down() {
    this.ypos = this.ypos + this.yspeed;
    if (this.ypos > height) {
      this.ypos = 0; // vans repeat at end of screen
    } //if
  }//void down

  //getters
  public int getRed() {
    return red;
  }

  public int getGreen() {
    return green;
  }

  public int getBlue() {
    return blue;
  }

  public int getCarHeight() {
    return carHeight;
  }

  public float getXpos() {
    return xpos;
  }

  public float getYpos() {
    return ypos;
  }

  public float getYspeed() {
    return yspeed;
  }

  //setters

  public void setRed(int red) {
    if ((red>-1)&&(red<256)) {
      this.red=red;
    } else {
      this.red=200;
    }
  }

  public void setGreen(int green) {
    if ((green>-1)&&(green<256)) {
      this.green=green;
    } else {
      this.green=200;
    }
  }

  public void setBlue(int blue) {
    if ((blue>-1)&&(blue<256)) {
      this.blue=blue;
    } else {
      this.blue=200;
    }
  }

  public void setCarHeight(int carHeight) {
    if ((carHeight>0)&&(carHeight<40)) {
      this.carHeight=carHeight;
    } else {
      this.carHeight = 30;
    }
  }

  public void setXpos(float xpos) {
    if ((xpos>0)&&(xpos<800)) {
      this.xpos=xpos;
    } else {
      this.xpos=0;
    }
  }

  public void setYpos(float ypos) {
    if ((ypos>0)&&(ypos<800)) {
      this.ypos=ypos;
    } else {
      this.ypos=400;
    }
  }

  public void setYspeed(float yspeed) {
    if ((yspeed>0)&&(yspeed<12)) {
      this.yspeed=yspeed;
    } else {
      this.yspeed=4;
    }
  }
}//class car