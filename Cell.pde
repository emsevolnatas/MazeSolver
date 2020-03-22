class Cell {
  int x, y;
  float centerX, centerY;
  int neighbours;
  Cell[] nwse = new Cell[4];
  boolean done = false;
  Node node;
  
  Cell(int x, int y) {
    this.x = x;
    this.y = y;
    this.centerX = cellsize*x+(cellsize/2);
    this.centerY = cellsize*y+(cellsize/2);
  }
  
  void show() {
    float xval, yval;
    xval = this.centerX-cellsize/2;
    yval = this.centerY-cellsize/2;
    fill(255);
    strokeWeight(0);
    square(xval,yval,cellsize);
  }
  
  
}
