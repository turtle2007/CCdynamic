class drawObject{
      float obj_size = 0;
      float getScreenX = 0;
      float getScreenY = 0;
      
      drawObject(){}
      
      drawObject(float objectSize, float X, float Y){
        obj_size = objectSize;
        getScreenX = X;
        getScreenY = Y;
      }
      
      void drawing(){    // this is for the calibration
      noStroke();
      pushMatrix();
      translate(getScreenX, getScreenY);
      fill(200, 180, 180, 200);
      noStroke();      
      ellipse(0, 45, obj_size/5, obj_size/5);
      ellipse(0, -45, obj_size/5, obj_size/5);
      ellipse(45, 0, obj_size/5, obj_size/5);
      ellipse(-45, 0, obj_size/5, obj_size/5);
      popMatrix();
      }
      
      void drawGrid(){   //------------------------
      stroke (200);      // changed in 22 March, 2016. 
      line(60,35,690,35);
      line(60,105,690,105);
      line(60,175,690,175);
      line(60,245,690,245);
      line(60,315,690,315);
      line(60,385,690,385);
      line(60,455,690,455);
      line(60,525,690,525);
      line(60,595,690,595);
      line(60,665,690,665);
      
      line(60,35,60,665);
      line(130,35,130,665);
      line(200,35,200,665);
      line(270,35,270,665);
      line(340,35,340,665);
      line(410,35,410,665);
      line(480,35,480,665);
      line(550,35,550,665);
      line(620,35,620,665);
      line(690,35,690,665);    
    }   //------------------------------------------
   void drawCentre(){
      noStroke();
      fill(200, 20, 20);
      rect(345, 320, 60, 60);
      fill(120,120,120);
      rect(348, 323, 54, 54);
      }
    void drawTarget(){
      noStroke();
      fill(200, 20, 20);
      pushMatrix();
      translate(getScreenX, getScreenY);
      ellipse(0, 0, obj_size, obj_size);
      textFont(font, 10*scale_factor);
      stroke(210, 200, 255);
      text("I'm here", -10,10 );
      popMatrix();
      }
    
}
