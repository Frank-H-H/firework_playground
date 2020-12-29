class Explosion implements Firework {
  PVector location;
  float timeAfterExplosion;
  float numberOfComets;
  float cometColor;
  float cometLifeSpan;
  ArrayList<Comet> comets;

  Explosion(PVector aLocation) {
    this.location = aLocation;
    this.timeAfterExplosion = 0;
    this.cometColor = random(255);
    this.cometLifeSpan = random(20, 200);
    numberOfComets = random(200, 700);
    this.comets = new ArrayList<Comet>();
    for (int i = 0; i <= numberOfComets; i++) {
      comets.add(new Comet(
          this.location.copy(),
          PVector.random3D().mult(random(20, 30)),
          this.cometColor,
          random(cometLifeSpan * 0.5, cometLifeSpan * 1.5), random(0.1, 0.2)));
    }
    float distanceFactor = playground.distanceFactorFromViewer(this.location);
    SoundFile startSound = assets.randomExplosionSound();
    startSound.amp(map(distanceFactor,0,1,1,0.05));
    startSound.play();
  }

  void doOneCycle() {
    update();
    display();
    this.timeAfterExplosion++;
  }

  void update() {
    for (int i = this.comets.size()-1; i >= 0; i--) {
      Comet comet = this.comets.get(i);
      if (comet.isDead()) {
        this.comets.remove(i);
      }
      comet.doOneCycle();
    }
  }

  void display() {
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
}
