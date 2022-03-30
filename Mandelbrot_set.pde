final int DENSITY = 750;
final float ZOOM_MULTIPLIER = 2f;

float rightBound;
float leftBound;
float upBound;
float downBound;

void setup() {
  // Per avere un buon risultato la proporzione deve essere 3/2
  size(900, 600);
  initializeBounds();


  update();
}

void draw() {}

/**
 * Inizializza i limiti degli assi del Mandelbrot set
 */
void initializeBounds() {
  rightBound = 1f;
  leftBound = -2f;
  upBound = 1f;
  downBound = -1f;
}

/**
 * Disegna il Mandelbrot set
 */
void update() {
  background(255);
  drawMandelbrot();
  drawAxis();
  println("updated");
}

/**
 * Calcola se il punto c è in un set o meno
 * @param c il punto da controllare
 * @return il colore da applicare al punto c in questione
 */
int isInSet(Complex c) {
  final int MAX_ITERATIONS = 0xFF;

  Complex z = new Complex(0, 0);
  for (int i = 0; i < MAX_ITERATIONS; i++) {
    z = z.square().add(c);
    if (z.abs() > 2)
      return (int) map(i, MAX_ITERATIONS, 0, 0x0, 0xFF);
  }
  return 0;
}

void drawMandelbrot() {
  strokeWeight(2);
  // Disegno l'insieme di Mandelbrot
  float xStep = (rightBound - leftBound) / DENSITY;
  float yStep = (upBound - downBound) / DENSITY;
  for (float r = leftBound; r < rightBound; r += xStep) {
    for (float im = downBound; im < upBound; im += yStep) {
      Complex c = new Complex(r, im);
      stroke(isInSet(c));
      float x = map(r, leftBound, rightBound, 0, width);
      float y = map(im, upBound, downBound, 0, height);
      point(x, y);
    }
  }
}

void drawAxis() {
  // Disegno gli assi
  final int TEXT_OFF = 10;
  int textPositioning;
  stroke(0);
  fill(255, 0, 0);
  float yZero = map(0, upBound, downBound, 0, height);
  float xZero = map(0, leftBound, rightBound, 0, width);
  // Ascisse
  line(0, yZero, width, yZero);
  // Allineo e disegno le etichette di max e min
  if (yZero < height / 2) {
    textPositioning = 1;
    // textAlign(LEFT, TOP);
    // text(Float.toString(leftBound), TEXT_OFF, yZero + TEXT_OFF * textPositioning);
    // textAlign(RIGHT, TOP);
    // text(Float.toString(rightBound), width - TEXT_OFF, yZero + TEXT_OFF * textPositioning);
  } else {
    textPositioning = -1;
    // textAlign(LEFT, BOTTOM);
    // text(Float.toString(leftBound), TEXT_OFF, yZero + TEXT_OFF * textPositioning);
    // textAlign(RIGHT, BOTTOM);
    // text(Float.toString(rightBound), width - TEXT_OFF, yZero + TEXT_OFF * textPositioning);
  }
  textAlign(LEFT, textPositioning == 1 ? TOP : BOTTOM);
  text(Float.toString(leftBound), TEXT_OFF, yZero + TEXT_OFF * textPositioning);
  textAlign(RIGHT, textPositioning == 1 ? TOP : BOTTOM);
  text(Float.toString(rightBound), width - TEXT_OFF, yZero + TEXT_OFF * textPositioning);
  // Ordinate
  line(xZero, 0, xZero, height);
  if (xZero < width / 2) {
    textPositioning = 1;
    // textAlign(LEFT, TOP);
    // text(Float.toString(upBound), xZero + TEXT_OFF * textPositioning, TEXT_OFF);
    // textAlign(LEFT, BOTTOM);
    // text(Float.toString(downBound), xZero + TEXT_OFF * textPositioning, height - TEXT_OFF);
  } else {
    textPositioning = -1;
    // textAlign(RIGHT, TOP);
    // text(Float.toString(upBound), xZero + TEXT_OFF * textPositioning, TEXT_OFF);
    // textAlign(RIGHT, BOTTOM);
    // text(Float.toString(downBound), xZero + TEXT_OFF * textPositioning, height - TEXT_OFF);
  }
  textAlign(textPositioning == 1 ? LEFT : RIGHT, TOP);
  text(Float.toString(upBound), xZero + TEXT_OFF * textPositioning, TEXT_OFF);
  textAlign(textPositioning == 1 ? LEFT : RIGHT, BOTTOM);
  text(Float.toString(downBound), xZero + TEXT_OFF * textPositioning, height - TEXT_OFF);
}

void mousePressed() {
  switch (mouseButton) {
  case LEFT:
    zoomIn();
    break;
  case RIGHT:
    zoomOut();
    break;
  case CENTER:
    initializeBounds();
    break;
  }
  update();
}

void zoomIn() {
  float x = map(mouseX, 0, width, leftBound, rightBound);
  float y = map(mouseY, 0, height, upBound, downBound);
  float newWidth = (rightBound - leftBound) / ZOOM_MULTIPLIER;
  float newHeight = (upBound - downBound) / ZOOM_MULTIPLIER;

  leftBound = x - newWidth / 2;
  rightBound = x + newWidth / 2;
  upBound = y + newHeight / 2;
  downBound = y - newHeight / 2;
}

void zoomOut() {
  float x = map(mouseX, 0, width, leftBound, rightBound);
  float y = map(mouseY, 0, height, upBound, downBound);
  float newWidth = (rightBound - leftBound) * ZOOM_MULTIPLIER;
  float newHeight = (upBound - downBound) * ZOOM_MULTIPLIER;

  leftBound = x - newWidth / 2;
  rightBound = x + newWidth / 2;
  upBound = y + newHeight / 2;
  downBound = y - newHeight / 2;
}