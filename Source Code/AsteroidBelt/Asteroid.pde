public class Asteroid {
  //Asteroid obstacles which can collide with the ship's hitbox
  private float xCoord;
  private float yCoord;
  private float size;
  private float speed;
  private float speedMultiplier;

  public Asteroid() {

  }

  public Asteroid(float x,float y,float astSize, float astSpeed) {
    //Limits x values to the width of the window
    if ((x > 0) && (x < width)) {
      this.xCoord = x;
    }
    //Defaults to x being in the centre of the screen
    else {
      this.xCoord = width/2;
    }
    if (y+astSize < 0) {
      this.yCoord = y;
    }
    //Limits of asteroid sizes
    if ((astSize > 50) && (astSize < 200)) {
      this.size = astSize;
    }
    //Defaults to 100 if the asteroid's too big/small
    else {
      this.size = 100;
    }
    //Limits astSpeed to positive values
    if (astSpeed > 0) {
      this.speed = astSpeed;
    }
    //Defaults astspeed to 10
    else {
      this.speed = 10;
    }
    
    this.speedMultiplier = 1;
  }

  public void drawAsteroid() {
    fill(102,64,20);
    ellipse(this.xCoord,this.yCoord,this.size,this.size);
    fill(150,86,30);
    ellipse(this.xCoord-this.size/20,this.yCoord,this.size-this.size/10,this.size-this.size/20);
  }

  public void moveAsteroid() {
    //Moves the asteroids down the screen
    this.yCoord += this.speed*this.speedMultiplier;
    if (this.yCoord-this.size > height) {
      this.yCoord = -400;
      this.xCoord = random(0,width);
      this.speed = random(5,20);
      this.size = random(50,200);
    }
  }
  
  //Checks for collision between two circles (Used for Ship and Asteroid)
  public boolean collide(float x1, float y1, float x2, float y2, float r1, float r2) {
    //Gets the distance of a line between 2 circles, true if length of 2 radii > length of line between the ellipses
    if(dist(x1,y1,x2,y2) > (r1+r2)) {
      return false;
    }
    else {
      //Explosion
      fill(255,0,0);
      ellipse(x1,y1,250,250);
      return true;
    }
  }
  
  //Removes the asteroid once it collides
  public void despawn() {
    this.yCoord = height+height;
  }
  
  //Getters
  public float getXCoord() {
    return this.xCoord;
  }
  
  public float getYCoord() {
    return this.yCoord;
  }
  
  public float getSize() {
    return this.size;
  }
  
  //Setters
  public void setXCoord(float newX) {
    //Limits new asteroid X so at least half the asteroid is on screen
    if ((newX > 0 - this.size/2) && (newX < width+this.size/2)) {
      this.xCoord = newX;
    }
  }
  
  public void setYCoord(float newY) {
    //No lower limit as asteroids past the bottom respawn automatically
    if (newY > 0 - height) {
      this.yCoord = newY;
    }
  }
  public void setSpeed(float spd) {
    if (spd > 0) {
      this.speed = spd;
    }
  }
  public void setSize(float newSize) {
    this.size = newSize;
  }
  public void setSpeedMultiplier(float multiplier) {
    this.speedMultiplier = multiplier;
  }
}