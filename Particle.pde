class Particle {
  PVector location;
  PVector velocity;
  float hue;
  float remainingLifespan;
  float airResistanceFactor;
  
  Particle(PVector aLocation, PVector aVelocity, float aHue, float aRemainingLifespan, float anAirResistanceFactor) {
    location = aLocation;
    velocity = aVelocity;
    hue = aHue;
    remainingLifespan = aRemainingLifespan;
    airResistanceFactor = anAirResistanceFactor;
  }
  
  void doOneCycle() {
    update();
    display();
    remainingLifespan--;
  }

  void update() {
    if(remainingLifespan <= 0) {
      return;
    }
    // already hit the ground. dont move
    if(location.z <= 0) {
      return;
    }
    velocity.mult(1 - airResistanceFactor);
    velocity.add(gravity);
    location.add(velocity);
    // particles should not enter earth
    location.z = max(location.z, 0);
  }

  void display() {
    if(remainingLifespan <= 0) {
      return;
    }
    
    float distance = map(location.y, playground.frontLeft.y, playground.backLeft.y, 0, 1);
    float distanceFactor = map(distance, 0, 1, 2, 0.1);
    
    // glow
    stroke(hue, 200, 255, 50);
    strokeWeight(distanceFactor * 5);
    point(location.x, location.y, location.z);
    // glow
    stroke(hue, 70, 255, 100);
    strokeWeight(distanceFactor * 3);
    point(location.x, location.y, location.z);
    stroke(hue, 10, 255, 255);
    strokeWeight(distanceFactor);
    point(location.x, location.y, location.z);
  }
  
  boolean isDead() {
    return remainingLifespan <= 0;
  }
  
}
