class Rocket implements Firework {
  PVector location;
  PVector velocity;
  float thrustColor;
  float thrust;
  float remainingPropellant;
  float remainingTimeUntilExplosion;
  float horizontalThrustSpread;
  float thrustParticleLifespan;
  float thrustParticleAirResistance;
  ArrayList<Particle> thrustParticles;
  Explosion explosion;

  Rocket(PVector aLocation) {
    this.location = new PVector(aLocation.x, aLocation.y, 0.1);
    this.velocity = new PVector(0, 0, 0);
    this.thrustColor = random(255);
    this.thrust = random(0.23, 0.27);
    this.remainingPropellant = random(100, 120);
    this.remainingTimeUntilExplosion = random(100, 120);
    this.horizontalThrustSpread = random(0.25, 1);
    this.thrustParticleLifespan = random(15, 80);
    this.thrustParticleAirResistance = random(0.02, 0.08);
    this.thrustParticles = new ArrayList<Particle>();
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
        emitThrustParticle();
        emitThrustParticle();
        emitThrustParticle();
      }
      this.velocity.add(gravity);
      this.location.add(this.velocity);
    }
    for (int i = this.thrustParticles.size()-1; i >= 0; i--) {
      Particle particle = this.thrustParticles.get(i);
      if (particle.isDead()) {
        this.thrustParticles.remove(i);
      }
      particle.doOneCycle();
    }
  }

  // Method to display
  void display() {
    stroke(60, 10, 255, 255);
    strokeWeight(1);
    point(location.x, location.y, location.z);
  }
  
  void explode() {
    this.explosion = new Explosion(location);
  }
  
  void emitThrustParticle() {
    this.thrustParticles.add(new Particle(
      this.location.copy(),
      new PVector(
        random(-this.horizontalThrustSpread,this.horizontalThrustSpread),
        random(-this.horizontalThrustSpread,this.horizontalThrustSpread),
        random(this.thrust*0.9*-5, this.thrust*1.1*-5)),
      this.thrustColor,
      random(thrustParticleLifespan * 0.8, thrustParticleLifespan * 1.2), random(thrustParticleAirResistance*0.9, thrustParticleAirResistance*1.1)));
  }

  boolean isDead() {
    return this.explosion != null && explosion.isDead() && this.thrustParticles.isEmpty();
  }
}
