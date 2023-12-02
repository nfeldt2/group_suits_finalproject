class Particle {
  PVector pos;
  PVector vel;
  float r;
  boolean isAlive;
  
  Particle(float x, float y, float vx, float vy, float r) {
    pos = new PVector(x, y);
    vel = new PVector(vx, vy);
    this.r = r;
    isAlive = true;
  }
  
  void applyForces(float fx, float fy) {
    vel.x += fx;
    vel.y += fy;
    pos.x += vel.x;
    pos.y += vel.y;
  }
  
  void display() {
    if (isAlive) {
      ellipse(pos.x, pos.y, r, r);   
    }    
  }
  
  void killParticle() {
    isAlive = false; 
  }
  
  boolean outsideScreen() {
    if((pos.x < 0 || pos.x > width) || (pos.y < 0 || pos.y > height)) {
      return true;
    } else {
      return false; 
    }
  }
}
