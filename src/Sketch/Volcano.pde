class Volcano implements Firework {
  Vec3D location;
  float particleColor;
  float remainingLifespan;
  float totalLifespan;
  float distanceFromViewer;
  ParticleGenerator particleGenerator;
  AudioPlayer permanentSound;
  
  Volcano(Vec3D aLocation) {
    this.location = new Vec3D(aLocation.x, aLocation.y, 0.1);
    this.particleColor = random(255);
    this.totalLifespan = random(600, 800);
    this.remainingLifespan = this.totalLifespan;
    float duration = random(50, 110);
    particleGenerator = new ParticleGenerator(location, new Vec3D(0, 0, random(10, 15)))
      .directionJitter(random(1, 2.5))
      .hue(particleColor)
      .duration(duration)
      .durationJitter(duration)
      .airResistance(random(0.02, 0.08))
      .airResistanceJitter(0.002)
      .averageSmokeDuration(200);
    distanceFromViewer = playground.distanceFactorFromViewer(this.location);
    permanentSound = assets.randomVolcanoSound();
    permanentSound.skip(500);
    permanentSound.setGain(map(distanceFromViewer, 0, 1, 0, -30));
    permanentSound.play();
  }
  
  void physics() {
    if(this.remainingLifespan > 0) {
      particleGenerator.emitParticles(3);
    }
    particleGenerator.physics();
    if(this.remainingLifespan <= 20 && this.remainingLifespan >= 0) {
      permanentSound.setGain(map(distanceFromViewer, 0, 1, 0, -30) + map(remainingLifespan, 20, 0, 0, -20));
    }
    if(remainingLifespan < 0) {
      permanentSound.pause();
    }
    remainingLifespan--;
  }

  void render() {
    particleGenerator.render();
    if(this.remainingLifespan <= 0) {
      return;
    }
    pushMatrix();
    noStroke();
    translate(location.x, location.y, 5);
    fill(particleColor, 100, 80, map(remainingLifespan, totalLifespan, 0, 255, 0));
    box(3, 3, 10);
    popMatrix();
  }
  
  boolean isDead() {
    return this.remainingLifespan <= 0 && this.particleGenerator.isDead();
  }
  
  void destroy() {
    permanentSound.close();
  }

  long particleCount() {
    return this.particleGenerator.particleCount();
  }
}
