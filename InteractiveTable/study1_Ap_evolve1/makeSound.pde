class makeSound{
  makeSound(){
  }  
  void panningIt(){
    //out.addSignal(osc);
    //out.addListener(waveform);
    //waveform.draw();
    println("panning position: "+position);
    if ( player.hasControl(Controller.PAN) ){
    float val = map(position, 0, width, -1, 1);
    player.setPan(val);
    }
  }
  
  void changeVol(){
    if ( player.hasControl(Controller.GAIN) ){
      float val = map(distance, 0, 500, 6, -30);
      player.setGain(val); 
      }
  }
  
  void changeFreqPan(int X){
    int position;
    position = X;
    float freq = map(distance, 0, 500, 1500, 60);
    sine.setFreq(freq);
    float pan = map(position, 0, width, -1, 1);
    sine.setPan(pan);
  }
  
  void changeGain(){
    float val = map(distance, 0, 500, 16, -30);
    out.setGain(val); 
    text("The current gain is " + out.getGain() + ".", 5, 15);
  }
  
  void changeGainFreq(int X){
    int position;
    position = X;
    float freq = map(distance, 0, 500, 1500, 60);
    sine.setFreq(freq);
    float val = map(distance, 0, 500, 8, -30);
    out.setGain(val); 
    //text("The current gain is " + out.getGain() + ".", 5, 15);
  } 
}
