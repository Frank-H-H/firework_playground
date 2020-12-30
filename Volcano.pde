class Volcano implements Firework {
  Vec3D location;
  float particleColor;
  float remainingLifespan;
  float totalLifespan;
  float distanceFromViewer;
  ParticleGenerator particleGenerator;
  SoundFile sound;
  
  Volcano(Vec3D aLocation) {
    this.location = new Vec3D(aLocation.x, aLocation.y, 0.1);
    this.particleColor = random(255);
    this.totalLifespan = random(600, 800);
    this.remainingLifespan = this.totalLifespan;
    particleGenerator = new ParticleGenerator(location, new Vec3D(0, 0, random(10, 15)))
      .directionJitter(random(1, 2.5))
      .hue(particleColor)
      .duration(random(50, 110))
      .durationJitter(50)
      .airResistance(random(0.02, 0.08))
      .airResistanceJitter(0.002)
      .averageSmokeDuration(200);
    distanceFromViewer = playground.distanceFactorFromViewer(this.location);
    sound = assets.randomVolcanoSound();
    sound.amp(map(distanceFromViewer,0,1,0.6,0.02));
    sound.play();
  }
  
  void physics() {
    if(this.remainingLifespan > 0) {
      particleGenerator.emitParticles(3);
    }
    particleGenerator.physics();
    if(this.remainingLifespan <= 10 && this.remainingLifespan >= 0) {
      sound.amp(map(distanceFromViewer,0,1,0.6,0.02) * remainingLifespan / 10);
    }
    if(remainingLifespan < 0) {
      sound.stop();
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
}
