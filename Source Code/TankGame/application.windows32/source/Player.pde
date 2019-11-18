public class Player {
  private String soldierName;
  public Player(String soldierName) {
    //bug fix for open day...Siobhan
    if (soldierName != null){
      if (soldierName.length() < 8) { //name checking if it's too long
        this.soldierName = soldierName;
      } else {
          this.soldierName = soldierName.substring(0, 8);
      }
    }
    else{
      soldierName = "General WIT";
    }
  }
  //getter
  public String getSoldierName() {
    return soldierName;
  }
  
  //setter
  public void setSoldierName() {
    this.soldierName = soldierName.substring(0,8);
  }
  
}
