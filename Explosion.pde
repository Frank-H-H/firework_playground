class Explosion implements Firework {
  Vec3D location;
  Vec3D velocity;
  float timeAfterExplosion;
  float numberOfComets;
  float cometColor;
  float particleColor;
  float cometLifeSpan;
  float averageCometMass;
  ArrayList<Comet> comets;

  Explosion(Vec3D aLocation, Vec3D aVelocity, float minExplosionSize, float maxExplosionSize, float averageCometSize) {
    this.location = aLocation;
    this.velocity = aVelocity;
    this.timeAfterExplosion = -1;
    this.cometColor = 40;
    this.particleColor = random(255);
    this.cometLifeSpan = random(70, 200);
    averageCometMass = random(0.4, 1.2);
    float explosionSize = random(minExplosionSize, maxExplosionSize);
    numberOfComets = random(100, 110);
    this.comets = new ArrayList<Comet>();
    for (int i = 0; i <= numberOfComets; i++) {
      comets.add(new Comet(this.location.copy(), Vec3D.randomVector().scale(explosionSize).add(velocity))
        .hue(this.particleColor)
        .lifespan(random(cometLifeSpan * 0.5, cometLifeSpan * 1.5))
        .airResistance(random(averageCometSize * 0.9, averageCometSize * 1.1))
        .mass(averageCometMass));
    }
    float distanceFactor = playground.distanceFactorFromViewer(this.location);
    SoundFile startSound = explosionSize >= 30 ? assets.randomLargeExplosionSound() : assets.randomSmallExplosionSound();
    startSound.amp(map(distanceFactor,0,1,1,0.05));
    startSound.play();
  }

  void physics() {
    this.timeAfterExplosion++;
    for (int i = this.comets.size()-1; i >= 0; i--) {
      Comet comet = this.comets.get(i);
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
  
  long particleCount() {
    long count = 0;
    for (int i = this.comets.size()-1; i >= 0; i--) {
      count += this.comets.get(i).particleCount();
    }
    return count;
  }
}
