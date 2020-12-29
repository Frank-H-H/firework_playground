class Rocket implements Firework {
  PVector location;
  PVector velocity;
  float particleColor;
  float thrust;
  float remainingPropellant;
  float remainingTimeUntilExplosion;
  Explosion explosion;

  Rocket(PVector aLocation) {
    this.location = new PVector(aLocation.x, aLocation.y, 0.1);
    this.velocity = new PVector(0, 0, 0);
    this.particleColor = random(255);
    this.thrust = random(0.23, 0.27);
    this.remainingPropellant = random(120, 140);
    this.remainingTimeUntilExplosion = random(80, 100);
    assets.randomRocketStartSound().play();
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
      }
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
