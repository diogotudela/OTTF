String[] raw;
String rawString;
char[] bitString;


int bitBlock = 8;

int availableBits;
int availableBlocks;
ArrayList colorMatrix;

void setup() {
  size(500, 300);
  background(0);
  raw = loadStrings("v.txt");
  rawString = "";
  for (int i=0; i<raw.length; i++) {
    rawString+=raw[i];
  }
  bitString = rawString.toCharArray();
  availableBits = bitString.length-1;
  availableBlocks = int(float(availableBits)/float(bitBlock*3));
  colorMatrix = new ArrayList();
  colorMode(HSB);
}

void draw() {
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
    colorMatrix.add(color(block[0], block[1], block[2]));
  }

  int x=0;
  int y = 0;
  for (int i=0; i<colorMatrix.size(); i++) {
    color thisColor = (color)colorMatrix.get(i);
    stroke(thisColor);
    point(x,y);
    y++;
    if (y>=height) {
      y=0;
      x++;
    }
  }

  noLoop();
}
