/* draw a grid to the screen when the 'g' key is pressed */

boolean gridOn = false;

void setup() {
  size(500, 500);
}

void draw(){
  background(255);
  
  if (gridOn == true) {
    drawGrid();
  }
}

void keyPressed() {
  if (key == 'g') {
    gridOn = !gridOn;
  }
}


// draw my grid
void drawGrid() {
  for (int x=0; x<width; x=x+50) {
    for (int y=0; y<height; y=y+50) {
      stroke(200);
      line(x, 0, x, height); // vertical lines
      line(0, y, width, y); // horizontal lines

      fill(0);
      textSize(9);
      text(x + "," + y, x, y);
    }
  }
}

