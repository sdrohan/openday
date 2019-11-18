public class Player
{
  private float PMouseX;
  private float PMouseY;
 
  public void setPMouseX(float PMouseX){
    if(PMouseX>0 && PMouseX<565){
      this.PMouseX = PMouseX;
    }
  }
  
  public void setPMouseY(float PMouseY){
    if(PMouseY>0 && PMouseY<565){
      this.PMouseY = PMouseY;
    }
  }
  
  public float getPMouseX(){
    return PMouseX;
  }
  
  public float getPMouseY(){
    return PMouseY;
  }
}
