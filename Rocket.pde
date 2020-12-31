class Rocket implements Firework {
  Vec3D location;
  Vec3D velocity;
  float thrustHue;
  float thrust;
  float remainingPropellant;
  float remainingTimeUntilExplosion;
  ParticleGenerator thrustParticleGenerator;
  Explosion explosion;
  AudioPlayer startSound;

  Rocket(Vec3D aLocation) {
    this.location = new Vec3D(aLocation.x, aLocation.y, 0.1);
    this.velocity = new Vec3D(0, 0, 0);
    this.thrustHue = random(255);
    this.thrust = random(0.23, 0.27);
    this.remainingPropellant = 150;
    this.remainingTimeUntilExplosion = random(100, 120);
    thrustParticleGenerator = new ParticleGenerator(location, new Vec3D(0, 0, thrust * -5))
      .directionJitter(random(0.1, 0.3))
      .hue(thrustHue)
      .duration(random(10, 40))
      .durationJitter(6)
      .airResistance(random(0.02, 0.08))
      .airResistanceJitter(0.002)
      .averageSmokeDuration(200);
    float distanceFactor = playground.distanceFactorFromViewer(this.location);
    startSound = assets.randomRocketStartSound();
    startSound.setGain(map(distanceFactor, 0, 1, 0, -30));
    startSound.play();
  }

  void physics() {
    this.remainingPropellant--;
    this.remainingTimeUntilExplosion--;
    if(this.remainingTimeUntilExplosion <= 0 && explosion == null) {
      this.explode();
    }
    if(this.explosion != null) {
      this.explosion.physics();
    } else {
      if(this.remainingPropellant > 0) {
        this.velocity.addSelf(new Vec3D(0, 0, thrust).jitter(0.8));
        thrustParticleGenerator.emitParticles(3);
      }
      this.velocity.addSelf(gravity);
      this.location.addSelf(this.velocity);
    }
    thrustParticleGenerator.physics();
  }

  void render() {
    if(this.explosion != null) {
      this.explosion.render();
    } else {
      // render rocket
      pushMatrix();
      noStroke();
      translate(location.x, location.y, location.z + 5);
      fill(thrustHue, 100, 80, 255);
      box(3, 3, 10);
      popMatrix();
    }
    thrustParticleGenerator.render();
  }
  
  void explode() {
    this.explosion = new Explosion(location, velocity, 7, 15, random(0.07, 0.15));
  }

  boolean isDead() {
    return this.explosion != null && explosion.isDead() && this.thrustParticleGenerator.isDead();
  }
    
  void destroy() {
    if(explosion != null) {
      explosion.destroy();
    }
    startSound.close();
  }

  long particleCount() {
    return this.thrustParticleGenerator.particleCount();
  }
}
