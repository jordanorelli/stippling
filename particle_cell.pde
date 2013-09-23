class Cell {
  ParticleSystem sys;
  ArrayList<Particle> particles;
  Cell[] neighbors;
  PVector origin;

  Cell(ParticleSystem sys, float x, float y) {
    this.sys = sys;
    this.particles = new ArrayList<Particle>();
    this.origin = new PVector(CELL_SIZE * x, CELL_SIZE * y);
  }
  
  void plan() {
    for (Particle p : this.particles) {
      PVector force = this.repel(p);
      for (Cell cell : this.neighbors) {
        if (cell == null) {
          continue;
        }
        force.add(cell.repel(p));
      }
      force.limit(1.0);
      p.plan(force);
    }
  }
  
  void move() {
    for (int i = this.particles.size() - 1; i >= 0; i--) {
      Particle p = this.particles.get(i);
      p.move();
      if (!this.contains(p.origin.x, p.origin.y)) {
        this.remove(p);
        this.sys.place(p);
      }      
    }
  }

  void draw() {
    for (Particle p : this.particles) {
      p.draw();
    }
    debugDraw();
  }
  
  void debugDraw() {
    if (!DEBUG) {
      return;
    }
    noFill();
    stroke(255, 0, 0);
    strokeWeight(1);
    rect(this.origin.x, this.origin.y, CELL_SIZE, CELL_SIZE);
  }

  void add(Particle p) {
    this.particles.add(p);
  }
  
  void remove(Particle p) {
    this.particles.remove(p);
  }
  
  PVector repel(Particle p) {
    PVector sum = new PVector(0, 0);
    float dist;
    PVector unit;
    for (Particle other : this.particles) {
      if (other == p) {
        continue;
      }
      dist = PVector.dist(p.origin, other.origin);
      if (dist > CELL_SIZE) {
        continue;
      }
      unit = PVector.sub(p.origin, other.origin);
      unit.normalize();
      dist = norm(dist, 0, CELL_SIZE);
      unit.mult((p.mass * other.mass) / (dist * dist));
      sum.add(unit);
    }
    return sum;
  }

  boolean contains(float x, float y) {
    float dx = x - this.origin.x;
    if (dx < 0 || dx > CELL_SIZE) {
      return false;
    }
    float dy = y - this.origin.y;
    if (dy < 0 || dy > CELL_SIZE) {
      return false;
    }
    return true;
  }
}

