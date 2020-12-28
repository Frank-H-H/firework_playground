class Particle {
  PVector location;
  PVector velocity;
  float hue;
  float remainingLifespan;
  
  Particle(PVector aLocation, PVector aVelocity, float aHue, float aRemainingLifespan) {
    location = aLocation;
    velocity = aVelocity;
    hue = aHue;
    remainingLifespan = aRemainingLifespan;
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
    velocity.add(gravity);
    location.add(velocity);
  }

  void display() {
    if(remainingLifespan <= 0) {
      return;
    }
    fill(hue,255,255);
    stroke(hue, 255, 255, 255);
    strokeWeight(2);
    pushMatrix();
    translate(location.x, location.y, location.z);
    point(0, 0);
    popMatrix();
  }
  
  boolean isDead() {
    return remainingLifespan <= 0;
  }
  
}
