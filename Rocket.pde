class Rocket implements Firework {
  PVector location;
  PVector velocity;
  float thrustHue;
  float thrust;
  float remainingPropellant;
  float remainingTimeUntilExplosion;
  ParticleGenerator thrustParticleGenerator;
  Explosion explosion;

  Rocket(PVector aLocation) {
    this.location = new PVector(aLocation.x, aLocation.y, 0.1);
    this.velocity = new PVector(0, 0, 0);
    this.thrustHue = random(255);
    this.thrust = random(0.23, 0.27);
    this.remainingPropellant = random(100, 120);
    this.remainingTimeUntilExplosion = random(100, 120);
    thrustParticleGenerator = new ParticleGenerator(
      location,
      new PVector(0, 0, thrust * -5),
      random(0.1, 0.3),
      thrustHue,
      random(10, 40),
      6,
      random(0.02, 0.08),
      0.002
      );
    float distanceFactor = playground.distanceFactorFromViewer(this.location);
    SoundFile startSound = assets.randomRocketStartSound();
    startSound.amp(map(distanceFactor,0,1,0.6,0.02));
    startSound.play();
  }

  void doOneCycle() {
    this.update();
    this.display();
    this.remainingPropellant--;
    this.remainingTimeUntilExplosion--;
  }

  void update() {
    if(this.remainingTimeUntilExplosion <= 0 && explosion == null) {
      this.explode();
    }
    if(this.explosion != null) {
      this.explosion.doOneCycle();
    } else {
      if(this.remainingPropellant > 0) {
        this.velocity.add(new PVector(0, 0, thrust));
        thrustParticleGenerator.emitParticles(3);
      }
      this.velocity.add(gravity);
      this.location.add(this.velocity);
    }
    thrustParticleGenerator.update();
  }

  // Method to display
  void display() {
    pushMatrix();
    noStroke();
    translate(location.x, location.y, location.z + 5);
    fill(thrustHue, 100, 80, 255);
    box(3, 3, 10);
    popMatrix();
  }
  
  void explode() {
    this.explosion = new Explosion(location);
  }

  boolean isDead() {
    return this.explosion != null && explosion.isDead() && this.thrustParticleGenerator.isDead();
  }
}
