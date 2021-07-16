import processing.serial.*;
Serial myPort;
String incoming = null;
int ln = 10;
String bit;
String block = "";
ArrayList binaryCode;
void setup() {
  size(200, 200);
  background(0);
  println(Serial.list());
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);
  binaryCode = new ArrayList();
  noStroke();
}

void draw() {
  readArduino();
  readCode();
}

void readCode() {
  if (binaryCode.size()%3==0 && binaryCode.size()!=0) {
    int i=0;
    for (int x=0; x<width; x++) {
      for (int y=0; y<height; y++) {
        if (i<binaryCode.size()) {
          int r = (int)binaryCode.get(i);
          int g = (int)binaryCode.get(i+1);
          int b = (int)binaryCode.get(i+2);
          fill(r,g,b);
          rect(x*5,y*5,5,5);
        }
        i+=3;
      }
    }
  }
}


void readArduino() {
  while (myPort.available()>0) {  
    incoming = myPort.readStringUntil(ln);
    if (incoming!=null) {
      bit = str(int(float(incoming)));
      println(block);
      block+=bit;
      if (block.length()>=8) {
        println("EQUALS: "+int(unbinary(block)));
        binaryCode.add(int(unbinary(block)));
        block="";
      }
    }
  }
}
