import drop.*;
SDrop drop;
import controlP5.*;
ControlP5 cp5;
RadioButton r1;

String[] raw;
String rawString;
char[] bitString;
int bitBlock = 8;
int availableBits;
int availableBlocks;
ArrayList colorMatrix;
color purple = #605aff;
int margin = 10;
int colorOrder = 0;
PImage img;
boolean adjust = false;
int w = int(random(1, 500));
int h = int(random(1, 500));

void setup() {
  size(600, 660);
  background(purple);
  smooth(32);
  drop = new SDrop(this);
  bttn(); 
  imageMode(CENTER);
  colorMatrix = new ArrayList();
}

void draw() {
  background(purple);
  textAlign(CENTER, CENTER);
  fill(255);
  if (img==null)text("DROP TEXT FILE HERE", width/2, 300);
  if (img!=null)show();
}





void show() {
  pushMatrix();
  translate(width/2, 300);
  rotate(HALF_PI);
  image(img, 0, 0);
  popMatrix();
}


void decode() {
  for (int i=0; i<colorMatrix.size(); i++) {
    color thisColor = (color)colorMatrix.get(i);
    if (i<img.pixels.length)img.pixels[i] = thisColor;
  }
  img.updatePixels();
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(r1)) {
    colorOrder = int(theEvent.getValue());
    if (adjust)retry();
  }
}


void WIDTH(float wval) {
  w = int(wval);
  if (adjust)retry();
}

void HEIGHT(float hval) {
  h = int(hval);
  if (adjust)retry();
}


void keyPressed() {
  if(key=='s' || key=='S')img.save("render/file_"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".bmp");
}

void bttn() {
  cp5 = new ControlP5(this);
  r1 = cp5.addRadioButton("radioButton")
    .setPosition(margin, 600+margin)
    .setSize(((width)-2*margin)/12, 10)
    .setColorBackground(color(0))
    .setColorForeground(color(255))
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setItemsPerRow(6)
    .setSpacingColumn(((width)-2*margin)/12)
    .addItem("RGB", 1)
    .addItem("RBG", 2)
    .addItem("GRB", 3)
    .addItem("GBR", 4)
    .addItem("BRG", 5)
    .addItem("BGR", 6)
    .addItem("HSB", 7)
    .addItem("HBS", 8)
    .addItem("BHS", 9)
    .addItem("BSH", 10)
    .addItem("SHB", 11)
    .addItem("SBH", 12)
    ;

  cp5.addSlider("WIDTH")
    .setPosition(margin, height-2*margin)
    .setWidth(240)
    .setHeight(margin)
    .setRange(1, 600)
    .setValue(w)
    .setColorBackground(color(purple))
    .setColorForeground(color(0))
    .setColorActive(color(0))
    .setDecimalPrecision(0)
    ;

  cp5.addSlider("HEIGHT")
    .setPosition(width/2, height-2*margin)
    .setWidth(240)
    .setHeight(margin)
    .setRange(1, 600)
    .setValue(w)
    .setColorBackground(color(purple))
    .setColorForeground(color(0))
    .setColorActive(color(0))
    .setDecimalPrecision(0)
    ;
}
