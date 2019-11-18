class Ball {

  private float diameter, velocityVal;
  private PVector position, velocity;  

  Ball(float diameter, float vel) {
    setDiam(diameter);
    setVelocity(vel);
    this.velocityVal = vel;
    position = new PVector(0, 0);    

    ballReset();
  }  


  //MAIN BALL LOGIC
  public boolean update(Paddle player) {//ball movement for freeplay
    boolean bounced = false;    

    if (position.y < (diameter/2)) { //bounce on ceiling   
      bounce(0);
    }
    if (position.x > width - (diameter/2) || position.x < (diameter/2)) { //bounce on right and left edge
      velocity.x *= -1; 
    }
    if (player.collision(position, diameter)) {
      bounced = true;
      bounce(player.direction()); //check for modifier dependant on paddle movement
    }       

    position.add(velocity);    //move the position of ball based on velocity
    ballDraw();

    return bounced;
  }

  public void update(Paddle player, Paddle cpu) {    
    if (position.x > width - (diameter/2) || position.x < (diameter/2)) { //bounce on right and left edge
      velocity.x *= -1;
    }
    if (player.collision(position, diameter)) {
      bounce(player.direction()); //check for modifier dependant on paddle movement
    }
    if (cpu.collision(position, diameter)) {
      bounce(cpu.direction()); //check for modifier dependant on paddle movement
    }

    position.add(velocity); //move the position of ball based on velocity
    ballDraw();
  }

  //MODIFIER TO X-SPEED, BALL CURVING
  public void bounce(float mod) { //when bounced from paddle    
    velocity.y *= -1;
    velocity.setMag(velocity.mag() + 0.5);
    PVector rotated = velocity; //start with current velocity    
    rotated.rotate(mod); //rotate the vector by the mod from paddle class
    if (rotated.heading() < -0.6 && rotated.heading() > -2.45) { //radian limits for ~25 and 155 degrees
      velocity = rotated;
    }    
  }

  //CHECK IF BALL PASSED Y-AXIS BOUNDS
  private int checkBounds() {
    if (position.y > height + diameter) {      
      ballReset();
      return 1; //if player lost
    } else if (position.y < - diameter) {
      ballReset();
      return 0; //if cpu lost
    }
    return 3; //if ball still in bounds
  }  

  //BALL GRAPHICS
  private void ballDraw() {        
    ellipse(position.x, position.y, diameter, diameter);
  }

  //BRING BACK BALL INTO PLAY
  public void ballReset() {    
    position.set(width/2, diameter/2 + 50);
    setVelocity(velocityVal); //set velocity magnitude to the starting value
  }

  //GETTERS
  public float getDiam() {
    return diameter;
  }  

  public PVector getPosition() {
    return position;
  }

  public PVector getVelocity() {
    return velocity;
  }

  //SETTERS
  public void setDiam(float diameter) {
    if (diameter < 10) {
      this.diameter = 20;
    } else {
      this.diameter = diameter;
    }
  }

  public void setVelocity(float v) {
    if (v < 0) {
      this.velocity = PVector.fromAngle(random(0.78, 2.35)).setMag(5); //SELF COMMENT - CHANGE LATER: No idea what is this warning suggesting. How to call it through class? Class of PVector?
    } else {
      this.velocity = PVector.fromAngle(random(0.78, 2.35)).setMag(v);
    }
  }
}