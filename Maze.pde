class Maze {
  int[][] bitmap;
  Cell[][] cellmap;
  Cell entry, exit;
  ArrayList<Cell> alCell = new ArrayList<Cell>();
  
  Maze(String filename) {
    this.loadBitmapFromImage(filename);
    this.createCells();
    this.linkCells();
  }
  
  void createCells() {
    cellmap = new Cell[bitmap.length][bitmap[0].length];
    //Entry Node
    for (int i = 0; i < bitmap.length; i++)
      if (bitmap[0][i] == 1) {
        Cell c = new Cell(i, 0);
        if (bitmap[1][i] == 1) c.neighbours += 4;
        cellmap[0][i] = c;
        entry = c;
      }
      
    alCell.add(entry);
    
    // Other Nodes
    for (int i = 1; i < bitmap.length - 1; i++)
      for (int j = 1; j < bitmap[i].length - 1; j++)
        if (bitmap[i][j] == 1) {
          Cell c = new Cell(j, i);
          if (bitmap[i - 1][j] == 1) c.neighbours += 1;
          if (bitmap[i][j - 1] == 1) c.neighbours += 2;
          if (bitmap[i + 1][j] == 1) c.neighbours += 4;
          if (bitmap[i][j + 1] == 1) c.neighbours += 8;
          cellmap[i][j] = c;
          alCell.add(c);
        }
               
      // Exit Node
      for (int i = 0; i < bitmap.length; i++)
        if (bitmap[bitmap.length - 1][i] == 1) {
          Cell c = new Cell(i, bitmap.length - 1);
          if (bitmap[bitmap.length - 2][i] == 1) c.neighbours += 1;
          cellmap[bitmap.length - 1][i] = c;
          exit = c;
        }
        
      alCell.add(exit);

  }
  
  void loadBitmapFromImage(String filename) {
    int counter = 0;
    PImage maze = loadImage(filename);
    maze.loadPixels();
    bitmap = new int[maze.height][maze.width];
    cellsize = 1000.0 / bitmap.length;
    for (int i = 0; i < maze.height; i++)
      for (int j = 0; j < maze.width; j++)
        bitmap[i][j] = maze.pixels[counter++] != -1 ? 0 : 1;
  }
  
  
  void show() {
   for (Cell[] cm : cellmap)
   for (Cell c : cm)
     if(c!=null) c.show();
  }
  
  void linkCells() {
   for (int i = 0; i < cellmap.length; i++)
     for (int j = 0; j < cellmap[i].length; j++)
       if (cellmap[i][j] != null) {
          Cell c = cellmap[i][j];
          if (c.neighbours % 2 == 1) c.nwse[0] = cellmap[i - 1][j];
          if (c.neighbours % 8 >= 4) c.nwse[2] = cellmap[i + 1][j];
          if (c.neighbours % 4 >= 2) c.nwse[1] = cellmap[i][j - 1];
          if (c.neighbours / 8 != 0) c.nwse[3] = cellmap[i][j + 1];
       }
  }
}
