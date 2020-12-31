class Explosion implements Firework {
  Vec3D location;
  Vec3D velocity;
  float timeAfterExplosion;
  float numberOfComets;
  float cometColor;
  float cometLifeSpan;
  float averageCometMass;
  boolean hasGlitter;
  ArrayList<Particle> comets;
  AudioPlayer explosionSound;

  Explosion(Vec3D aLocation, Vec3D aVelocity, float minExplosionSize, float maxExplosionSize, float averageCometSize) {
    this.location = aLocation;
    this.velocity = aVelocity;
    hasGlitter = random(1) <= 0.3;
    this.timeAfterExplosion = -1;
    this.cometColor = random(255);
    this.cometLifeSpan = hasGlitter ? random(70, 500) : random(70, 150);
    averageCometMass = random(0.4, 1.2);
    float explosionSize = random(minExplosionSize, maxExplosionSize);
    numberOfComets = random(100, 110);
    this.comets = new ArrayList<Particle>();
    for (int i = 0; i <= maxExplosionSize; i++) {
      //smoke
      comets.add(new Particle(this.location.copy()).moving(Vec3D.randomVector().scale(explosionSize).add(velocity))
          .hue(this.cometColor)
          .lifespan(0)
          .airResistance(random(0.2, averageCometSize * 0.3))
          .mass(averageCometMass)
          .smokeDuration(200)
          .size(1.5));
    }
    boolean hasDifferentGlitter = random(1) <= 0.1;
    float glitterHue = random(0,255);
    for (int i = 0; i <= numberOfComets; i++) {
      if(hasGlitter) {
        if(hasDifferentGlitter) {
          glitterHue = random(0,255);
        }
        comets.add(new Comet(this.location.copy(), Vec3D.randomVector().scale(explosionSize).add(velocity), glitterHue)
          .hue(this.cometColor)
          .lifespan(random(cometLifeSpan * 0.5, cometLifeSpan * 1.5))
          .airResistance(random(averageCometSize * 0.9, averageCometSize * 1.1))
          .mass(averageCometMass)
          .smokeDuration(100)
          .size(3));
      } else {
        comets.add(new Particle(this.location.copy()).moving(Vec3D.randomVector().scale(explosionSize).add(velocity))
          .hue(this.cometColor)
          .lifespan(random(cometLifeSpan * 0.5, cometLifeSpan * 1.5))
          .airResistance(random(averageCometSize * 0.9, averageCometSize * 1.1))
          .mass(averageCometMass)
          .smokeDuration(100)
          .size(2));
      }
    }
    float distanceFactor = playground.distanceFactorFromViewer(this.location);
    explosionSound = explosionSize >= 30 ? assets.randomLargeExplosionSound() : assets.randomSmallExplosionSound();
    explosionSound.setGain(map(distanceFactor, 0, 1, 0, -30));
    explosionSound.play();
  }

  void physics() {
    this.timeAfterExplosion++;
    for (int i = this.comets.size()-1; i >= 0; i--) {
      Particle comet = this.comets.get(i);
      if (comet.isDead()) {
        this.comets.remove(i);
      }
      comet.physics();
    }
  }

  void render() {
    for (int i = this.comets.size()-1; i >= 0; i--) {
      this.comets.get(i).render();
    }
    // render flash
    if(this.timeAfterExplosion <= 20) {
      for (int radius = 10; radius <= 100; radius = radius + 5) {
        stroke(0, 0, 255, 255 / (this.timeAfterExplosion * this.timeAfterExplosion * 4 + 5));
        strokeWeight(radius);
        point(location.x, location.y, location.z);
        if(this.timeAfterExplosion == 0) {
          background(255, 0, 255);
        }
      }
    }
  }

  boolean isDead() {
    return this.comets.isEmpty();
  }
  
  void destroy() {
    explosionSound.close();
  }

  long particleCount() {
    long count = 0;
    for (int i = this.comets.size()-1; i >= 0; i--) {
      count += this.comets.get(i).particleCount();
    }
    return count;
  }
}
