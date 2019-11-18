class Paddle {
  private float paddleH, paddleW, paddleS;  
  private PVector position;
  private int sequenceInd, sequenceMod;
  private float[] posXDiff = new float[2];

  private int hitTime = 0;

  Paddle(float paddleW, float paddleH, float paddleS, float posY) {    
    this.paddleW = paddleW;
    this.paddleH = paddleH;
    this.paddleS = paddleS;
    setMiddlePoint(posY);    

    sequenceInd = 0;
    sequenceMod = 1;
  }

  //UPDATE METHODS FOR PLAYER AND CPU PADDLES
  void update() { //player move
    if (keyPressed && keyCode == LEFT && position.x > paddleW/2) {      
      position.x -= paddleS;
    }
    if (keyPressed && keyCode == RIGHT && position.x < width - paddleW/2) {
      position.x += paddleS;
    }

    sequence();
    display(); //update sequence for movement tracking and draw the paddle
  }

  void update(Ball b) { //CPU move    
    if (b.velocity.y < 0) {
      if (position.x > b.position.x + 10 && position.x > paddleW/2) {
        position.x -= paddleS;
      }
      if (position.x < b.position.x - 10 && position.x < width - paddleW/2) {
        position.x += paddleS;
      }
    }

    sequence();
    display();//update sequence for movement tracking and draw the paddle
  }

  private void display() {    
    rect(position.x - paddleW/2, position.y - paddleH/2, paddleW, paddleH); //draw paddle relative from its middle point
  }

  //CHECK COLLISION DISTANCE
  boolean collision(PVector ballPos, float ballDiam) {    
    float distX = abs(ballPos.x - position.x); //distance from middle of ball to middle of paddle X axis
    float distY = abs(ballPos.y - position.y); //distance from middle of ball to middle of paddle Y axis
    float cornerDistL = ballPos.dist(new PVector(position.x - paddleW/2, position.y - paddleH/2));
    float cornerDistR = ballPos.dist(new PVector(position.x + paddleW/2, position.y - paddleH/2));

    if (ballPos.y < height - ballDiam && ballPos.y > ballDiam) { //don't calculate if ball is behind the paddle
      if (distX < paddleW/2 && distY < ballDiam/2 + paddleH/2) { //check if ball hit corner for some additional precision
        if (millis() > hitTime + 500) { //only return true at most once every 500ms
          hitTime = millis();        
          return true;
        }
      }   

      if (cornerDistL < ballDiam/2 || cornerDistR < ballDiam/2) { //check if ball hit corner for some additional precision
        if (millis() > hitTime + 500) { //only return true at most once every 500ms
          hitTime = millis();        
          return true;
        }
      }
    }

    return false; //if distance is too high for any collision to happen
  }

  //SHOW DIRECTION PADDLE IS MOVING TO
  private float direction() {   
    if (posXDiff[sequenceInd] > posXDiff[sequenceInd + sequenceMod]) {            
      return -0.5; //moving left - value in radians for use with ball curving
    } else if (posXDiff[sequenceInd] < posXDiff[sequenceInd + sequenceMod]) {      
      return 0.5; //moving right
    } else return 0;//random(-0.5, 0.51);
  }  

  //HELPER METHOD FOR DETERMINING DIRECTION OF PADDLE
  private void sequence() {
    posXDiff[sequenceInd] = position.x; //save current x position
    sequenceInd += sequenceMod; //shift index 
    sequenceMod *= -1; //reverse mod, so index is only ever 1 or 0
  }

  //GETTERS
  public float getHeight() {
    return paddleH;
  }

  public float getWidth() {
    return paddleW;
  }

  public PVector getPosition() {
    return position;
  }

  //SETTERS
  public void setMiddlePoint(float y) {
    if (y > height - paddleH/2 || y < paddleH/2) {      
      position = new PVector().set(width/2, height - 5 - paddleH/2);
    } else {
      position = new PVector().set(width/2, y);
    }
  }
}