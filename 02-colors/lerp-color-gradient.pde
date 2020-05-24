color from = color(140, 0, 255);
color to = color(250, 140, 81);

void setup() {
  size(500, 500);
  noStroke();

  for (int i = 0; i < width; i += 5) {
    for (int j = 0; j < height; j += 5) {
      float p = (float)(i + j) / (width + height);
      color c = lerpColor(from, to, p);
      fill(c);
      rect(i, j, 5, 5);
    }
  }
}
