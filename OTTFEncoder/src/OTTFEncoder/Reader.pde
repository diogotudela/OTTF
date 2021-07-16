void imgBuild() {
  noStroke();
  fill(255);
  textAlign(LEFT, BOTTOM);
  text(displayBinary, margin, height-margin);
  for (int i=0; i<run; i++) {
    container.pixels[i] = color(img.pixels[i]);
    String red = binary(int(red(container.pixels[i])), 8);
    String green = binary(int(green(container.pixels[i])), 8);
    String blue = binary(int(blue(container.pixels[i])), 8);
    String hue = binary(int(hue(container.pixels[i])), 8);
    String sat = binary(int(saturation(container.pixels[i])), 8);
    String bri = binary(int(brightness(container.pixels[i])), 8);
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


void export() {
  binary = createWriter("binaryFile/file_"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".txt"); 
  for (int x=0; x<=img.width-1; x++) {
    for (int y=0; y<=img.height-1; y++) {
      colorMatrix[x][y] = img.pixels[(y*img.width)+x];
      String red = binary(int(red(colorMatrix[x][y])), 8);
      String green = binary(int(green(colorMatrix[x][y])), 8);
      String blue = binary(int(blue(colorMatrix[x][y])), 8);
      String hue = binary(int(hue(colorMatrix[x][y])), 8);
      String sat = binary(int(saturation(colorMatrix[x][y])), 8);
      String bri = binary(int(brightness(colorMatrix[x][y])), 8);
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


void imgPreview() {
  back.filter(GRAY);
  tint(purple);
  image(back, width/2, 300, imgWidth, imgHeight);
  tint(255, 255);
}

void dropEvent(DropEvent theDropEvent) {
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


void build() {
  img.loadPixels();
  colorMatrix = new color[img.width][img.height];
  for (int x=0; x<img.width; x++) {
    for (int y=0; y<img.height; y++) {
      colorMatrix[x][y] = img.pixels[(y*img.width)+x];
    }
  }
}


void reSize() {
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
