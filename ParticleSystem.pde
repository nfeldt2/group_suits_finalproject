class ParticleSystem {
  int numParticles;
  PVector systemOrigin;
  Particle[] particles;
  
  ParticleSystem(float x, float y, int numP) {
    numParticles = numP;
    systemOrigin = new PVector(x, y);
    
    particles = new Particle[numParticles];
    
    for(int i = 0; i < particles.length; i++) {
      Particle p = new Particle(systemOrigin.x, systemOrigin.y,
                                random(-1, 1),
                                random(-1, 1),
                                int(random(5, 10)));
      particles[i] = p;
    }
  }
  
  void show() {
    for(int i = 0; i < particles.length; i++) {
      particles[i].applyForces(0, 0);
      particles[i].display();
      if(particles[i].outsideScreen()) {
        particles[i].pos.x = systemOrigin.x;
        particles[i].pos.y = systemOrigin.y;
        particles[i].vel.x = random(-1, 1);
        particles[i].vel.y = random(-1, 1);
      }
    }
  }
  
  void killSystem() {
    for(Particle p : particles) {
      p.killParticle();
    }
  }
  
  void updateOrigin(float x, float y) {
    systemOrigin.x = x;
    systemOrigin.y = y;
  }
}
