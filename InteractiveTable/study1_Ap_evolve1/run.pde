class run {
  run() {
  }
  void running () {
    float obj_size = object_size*scale_factor; 
    if (flag != flagpre) {//---------------recording time based on flags.
      flagpre = flag;
    // under the top game level,
    //randomly allocate a target position 8 times according to 8 flags.
    do{
      temp = (int)random(0,8);
      }while(temp == tempor[temp]); // if the position has been allocated before,
    tempor[temp] = temp;         // generate a new one.
    vTargetX = targets[temp][0]; // then caculate the target PVector
    vTargetY = targets[temp][1];
    vTarget = new PVector (vTargetX, vTargetY);
    } //------------------------------------------------------------------
    // draw objects
    ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
    for (int i=0; i<tuioObjectList.size (); i++) { 
      TuioObject tobj = tuioObjectList.get(i);
      vObj = new PVector (tobj.getScreenX(width), tobj.getScreenY(height));
      position = (int)tobj.getScreenX(width);
      drawingObj = new drawObject (obj_size, tobj.getScreenX(width), tobj.getScreenY(height));
      drawingObj.drawing();

      distance = (int)PVector.dist(vTarget, vObj);
      if(distance < 0){
        distance *= -1;
        }
      if (links[flag] == -1) {
        markX = checking.codingGridX((int)tobj.getScreenX(width));
        markY = checking.codingGridY((int)tobj.getScreenY(height));
        if (markX != markXpre || markY != markYpre){
           markXpre = markX;
           markYpre = markY;
           CreateLog.timeLog();
           saveFrame();
           for(int j = 0; j < 11; j++){
             timePoint.print(timeList[j]+"  ");// Writes the remaining data to the file
             }
           timePoint.println("\n");
           timePoint.flush();
        }
      }  
      intensity = (int)map(distance, 760, 50, 250, 1);
      
      if(intensity > 254){
      intensity = 250;
      }else if(intensity == 0){
      intensity = 1;
      }
      
      // 1. sound control
      if(conDition == 11){
      makesound.changeGainFreq(position);
      }      
      //2. vibrition motor  or LED control
      if(conDition != 11 && links[flag] != 1){ 
        xbeesend.sendingData1();
        }
        
      if(distance < 50) {
         if(timer == 1){
         Time = millis();
         timer = 0;
         }
       if(conDition == 11){
          player.play();
          if(audio2 == 1){
            player.rewind();
            audio2 = 0;
            }
          out.removeSignal(sine);
          }else {
            xbeesend.sendingData2();
          }
        links[flag] = 1;
        if(flag == 7){
        fill(35, 15, 44);
        textFont(font, 18*scale_factor);
        text("Now you finished this trial!", 150, 300);
        }
      }
         
      //time and congratulation display   
      if (links[flag] != -1) {
        if(conDition == 13){
          drawingObj.drawTarget();
        }
        fill(35, 15, 44);
        textFont(font, 18*scale_factor);
        text("You find me !", tobj.getScreenX(width) - 35, tobj.getScreenY(height) + 70);
      }
    } 
  }//running
  
}//class

// ----------------------------------------------------------------------------------------------
// these callback methods are called whenever a TUIO event occurs
// there are three callbacks for add/set/del events for each object/cursor/blob type
// the final refresh callback marks the end of each TUIO frame

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
    +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  if (verbose) println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  //redraw();
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  if (verbose) println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
    +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
  //redraw();
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  if (verbose) println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  if (verbose) println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
  //redraw();
}

// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
  if (verbose) println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
    +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
  //redraw()
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
  if (verbose) println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}
