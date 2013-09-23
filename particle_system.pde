public class ParticleSystem {
  Cell[][] cells;
  PImage img;
  int cellWidth;
  int cellHeight;
  
  ParticleSystem(PApplet app, PImage img) {
    this.cellWidth = width / (int)CELL_SIZE;
    this.cellHeight = height / (int)CELL_SIZE;
    this.img = img;    
    this.cells = new Cell[this.cellWidth][this.cellHeight];

    for (int x = 0; x < this.cellWidth; x++) {
      for (int y = 0; y < this.cellHeight; y++) {
        this.cells[x][y] = new Cell(this, x, y);
      }
    }

    for (int x = 0; x < this.cellWidth; x++) {
      for (int y = 0; y < this.cellHeight; y++) {
        this.cells[x][y].neighbors = this.neighbors(x, y);
      }
    }    
  }
  
  public void plan() {
    for (Cell[] row : this.cells) {
      for (Cell cell : row) {
        cell.plan();
      }
    }
  }
  
  public void move() {
    for (Cell[] row : this.cells) {
      for (Cell cell : row) {
        cell.move();
      }
    }
  }
  
  public void draw() {
    for (Cell[] row : this.cells) {
      for (Cell cell : row) {
        cell.draw();
      }
    }
  }
    
  void add(float x, float y) {
    Particle p = new Particle(x, y);
    this.place(p);
  }
  
  void place(Particle p) {
    int cell_x = floor(p.origin.x / CELL_SIZE);
    int cell_y = floor(p.origin.y / CELL_SIZE);
    if (cell_x < 0 || cell_x >= this.cellWidth) {
      return;
    }
    if (cell_y < 0 || cell_y >= this.cellHeight) {
      return;
    }
    Cell cell = this.cells[cell_x][cell_y];
    cell.add(p);
  }
  
  Cell[] neighbors(int x, int y) {
    Cell[] cells = {
      this.getCell(x-1, y-1),
      this.getCell(x  , y-1),
      this.getCell(x+1, y-1),
      this.getCell(x-1, y  ),
      this.getCell(x+1, y  ),
      this.getCell(x-1, y+1),
      this.getCell(x  , y+1),
      this.getCell(x+1, y+1)
    };
    return cells;
  }
  
  Cell getCell(int x, int y) {
    if (x < 0 || x >= this.cellWidth || y < 0 || y >= this.cellWidth) {
      return null;
    }
    return this.cells[x][y];
  }

  color getColor(float x, float y) {
    int _x = floor(map(x, 0, width, 0, this.img.width));
    int _y = floor(map(y, 0, height, 0, this.img.height));
    return this.img.pixels[_y * this.img.width + _x];
  }
}
