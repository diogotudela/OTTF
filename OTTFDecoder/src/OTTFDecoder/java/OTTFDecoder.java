import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import drop.*; 
import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class OTTFDecoder extends PApplet {


SDrop drop;

ControlP5 cp5;
RadioButton r1;

String[] raw;
String rawString;
char[] bitString;
int bitBlock = 8;
int availableBits;
int availableBlocks;
ArrayList colorMatrix;
int purple = 0xff605aff;
int margin = 10;
int colorOrder = 0;
PImage img;
boolean adjust = false;
int w = PApplet.parseInt(random(1, 500));
int h = PApplet.parseInt(random(1, 500));

public void setup() {
  
  background(purple);
  
  drop = new SDrop(this);
  bttn(); 
  imageMode(CENTER);
  colorMatrix = new ArrayList();
}

public void draw() {
  background(purple);
  textAlign(CENTER, CENTER);
  fill(255);
  if (img==null)text("DROP TEXT FILE HERE", width/2, 300);
  if (img!=null)show();
}





public void show() {
  pushMatrix();
  translate(width/2, 300);
  rotate(HALF_PI);
  image(img, 0, 0);
  popMatrix();
}


public void decode() {
  for (int i=0; i<colorMatrix.size(); i++) {
    int thisColor = (int)colorMatrix.get(i);
    if (i<img.pixels.length)img.pixels[i] = thisColor;
  }
  img.updatePixels();
}

public void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(r1)) {
    colorOrder = PApplet.parseInt(theEvent.getValue());
    if (adjust)retry();
  }
}


public void WIDTH(float wval) {
  w = PApplet.parseInt(wval);
  if (adjust)retry();
}

public void HEIGHT(float hval) {
  h = PApplet.parseInt(hval);
  if (adjust)retry();
}


public void keyPressed() {
  if(key=='s' || key=='S')img.save("render/file_"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".bmp");
}

public void bttn() {
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
public void dropEvent(DropEvent theDropEvent) {
  if (theDropEvent.isFile()) {
    raw = loadStrings(theDropEvent.file()+"");
    rawString = "";
    for (int i=0; i<raw.length; i++) {
      rawString+=raw[i];
    }
    bitString = rawString.toCharArray();
    availableBits = bitString.length-1;
    availableBlocks = PApplet.parseInt(PApplet.parseFloat(availableBits)/PApplet.parseFloat(bitBlock*3));
    if (colorMatrix.size()!=0)colorMatrix.clear();
    img = createImage(h, w, RGB);
    img.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      img.pixels[i] = color(purple);
    }
    img.updatePixels();


    for (int i=0; i<availableBits; i+=(bitBlock*3)) {
      int chan = 0;
      int[] block = new int[3];
      for (int j=0; j<(bitBlock*3); j+=bitBlock) {
        String getByt = "";
        for (int k=0; k<bitBlock; k++) {
          getByt+=bitString[i+j+k];
        }
        block[chan] = unbinary(getByt);
        chan++;
      }


      if (colorOrder==1) {
        colorMode(RGB);
        colorMatrix.add(color(block[0], block[1], block[2]));
      }
      if (colorOrder==2) {
        colorMode(RGB);
        colorMatrix.add(color(block[0], block[2], block[1]));
      }
      if (colorOrder==3) {
        colorMode(RGB);
        colorMatrix.add(color(block[1], block[0], block[2]));
      }
      if (colorOrder==4) {
        colorMode(RGB);
        colorMatrix.add(color(block[1], block[2], block[0]));
      }
      if (colorOrder==5) {
        colorMode(RGB);
        colorMatrix.add(color(block[2], block[0], block[1]));
      }
      if (colorOrder==6) {
        colorMode(RGB);
        colorMatrix.add(color(block[2], block[1], block[0]));
      }
      if (colorOrder==7) {
        colorMode(HSB);
        colorMatrix.add(color(block[0], block[1], block[2]));
      }
      if (colorOrder==8) {
        colorMode(HSB);
        colorMatrix.add(color(block[0], block[2], block[1]));
      }
      if (colorOrder==9) {
        colorMode(HSB);
        colorMatrix.add(color(block[2], block[0], block[1]));
      }
      if (colorOrder==10) {
        colorMode(HSB);
        colorMatrix.add(color(block[2], block[1], block[0]));
      }
      if (colorOrder==11) {
        colorMode(HSB);
        colorMatrix.add(color(block[1], block[0], block[2]));
      }
      if (colorOrder==12) {
        colorMode(HSB);
        colorMatrix.add(color(block[1], block[2], block[0]));
      }
    }
  }
  adjust = true;
  decode();
}


public void retry() {
  if (colorMatrix.size()!=0)colorMatrix.clear();
  img = createImage(h, w, RGB);
  img.loadPixels();
  for (int i=0; i<img.pixels.length; i++) {
    img.pixels[i] = color(purple);
  }
  img.updatePixels();


  for (int i=0; i<availableBits; i+=(bitBlock*3)) {
    int chan = 0;
    int[] block = new int[3];
    for (int j=0; j<(bitBlock*3); j+=bitBlock) {
      String getByt = "";
      for (int k=0; k<bitBlock; k++) {
        getByt+=bitString[i+j+k];
      }
      block[chan] = unbinary(getByt);
      chan++;
    }


    if (colorOrder==1) {
      colorMode(RGB);
      colorMatrix.add(color(block[0], block[1], block[2]));
    }
    if (colorOrder==2) {
      colorMode(RGB);
      colorMatrix.add(color(block[0], block[2], block[1]));
    }
    if (colorOrder==3) {
      colorMode(RGB);
      colorMatrix.add(color(block[1], block[0], block[2]));
    }
    if (colorOrder==4) {
      colorMode(RGB);
      colorMatrix.add(color(block[1], block[2], block[0]));
    }
    if (colorOrder==5) {
      colorMode(RGB);
      colorMatrix.add(color(block[2], block[0], block[1]));
    }
    if (colorOrder==6) {
      colorMode(RGB);
      colorMatrix.add(color(block[2], block[1], block[0]));
    }
    if (colorOrder==7) {
      colorMode(HSB);
      colorMatrix.add(color(block[0], block[1], block[2]));
    }
    if (colorOrder==8) {
      colorMode(HSB);
      colorMatrix.add(color(block[0], block[2], block[1]));
    }
    if (colorOrder==9) {
      colorMode(HSB);
      colorMatrix.add(color(block[2], block[0], block[1]));
    }
    if (colorOrder==10) {
      colorMode(HSB);
      colorMatrix.add(color(block[2], block[1], block[0]));
    }
    if (colorOrder==11) {
      colorMode(HSB);
      colorMatrix.add(color(block[1], block[0], block[2]));
    }
    if (colorOrder==12) {
      colorMode(HSB);
      colorMatrix.add(color(block[1], block[2], block[0]));
    }
  }
  decode();
}
  public void settings() {  size(600, 660);  smooth(32); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "OTTFDecoder" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
