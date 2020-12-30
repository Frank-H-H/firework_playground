class Bomb implements Firework {
  PVector location;
  PVector velocity;
  float distanceFromViewer;
  float launcherParticleColor;
  ParticleGenerator launcherParticleGenerator;
  Explosion explosion;

  Bomb(PVector aLocation) {
    this.location = new PVector(aLocation.x, aLocation.y, 0.1);
    this.velocity = new PVector(0, 0, random(14,16));
    this.launcherParticleColor = random(255);
    launcherParticleGenerator = new ParticleGenerator(
      location,
      new PVector(0, 0, this.velocity.z * 0.75),
      random(0.3, 1),
      launcherParticleColor,
      random(15, 80),
      5,
      random(0.1, 0.2),
      0.02
      );
    distanceFromViewer = playground.distanceFactorFromViewer(this.location);
    SoundFile startSound = assets.randomBombStartSound();
    startSound.amp(map(distanceFromViewer,0,1,0.6,0.02));
    startSound.play();
    launcherParticleGenerator.emitParticles(200);
  }

  void doOneCycle() {
    this.update();
    this.display();
  }

  void update() {
    if(this.velocity.z <= 0 && explosion == null) {
      this.explode();
    }
    if(this.explosion != null) {
      this.explosion.doOneCycle();
    } else {
      this.velocity.add(gravity);
      this.location.add(this.velocity);
    }
    launcherParticleGenerator.update();
  }

  // Method to display
  void display() {
    // render launcher
    pushMatrix();
    noStroke();
    translate(location.x, location.y, 10);
    fill(launcherParticleColor, 100, 80, 255);
    box(3, 3, 20);
    popMatrix();

    // render bomb itself
    stroke(0, 0, 50, 255);
    strokeWeight(map(distanceFromViewer, 0, 1, 5, 0.1));
    point(location.x, location.y, location.z);
  }
  
  void explode() {
    this.explosion = new Explosion(location);
  }

  boolean isDead() {
    return this.explosion != null && explosion.isDead() && this.launcherParticleGenerator.isDead();
  }
}
