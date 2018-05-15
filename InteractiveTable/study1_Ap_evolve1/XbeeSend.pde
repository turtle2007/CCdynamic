class XbeeSend{  
  XbeeSend (){ //actual value
  }
  
  void sendingData1(){
    if(intensity!=9&&intensity!=10&&intensity!=11&&intensity!=12&&intensity!=13){
    try {
            XBeeAddress64 addr64 = new XBeeAddress64(0, 0x13, 0xa2, 0, 0x40, 0xe8, 0xe7, 0x55); //obj 1
            int[] payload = new int[] { intensity };
            ZNetTxRequest tx = new ZNetTxRequest(addr64, payload);
            ZNetTxStatusResponse status = (ZNetTxStatusResponse) xbee.sendSynchronous(tx);
            if (status.isSuccess()) {
              println("I received the package");// the Arduino XBee received our packet
              println(intensity);
              }
            } //try
        catch (Exception e) {
            e.printStackTrace();
            System.exit(-1);
            }
    }//if
  }
  void sendingData2(){ // stop signal
    int i = 0;
    i += 1;
    if(i < 3){
    try {
            XBeeAddress64 addr64 = new XBeeAddress64(0, 0x13, 0xa2, 0, 0x40, 0xe8, 0xe7, 0x55); //obj 1
            int[] payload = new int[] { 0 };
            ZNetTxRequest tx = new ZNetTxRequest(addr64, payload);
            ZNetTxStatusResponse status = (ZNetTxStatusResponse) xbee.sendSynchronous(tx);
            if (status.isSuccess()) {
              println(0);
              }
            } //try
       catch (Exception e) {
            e.printStackTrace();
            System.exit(-1);
            } 
    }
  }
  
  void sendingData3(){ // control value
    int i = 0;
    i += 1;
    if(i < 3){
    try {
            XBeeAddress64 addr64 = new XBeeAddress64(0, 0x13, 0xa2, 0, 0x40, 0xe8, 0xe7, 0x55); //obj 1
            int[] payload = new int[] { conDition };
            ZNetTxRequest tx = new ZNetTxRequest(addr64, payload);
            ZNetTxStatusResponse status = (ZNetTxStatusResponse) xbee.sendSynchronous(tx);
            } //try
       catch (Exception e) {
            e.printStackTrace();
            System.exit(-1);
            } 
    }
  }
  
    void sendingData4(){ // game level
    int i = 0;
    i += 1;
    if(i < 3){
    try {
            XBeeAddress64 addr64 = new XBeeAddress64(0, 0x13, 0xa2, 0, 0x40, 0xe8, 0xe7, 0x55); //obj 1
            int[] payload = new int[] { 'g' };
            ZNetTxRequest tx = new ZNetTxRequest(addr64, payload);
            ZNetTxStatusResponse status = (ZNetTxStatusResponse) xbee.sendSynchronous(tx);
            } //try
       catch (Exception e) {
            e.printStackTrace();
            System.exit(-1);
            } 
    }
  }
    void sendingData5(){ // initialization value
    int i = 0;
    i += 1;
    if(i < 3){
    try {
            XBeeAddress64 addr64 = new XBeeAddress64(0, 0x13, 0xa2, 0, 0x40, 0xe8, 0xe7, 0x55); //obj 1
            int[] payload = new int[] { 9 };
            ZNetTxRequest tx = new ZNetTxRequest(addr64, payload);
            ZNetTxStatusResponse status = (ZNetTxStatusResponse) xbee.sendSynchronous(tx);
            } //try
       catch (Exception e) {
            e.printStackTrace();
            System.exit(-1);
            } 
    }
  }
  void sendingData6(){ // initialization value
    int i = 0;
    i += 1;
    if(i < 3){
    try {
            XBeeAddress64 addr64 = new XBeeAddress64(0, 0x13, 0xa2, 0, 0x40, 0xe8, 0xe7, 0x55); //obj 1
            //XBeeAddress64 addr64 = new XBeeAddress64(0, 0x13, 0xa2, 0, 0x40, 0x76, 0x33, 0xd4); //obj 2
            //XBeeAddress64 addr64 = new XBeeAddress64(0, 0x13, 0xa2, 0, 0x40, 0xe8, 0xe7, 0x65); //obj 3
            
            //XBeeAddress64 addr64 = new XBeeAddress64(0, 0x13, 0xa2, 0, 0x40, 0xe8, 0xe7, 0x67); //obj 4
            //XBeeAddress64 addr64 = new XBeeAddress64(0, 0x13, 0xa2, 0, 0x40, 0x8b, 0x49, 0x28); //obj 5
            //XBeeAddress64 addr64 = new XBeeAddress64(0, 0x13, 0xa2, 0, 0x40, 0xe8, 0xe2, 0x8c); //obj 6
            int[] payload = new int[] { 10 };
            ZNetTxRequest tx = new ZNetTxRequest(addr64, payload);
            ZNetTxStatusResponse status = (ZNetTxStatusResponse) xbee.sendSynchronous(tx);
            } //try
       catch (Exception e) {
            e.printStackTrace();
            System.exit(-1);
            } 
    }
  }
  
}
  
