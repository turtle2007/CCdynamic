import TUIO.*;
import processing.serial.*;
import ddf.minim.*;
import ddf.minim.signals.*;
import com.rapplogic.xbee.api.XBee;
import com.rapplogic.xbee.api.XBeeAddress16;
import com.rapplogic.xbee.api.XBeeAddress64;
import com.rapplogic.xbee.api.XBeeException;
import com.rapplogic.xbee.api.XBeeResponse;
import com.rapplogic.xbee.api.zigbee.ZNetTxRequest;
import com.rapplogic.xbee.api.zigbee.ZNetTxStatusResponse; 
import com.rapplogic.xbee.util.DoubleByte;

Minim minim;
AudioOutput out;
SineWave sine;
AudioPlayer player;
makeSound makesound;
XBee xbee;
XbeeSend xbeesend;
drawObject drawingObj;
run runSketch;
TuioProcessing tuioClient; // declare a TuioProcessing client
checkGrid checking; // store the grid number, used in creating log file.
createLog CreateLog;
PrintWriter timePoint;

int gameStep = 1, stepRecord = 1; 
int gameLevel = 11, gameLevelpre = 0;
int flag = 0, flagpre = 100;
int conDition = 100;
int markX = 5, markY = 5, markXpre = 5, markYpre = 5; // store the grid number, used in creating log file.
// these are some helper variables which are used to create scalable graphical feedback
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
PFont font;
boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks
int distance, intensity;  // store the distance between the object and the target
int Time, startTime, timer = 1;
PVector vTarget, vObj; // used for distance calculation
int objX = 0, objY = 0, vTargetX, vTargetY;// used for distance calculation
int Switch = 1;
int position;// store the object's position
int audio = 1, audio2 = 1;
int[] links = new int[8]; // recording how many trails have been done
int[] tempor = new int[8]; // this is used in random order
int[] timeList = new int[11]; // used for recording movement, output to the log file
int[] startingNote = new int[6]; // year, month, date
int temp = 100;
int[][] targets = new int[][]{{375,70},{585,140},{655,350},{585,560},{375,630},{165,560},{95,350},{165,140}};

//---------------------------------------------------------------------------------------
void setup(){
  tuioClient  = new TuioProcessing(this);
  xbee = new XBee();
  xbeesend = new XbeeSend();
  checking = new checkGrid();
  CreateLog = new createLog(); // used for creat log in the timelist array
  // Create a new file in the sketch directory
  timePoint = createWriter("The Time.txt"); 
  runSketch = new run();
  makesound = new makeSound();
  minim = new Minim(this);//build minim object for the audio effect
  out = minim.getLineOut(Minim.STEREO);
  sine = new SineWave(440, 0.5, out.sampleRate());
  sine.portamento(200);
  
  player = minim.loadFile("s1.aiff");
  
  noCursor();
  size(750, 700);
  noStroke();
  fill(0);
  // periodic updates
  if (!callback) {
    frameRate(60);
    loop();
  } else noLoop(); // or callback updates 
  
  font = createFont("Arial", 18);
  scale_factor = height/table_size;
  
  CreateLog.startingNote();
  timePoint.println("--------Here starting a new trial----------");
  timePoint.print("The date: ");
  for(int i = 0; i < 6; i++){
      timePoint.print(startingNote[i]+"  ");
      }
  timePoint.println("\n");
  try {
   xbee.open("COM5", 9600);
  }
  catch(XBeeException e) {
    e.printStackTrace();
  }
}

void draw(){
  background(120);
  drawingObj = new drawObject();
  drawingObj.drawGrid(); // draw the 9*9 grid
  drawingObj.drawCentre(); 
  //game level control
  if (gameLevel != gameLevelpre){  
  for(int i = 0; i < 8; i++){ // if get to the new game level, temp[] back to initial
    tempor[i] = -1;
    links[i] = -1;
    }
    xbeesend.sendingData5(); //  first time, sending 9, initialization of the physical object
    
  if(gameStep == 1){  // I need to input the trial condition here based on the user group
    fill(35, 15, 44);
    textFont(font, 18*scale_factor);
    String myString = "Please choose the condition: v-Visual, h-Haptic, a-Audio.";
    text(myString, 170, 280);
    if(conDition != 100){
      gameLevelpre = gameLevel;
      xbeesend.sendingData3();
      gameStep = 2;
      }
   }
  }
  
  // inform participants to place the T_object 
  if(gameStep == 2){
    fill(35, 15, 44);
    String myString = "Please put the cube in the centre.";
    text(myString, 200, 260);
    ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
    if (tuioObjectList.size () > 0){
      gameStep = 3;
      }
    }
  //game begin
  if(gameStep == 3){
     if(conDition == 11){// this audio will play only under the audio-involved conditions.
       if(audio == 1){
        out.addSignal(sine);
        audio = 0;
        }
        runSketch.running();
      }
      if(conDition == 12 || conDition == 13){
        runSketch.running();
        }
  }
fill(210); 
text("Flag: "+flag, 350, 20);
}
// Experimental control
void keyPressed(){
   switch(key){
     case 'a':
       conDition = 11;
       println(conDition);
       break;
       case 'v':
       conDition = 13;
       println(conDition);
       break;
       case 'h':
       conDition = 12;
       println(conDition);
       break;
       case 'g':
       gameLevel ++;
       flag = 0;
       break;
   }
}
  
void mouseClicked ()
{
startTime = millis();
flag ++; 
stepRecord = 1;
audio = 1;
audio2 = 1;
timer = 1;
 if(conDition == 12){
 xbeesend.sendingData6();// the value countained is 10 
 }
}

