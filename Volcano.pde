class Volcano implements Firework {
  PVector location;
  float particleColor;
  float remainingLifespan;
  float particleVelocity;
  float horizontalSpread;
  float particleLifespan;
  float particleAirResistance;
  ArrayList<Particle> particles;
  
  Volcano(PVector aLocation) {
    this.location = new PVector(aLocation.x, aLocation.y, 0.1);
    this.particleColor = random(255);
    this.remainingLifespan = random(200, 400);
    this.particleVelocity = random(10, 15);
    this.horizontalSpread = random(0.5,2);
    this.particleLifespan = random(100, 140);
    this.particleAirResistance = random(0.02, 0.08);
    this.particles = new ArrayList<Particle>();
  }
  
  void doOneCycle() {
    update();
    display();
    remainingLifespan--;
  }
  
  void update() {
    if(this.remainingLifespan > 0) {
      emitParticle();
      emitParticle();
      emitParticle();
    }
    // even though the lifespan of the volcano has been ended, it's particles still may be active
    for (int i = this.particles.size()-1; i >= 0; i--) {
      Particle particle = this.particles.get(i);
      if (particle.isDead()) {
        this.particles.remove(i);
      }
      particle.doOneCycle();
    }
  }

  // Method to display
  void display() {
    if(this.remainingLifespan <= 0) {
      return;
    }
  }

  void emitParticle() {
    this.particles.add(new Particle(
      this.location.copy(),
      new PVector(
        random(-this.horizontalSpread,this.horizontalSpread),
        random(-this.horizontalSpread,this.horizontalSpread),
        random(this.particleVelocity*0.9, this.particleVelocity*1.1)),
      this.particleColor,
      random(particleLifespan * 0.8, particleLifespan * 1.2), random(particleAirResistance*0.9, particleAirResistance*1.1)));
  }
  
  boolean isDead() {
    return this.remainingLifespan <= 0 && this.particles.isEmpty();
  }
}
