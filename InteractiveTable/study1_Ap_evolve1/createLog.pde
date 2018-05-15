class createLog{ 
  void timeLog(){
    timeList [0] = hour();
    timeList [1] = minute();
    timeList [2] = second();
    timeList [3] = millis();
    timeList [4] = startTime;
    timeList [5] = markX;
    timeList [6] = markY;
    timeList [7] = checking.codingGridX(vTargetX);;
    timeList [8] = checking.codingGridX(vTargetY);;
    timeList [9] = flag;
    timeList [10] = stepRecord++;
  }
  void startingNote(){
    startingNote [0] = year();
    startingNote [1] = month();
    startingNote [2] = day();
    startingNote [3] = hour();
    startingNote [4] = minute();
    startingNote [5] = second();
  }  
}
