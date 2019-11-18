public class Explosion {
  private int timer = 0; //timer for delay of enemy hit
  private int explosionRadius = 0;//radius for the explosion
  private int explosionX; // positions of the shots 
  private int explosionY;
  private int shotsFiredX = 0;
  private int shotsFiredY = 0;

  public Explosion(int shotsFiredX, int shotsFiredY) {
    setExplosionX(shotsFiredX) ;
    setExplosionY(shotsFiredY);
  }

  public void fire() {  
    if (mousePressed && mouseButton==LEFT) {
      explosionRadius = 5;
    }
    stroke(#ff0000);
    noFill();
    ellipse(explosionX, explosionY, explosionRadius, explosionRadius);
  }

  public void explosion() {
    if (millis() > timer + 100 && explosionRadius < 100 && explosionRadius > 0) {
      timer = millis();
      explosionRadius += 5;
    } else if (explosionRadius >= 100) {
      explosionRadius = 0;
      shotsFiredX++;
      shotsFiredY++;
    }
  }
  //getters
  public int getTimer() {
    return timer;
  }
  public int getExplosionRadius() {
    return explosionRadius;
  }
  public int getExplosionX() {
    return explosionX;
  }
  public int getExplosionY() {
    return explosionY;
  }
  public int getShotsFiredX() {
    return shotsFiredX;
  }
  public int getShotsFiredY() {
    return shotsFiredY;
  }
  //setters
  public void setExplosionX(int explosionX) {
    this.explosionX = explosionX;
  }
  public void setExplosionY(int explosionY) {
    this.explosionY = explosionY;
  }
  public void setExplosionRadius(int explosionRadius) {
    this.explosionRadius = explosionRadius;
  }
}
