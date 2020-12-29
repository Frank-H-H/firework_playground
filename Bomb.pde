class Bomb implements Firework {
  PVector location;
  PVector velocity;
  float particleColor;
  Explosion explosion;

  Bomb(PVector aLocation) {
    this.location = new PVector(aLocation.x, aLocation.y, 0.1);
    this.velocity = new PVector(0, 0, random(14,16));
    this.particleColor = random(255);
    float distanceFactor = playground.distanceFactorFromViewer(this.location);
    SoundFile startSound = assets.randomBombStartSound();
    startSound.amp(map(distanceFactor,0,1,0.6,0.02));
    startSound.play();
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

  boolean isDead() {
    return this.explosion != null && explosion.isDead();
  }
}
