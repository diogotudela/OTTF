import drop.*;
SDrop drop;
import controlP5.*;
ControlP5 cp5;
RadioButton r1;
PrintWriter binary;
PImage img, back, container;
color[][] colorMatrix;
int camRot;
int margin = 10;
float imgWidth, imgHeight, imgAreaWidth, imgAreaHeight;
float ratio = 0;
int run=0;
color purple = #605aff;
int colorOrder = 0;
boolean encode = false;
String displayBinary = "";

void setup() {
  size(600, 660);
  background(purple);
  smooth(32);
  drop = new SDrop(this);
  bttn();   
  imageMode(CENTER);
}

void bttn(){
  cp5 = new ControlP5(this);
  r1 = cp5.addRadioButton("radioButton")
         .setPosition(margin,600+margin)
         .setSize(((width)-2*margin)/12,10)
         .setColorBackground(color(0))
         .setColorForeground(color(255))
         .setColorActive(color(255))
         .setColorLabel(color(255))
         .setItemsPerRow(6)
         .setSpacingColumn(((width)-2*margin)/12)
         .addItem("RGB",1)
         .addItem("RBG",2)
         .addItem("GRB",3)
         .addItem("GBR",4)
         .addItem("BRG",5)
         .addItem("BGR",6)
         .addItem("HSB",7)
         .addItem("HBS",8)
         .addItem("BHS",9)
         .addItem("BSH",10)
         .addItem("SHB",11)
         .addItem("SBH",12)
         ;
}

void draw() {
  background(purple);
  textAlign(CENTER,CENTER);
  text("DROP IMAGE FILE HERE",width/2,300);
  if (img!=null && back!=null)core();
}

void core() {
  imgPreview();
  if(encode && colorOrder!=0)imgBuild();
}


void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(r1)) {
    colorOrder = int(theEvent.getValue());
  }
}

void keyPressed(){
  if(key=='e' || key=='E'){
    encode=true;
    run = 0;
  }
}
