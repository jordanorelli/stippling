class Particle {
  PVector origin;
  PVector forces;
  PVector velocity;
  float mass;

  Particle(float x, float y) {
    this.origin = new PVector(x, y);
    this.mass = 1.0;
    this.velocity = new PVector(0, 0);
  }

  void plan(PVector force) {
    this.velocity.mult(0.9);
    force.div(this.mass);
    this.velocity.add(force);
  }

  void move() {
    this.origin.add(this.velocity);
    if (this.outOfBounds()) {
      return;
    }
    int x = floor(map(this.origin.x, 0, width, 0, img.width));
    int y = floor(map(this.origin.y, 0, height, 0, img.height));
    color c = img.pixels[y * img.width + x];
    float targetMass = CELL_SIZE * norm(brightness(c), 256, 0);
    if (targetMass > this.mass) {
      this.mass = min(this.mass * 1.1, targetMass);
    } 
    else {
      this.mass = max(this.mass * 0.9, targetMass);
    }
  }

  boolean outOfBounds() {
    if (this.origin.x < 0 || this.origin.x >= width) {
      return true;
    }
    if (this.origin.y < 0 || this.origin.y >= height) {
      return true;
    }
    return false;
  }

  void draw() {
    noStroke();
    fill(64);
    float n = norm(this.mass, 0, CELL_SIZE);
    float r = CELL_SIZE * n * n;
    ellipse(this.origin.x, this.origin.y, r, r);
  }
}

