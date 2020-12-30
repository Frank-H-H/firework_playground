class Volcano implements Firework {
  PVector location;
  float particleColor;
  float remainingLifespan;
  float totalLifespan;
  float distanceFromViewer;
  ParticleGenerator particleGenerator;
  SoundFile sound;
  
  Volcano(PVector aLocation) {
    this.location = new PVector(aLocation.x, aLocation.y, 0.1);
    this.particleColor = random(255);
    this.totalLifespan = random(600, 800);
    this.remainingLifespan = this.totalLifespan;
    particleGenerator = new ParticleGenerator(
      location,
      new PVector(0, 0, random(10, 15)),
      random(1, 2.5),
      particleColor,
      random(60, 110),
      20,
      random(0.02, 0.08),
      0.002
      );
    distanceFromViewer = playground.distanceFactorFromViewer(this.location);
    sound = assets.randomVolcanoSound();
    sound.amp(map(distanceFromViewer,0,1,0.6,0.02));
    sound.play();
  }
  
  void doOneCycle() {
    update();
    display();
    remainingLifespan--;
  }
  
  void update() {
    if(this.remainingLifespan > 0) {
      particleGenerator.emitParticles(3);
    }
    particleGenerator.update();
    if(this.remainingLifespan <= 10 && this.remainingLifespan >= 0) {
      sound.amp(map(distanceFromViewer,0,1,0.6,0.02) * remainingLifespan / 10);
    }
    if(remainingLifespan < 0) {
      sound.stop();
    }
  }

  // Method to display
  void display() {
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
