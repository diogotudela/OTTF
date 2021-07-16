PImage img;
color[][] colorMatrix;
PrintWriter binary;
img = loadImage("vnd500.jpg");
img.loadPixels();
colorMatrix = new color[img.width][img.height];
binary = createWriter("binary.txt"); 
for (int x=0; x<=img.width-1; x++) {
  for (int y=0; y<=img.height-1; y++) {
    colorMatrix[x][y] = img.pixels[(y*img.width)+x];
    String red = binary(int(red(colorMatrix[x][y])), 8);
    String green = binary(int(green(colorMatrix[x][y])), 8);
    String blue = binary(int(blue(colorMatrix[x][y])), 8);
    binary.print(red+green+blue);
  }
}
binary.flush();
binary.close();
exit();
