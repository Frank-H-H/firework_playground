class Comet extends Particle implements Firework {
  ParticleGenerator glitterGenerator;

  private Comet(Vec3D aLocation, Vec3D aVelocity, float glitterHue) {
    super(aLocation);
    moving(aVelocity);
    glitterGenerator = new ParticleGenerator(location.copy(), new Vec3D(0, 0, 0))
      .directionJitter(0.1)
      .hue(glitterHue)
      .duration(random(50, 150))
      .durationJitter(10)
      .airResistance(0.1)
      .airResistanceJitter(0)
      .averageSmokeDuration(100);
  }
  
  Comet moving(Vec3D aVelocity) {
    super.moving(aVelocity);
    return this;
  }
  
  Comet hue(float aHue) {
    super.hue(aHue);
    return this;
  }
  
  Comet lifespan(float aLifespan) {
    super.lifespan(aLifespan);
    return this;
  }

  Comet airResistance(float anAirResistanceFactor) {
    super.airResistance(anAirResistanceFactor);
    return this;
  }
  
  Comet smokeDuration(float aSmokeDuration) {
    super.smokeDuration(aSmokeDuration);
    return this;
  }
  
  Comet mass(float aMass) {
    super.mass(aMass);
    return this;
  }
  
  Comet size(float aSize) {
    super.size(aSize);
    return this;
  }
  
  void physics() {
    super.physics();
    glitterGenerator.setLocation(location.copy());
    glitterGenerator.physics();
    if(remainingLifespan >= 0 && random(1) <= 0.1) {
      glitterGenerator.emitParticle();
    }
  }

  void render() {
    super.render();
    glitterGenerator.render();
  }
  
  boolean isDead() {
    return super.isDead() && glitterGenerator.isDead();
  }
  
  void destroy() {
  }
    
  long particleCount() {
    return this.glitterGenerator.particleCount();
  }
}
