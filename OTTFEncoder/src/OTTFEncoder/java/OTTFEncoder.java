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

public class OTTFEncoder extends PApplet {


SDrop drop;

ControlP5 cp5;
RadioButton r1;
PrintWriter binary;
PImage img, back, container;
int[][] colorMatrix;
int camRot;
int margin = 10;
float imgWidth, imgHeight, imgAreaWidth, imgAreaHeight;
float ratio = 0;
int run=0;
int purple = 0xff605aff;
int colorOrder = 0;
boolean encode = false;
String displayBinary = "";

public void setup() {
  
  background(purple);
  
  drop = new SDrop(this);
  bttn();   
  imageMode(CENTER);
}

public void bttn(){
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

public void draw() {
  background(purple);
  textAlign(CENTER,CENTER);
  text("DROP IMAGE FILE HERE",width/2,300);
  if (img!=null && back!=null)core();
}

public void core() {
  imgPreview();
  if(encode && colorOrder!=0)imgBuild();
}


public void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(r1)) {
    colorOrder = PApplet.parseInt(theEvent.getValue());
  }
}

public void keyPressed(){
  if(key=='e' || key=='E'){
    encode=true;
    run = 0;
  }
}
public void imgBuild() {
  noStroke();
  fill(255);
  textAlign(LEFT, BOTTOM);
  text(displayBinary, margin, height-margin);
  for (int i=0; i<run; i++) {
    container.pixels[i] = color(img.pixels[i]);
    String red = binary(PApplet.parseInt(red(container.pixels[i])), 8);
    String green = binary(PApplet.parseInt(green(container.pixels[i])), 8);
    String blue = binary(PApplet.parseInt(blue(container.pixels[i])), 8);
    String hue = binary(PApplet.parseInt(hue(container.pixels[i])), 8);
    String sat = binary(PApplet.parseInt(saturation(container.pixels[i])), 8);
    String bri = binary(PApplet.parseInt(brightness(container.pixels[i])), 8);
    displayBinary=("Pixel #"+i+": "+red+" "+green+" "+blue);


    if (colorOrder==1)displayBinary=("Pixel #"+i+": "+red+" "+green+" "+blue);
    if (colorOrder==2)displayBinary=("Pixel #"+i+": "+red+" "+blue+" "+green);
    if (colorOrder==3)displayBinary=("Pixel #"+i+": "+green+" "+red+" "+blue);
    if (colorOrder==4)displayBinary=("Pixel #"+i+": "+green+" "+blue+" "+red);
    if (colorOrder==5)displayBinary=("Pixel #"+i+": "+blue+" "+red+" "+green);
    if (colorOrder==6)displayBinary=("Pixel #"+i+": "+blue+" "+green+" "+red);
    if (colorOrder==7)displayBinary=("Pixel #"+i+": "+hue+" "+sat+" "+bri);
    if (colorOrder==8)displayBinary=("Pixel #"+i+": "+hue+" "+bri+" "+sat);
    if (colorOrder==9)displayBinary=("Pixel #"+i+": "+bri+" "+hue+" "+sat);
    if (colorOrder==10)displayBinary=("Pixel #"+i+": "+bri+" "+sat+" "+hue);
    if (colorOrder==11)displayBinary=("Pixel #"+i+": "+sat+" "+hue+" "+bri);
    if (colorOrder==12)displayBinary=("Pixel #"+i+": "+sat+" "+bri+" "+hue);
  }
  container.updatePixels();
  int renderJump = 200;
  run+=renderJump;
  if (run>container.pixels.length-(renderJump)) {
    run = container.pixels.length;
    export();
  }
  image(container, width/2, 300, imgWidth, imgHeight);
}


public void export() {
  binary = createWriter("binaryFile/file_"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".txt"); 
  for (int x=0; x<=img.width-1; x++) {
    for (int y=0; y<=img.height-1; y++) {
      colorMatrix[x][y] = img.pixels[(y*img.width)+x];
      String red = binary(PApplet.parseInt(red(colorMatrix[x][y])), 8);
      String green = binary(PApplet.parseInt(green(colorMatrix[x][y])), 8);
      String blue = binary(PApplet.parseInt(blue(colorMatrix[x][y])), 8);
      String hue = binary(PApplet.parseInt(hue(colorMatrix[x][y])), 8);
      String sat = binary(PApplet.parseInt(saturation(colorMatrix[x][y])), 8);
      String bri = binary(PApplet.parseInt(brightness(colorMatrix[x][y])), 8);
      if (colorOrder==1)binary.print(red+green+blue);
      if (colorOrder==2)binary.print(red+blue+green);
      if (colorOrder==3)binary.print(green+red+blue);
      if (colorOrder==4)binary.print(green+blue+red);
      if (colorOrder==5)binary.print(blue+red+green);
      if (colorOrder==6)binary.print(blue+green+red);
      if (colorOrder==7)binary.print(hue+sat+bri);
      if (colorOrder==8)binary.print(hue+bri+sat);
      if (colorOrder==9)binary.print(bri+hue+sat);
      if (colorOrder==10)binary.print(bri+sat+hue);
      if (colorOrder==11)binary.print(sat+hue+bri);
      if (colorOrder==12)binary.print(sat+bri+hue);
    }
  }
  binary.flush();
  binary.close();
  encode = false;
  for (int i=0; i<container.pixels.length; i++) {
      container.pixels[i] = color(purple, 0);
    }
}


public void imgPreview() {
  back.filter(GRAY);
  tint(purple);
  image(back, width/2, 300, imgWidth, imgHeight);
  tint(255, 255);
}

public void dropEvent(DropEvent theDropEvent) {
  displayBinary = "";
  ratio = 0;
  img = null;
  imgWidth = 0;
  imgHeight = 0;
  imgAreaWidth = 600-(2*margin); //<---- W
  imgAreaHeight = 600-(2*margin); //<---- H
  if (theDropEvent.isFile()) {
    img = loadImage(theDropEvent.file()+"");
    back = loadImage(theDropEvent.file()+"");
    build();
    reSize();
    container = createImage(img.width, img.height, ARGB);
    container.loadPixels();
    for (int i=0; i<container.pixels.length; i++) {
      container.pixels[i] = color(purple, 0);
    }
  }
}


public void build() {
  img.loadPixels();
  colorMatrix = new int[img.width][img.height];
  for (int x=0; x<img.width; x++) {
    for (int y=0; y<img.height; y++) {
      colorMatrix[x][y] = img.pixels[(y*img.width)+x];
    }
  }
}


public void reSize() {
  if (img.width>=img.height) {
    imgWidth = imgAreaWidth;
    imgHeight = img.height*(imgWidth/img.width);
    ratio = (imgWidth/img.width);
  } else if (img.height>img.width) {
    imgHeight = imgAreaHeight;
    imgWidth = img.width*(imgHeight/img.height);
    ratio = (imgHeight/img.height);
  }
}
  public void settings() {  size(600, 660);  smooth(32); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "OTTFEncoder" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
