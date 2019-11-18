class scoreHandler {

  //KEEPS SCORE FOR THE CURRRENT GAME
  void scoreCount(int bounds) { //check if ball is in bounds
    if (mode == 2) {
      if (bounds == 0) { //if cpu loses in tournament 
        if (player.scoreUp(1, 11)) { //score increase, score limit
          gameOver(player.getNam());
        }
      } else if (bounds == 1) {    //if player loses in tournament
        if (cpu.scoreUp(1, 11)) {
          gameOver(cpu.getNam());
        }
      }
    } else {
      if (bounds == 1) { //if player loses in freeplay
        gameOver(player.getNam());
      }
    }
  }

  //ADD NEW PLAYER HS ONTO THE LIST
  void highscoreUpdate(int i) {    
    if (i <= 9) {      //scores are kept at odd indexes in array of size 10
      if (parseInt(highscores[i]) <= player.getScore()) {   //if score lower than new score is found move all scores one place down and place the new score in position 
        for (int j = 9; j > i; j -= 2) {          
          highscores[j] = highscores[j-2];
        }
        highscores[i] = String.valueOf(player.getScore());
        highscores[i-1] = player.getID();
        return; //score updated - method can end
      } else {
        highscoreUpdate(i + 2); //check for next place if the previous score was higher than player score
      }
    }
  }


  //GAME OVER POP UP
  void gameOver(String name) {
    highscoreUpdate(1); //compare highscores starting from index 1 in array (even index are players id)
    if (mode == 1) {    
      JOptionPane.showMessageDialog(null, "Game Over!\nScore for " + name + ": " + player.getScore()
        + "\nTOP 5 HIGH SCORES:"
        + scoreJoin());                                                     
      saveScore();
    } else {
      JOptionPane.showMessageDialog(null, "Game Over!\n" + name + " has won!");
    }

    mode = 3;
  }


  //CONVERT STRING ARRAY INTO A DISPLAY FORMATTED STRING
  String scoreJoin() {
    String scDisp = "";
    for (int i = 0; i < 9; i += 2) {
      scDisp = String.join("", scDisp, "\n", String.valueOf(i/2 + 1), ". ", highscores[i], " - ", highscores[i+1]); //join player id and player score for display in high scores
    }

    return scDisp;
  }

  //READ/WRITE HIGHSCORES TO A FILE
  void saveScore() {
    FileWriter writer = null;   //

    try {
      writer = new FileWriter(sketchPath() + "/highscore.txt");    //initialize new writeer for the file in sketch location
      for (String str : highscores) {
        writer.write(str + ",");
      }
    } 
    catch (IOException e) { //if there's IO exception - show stack trace and print an error
      println(e + ": Error writing to file");
      e.printStackTrace();
    }
    finally
    { //if no exceptions were thrown
      try {
        if (writer != null) { //try closing the writer if it exists
          writer.close();
        }
      } 
      catch(IOException e) {//if there's IO exception - show stack trace and print an error
        println(e + ": Error closing file");
        e.printStackTrace();
      }
    }
  }

  void loadScore() { 
    BufferedReader reader = null;  //declare new file reader

    try {
      reader = new BufferedReader(new FileReader(sketchPath() + "/highscore.txt"));   //using buffered reader instead of filereader fot the readline function 
      highscores = reader.readLine().split(","); //try with new file reader initialized for file in the sketch folder
    } 
    catch (IOException e) {//if there's IO exception - show stack trace and print an error
      e.printStackTrace();
    }
    finally
    { 
      try {
        if (reader != null) { //try closing reader if it exists
          reader.close();
        }
      } 
      catch(IOException e) {//if there's IO exception - show stack trace and print an error
        println(e + ": Error closing file");
      }
    }
  }
}
