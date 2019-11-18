//Name : James Richardson
//Programme Name: Computer Forensics and Security
 
/* Frog begins at the left side of the screen
 if hit by one of the cars, the frog resets to the left. 
 */

Frog frog;
Car[] cars = new Car[8];

int i;//for loop-cars
boolean hitFrog;
boolean collision;
int[] x = {215, 265, 315, 365, 415, 465, 515, 565};//eight cars

//variables for the objects
void setup() {

  size(800, 800);
  noCursor();
  for (int i=0; i < 8; i++) {
    cars[i] = new Car(255, 0, 0, x[i], 0, random(3, 10));//random speed of 8 cars
  }
  frog = new Frog(140, 227, 169, 10, 400, 25);
} //void setup


//methods for the objects
void draw() {
  background(200);//road
  fill(0, 200, 0);
  rect(0, 0, 200, 800);//starting grass
  fill(0, 200, 0);
  rect(600, 0, 200, 800);//far side grass
  for (i=200; i<700; i=i+50) {//road lines
    line(i, 0, i, 800);
  } //lines

  for (int x = 0; x < 8; x++) {
    boolean collision = hitFrog(frog, cars[x]);
    if (collision == true) { 
      frog.resetFrog(); //resets frog to left side
    }
    cars[x].down();
    cars[x].display();
  }
  frog.move();
  frog.show();
}//void draw

boolean hitFrog(Frog frog, Car car) {
  //These variables measure the magnitude of the gap between the paddle and the ball.  
  float circleDistanceX = abs(frog.getXfrog() - car.getXpos());
  float circleDistanceY = abs(frog.getYfrog() - car.getYpos() - car.getCarHeight()/2);

  //The Ball is too far away from the Paddle on the X axis to have a collision, so abandon collision detection
  if (circleDistanceX > (frog.getDiameter()/2)) {
    return false;
  }

  //The Ball is too far away from the Paddle on the Y axis to have a collision, so abandon collision detection
  if (circleDistanceY > (car.getCarHeight()/2 + frog.getDiameter()/2)) {
    return false;
  }

  return true;
}    