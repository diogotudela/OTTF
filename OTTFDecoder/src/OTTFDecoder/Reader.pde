void dropEvent(DropEvent theDropEvent) {
  if (theDropEvent.isFile()) {
    raw = loadStrings(theDropEvent.file()+"");
    rawString = "";
    for (int i=0; i<raw.length; i++) {
      rawString+=raw[i];
    }
    bitString = rawString.toCharArray();
    availableBits = bitString.length-1;
    availableBlocks = int(float(availableBits)/float(bitBlock*3));
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


void retry() {
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
