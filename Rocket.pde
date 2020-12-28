class Rocket implements Firework {
  PVector location;
  PVector velocity;
  float particleColor;
  float thrust;
  float remainingPropellant;
  float remainingTimeUntilExplosion;
  boolean exploded;

  // Beim Erzeugen eines Vulkans
  Rocket() {
    this.location = new PVector(random(-500, 500), random(-500, 500), 0.1);
    this.velocity = new PVector(0, 0, 0);
    this.particleColor = random(255);
    this.thrust = random(0.2, 0.25);
    this.remainingPropellant = random(80, 100);
    this.remainingTimeUntilExplosion = random(80, 100);
  }

  void doOneCycle() {
    update();
    display();
    remainingPropellant--;
    remainingTimeUntilExplosion--;
  }

  void update() {
    if(remainingTimeUntilExplosion <= 0) {
      explode();
    }
    if(remainingPropellant > 0) {
      velocity.add(new PVector(0, 0, thrust));
    }
    velocity.add(gravity);
    location.add(velocity);
  }

  // Method to display
  void display() {
    stroke(60, 10, 255, 255);
    strokeWeight(1);
    point(location.x, location.y, location.z);
  }
  
  void explode() {
    this.exploded  = true;
  }

  boolean isDead() {
    return exploded;
  }
}
