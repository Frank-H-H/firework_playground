class Bomb implements Firework {
  Vec3D location;
  Vec3D velocity;
  float distanceFromViewer;
  float launcherParticleColor;
  ParticleGenerator launcherParticleGenerator;
  Explosion explosion;
  AudioPlayer startSound;

  Bomb(Vec3D aLocation) {
    this.location = new Vec3D(aLocation.x, aLocation.y, 0.1);
    this.velocity = new Vec3D(0, 0, random(14,16));
    this.launcherParticleColor = random(255);
    launcherParticleGenerator = new ParticleGenerator(location, new Vec3D(0, 0, this.velocity.z * 0.75))
      .directionJitter(random(0.3, 1))
      .hue(launcherParticleColor)
      .duration(random(15, 30))
      .durationJitter(5)
      .airResistance(random(0.1, 0.2))
      .airResistanceJitter(0.02)
      .averageSmokeDuration(200);
    distanceFromViewer = playground.distanceFactorFromViewer(this.location);
    startSound = assets.randomBombStartSound();
    startSound.setGain(map(distanceFromViewer, 0, 1, 0, -30));
    startSound.play();
    launcherParticleGenerator.emitParticles(200);
  }

  void physics() {
    if(this.velocity.z <= 0 && explosion == null) {
      this.explode();
    }
    if(this.explosion != null) {
      this.explosion.physics();
    } else {
      this.velocity.addSelf(gravity);
      this.location.addSelf(this.velocity);
    }
    launcherParticleGenerator.physics();
  }

  void render() {
    if(this.explosion != null) {
      this.explosion.render();
    }
    launcherParticleGenerator.render();
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
    this.explosion = new Explosion(location, velocity, 20, 30, random(0.02, 0.15));
  }

  boolean isDead() {
    return this.explosion != null && explosion.isDead() && this.launcherParticleGenerator.isDead();
  }
  
  void destroy() {
    if(explosion != null) {
      explosion.destroy();
    }
    startSound.close();
  }
  
  long particleCount() {
    return this.launcherParticleGenerator.particleCount();
  }
}
