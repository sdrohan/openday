class Player {
  private String name, id;
  private int score;

  Player(String name) {    
    setNam(name);
    setID(name);
    score = 0;
  }  


  //SCORE CALCULATION
  void scoreUp(int score) {
    this.score += score;
  }

  boolean scoreUp(int score, int limit) {
    this.score += score;

    if (this.score >= limit) {
      return true;
    }

    return false;
  } 

  //GETTERS
  public String getNam() {
    return name;
  }

  public int getScore() {
    return score;
  }

  public String getID() {
    return id;
  }

  //SETTERS

  public void setNam(String name) {
    name = name.replaceAll(" ", "");    
    if (name.length() > 6) {
      this.name = name.substring(1, 6);//shorten name displayed to max of 6 characters after removing empty spaces
    } else this.name = name;
  }  

  public void setID(String name) {
    if (name.length() > 3) {
      id = ((name.toUpperCase()).replaceAll( "[AEIYOU]", "" )).substring(0, 3); //remove wovels and take 3 first letters to form player id for highscore table
    } else id = name.toUpperCase();
  }
}