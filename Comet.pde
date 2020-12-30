class Comet {
  Vec3D location;
  Vec3D velocity;
  float hue;
  float remainingLifespan;
  float airResistanceFactor;
  
  private Comet(Vec3D aLocation) {
    location = aLocation;
  }
  
  Comet moving(Vec3D aVelocity) {
    velocity = aVelocity.copy();
    return this;
  }
  
  Comet hue(float aHue) {
    hue = aHue;
    return this;
  }
  
  Comet lifespan(float aLifespan) {
    remainingLifespan = aLifespan;
    return this;
  }

  Comet airResistance(float anAirResistanceFactor) {
    airResistanceFactor = anAirResistanceFactor;
    return this;
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
    velocity.scaleSelf(1 - airResistanceFactor);
    // gravity is not that high for comets
    velocity.addSelf(gravity.scale(0.5));
    location.addSelf(velocity);
    // comets should not enter earth
    location.z = max(location.z, 0);
  }

  void display() {
    if(remainingLifespan <= 0) {
      return;
    }
    
    float alphaFactor = 1;
    if(remainingLifespan <= 10) {
      alphaFactor = remainingLifespan / 10;
    }
    
    float distance = map(location.y, playground.frontLeft.y, playground.backLeft.y, 0, 1);
    float distanceFactor = map(distance, 0, 1, 2, 0.1);
    
    // glow
    stroke(hue, 200, 255, 50 * alphaFactor);
    strokeWeight(distanceFactor * 5);
    point(location.x, location.y, location.z);
    // glow
    stroke(hue, 70, 255, 100 * alphaFactor);
    strokeWeight(distanceFactor * 3);
    point(location.x, location.y, location.z);
    stroke(hue, 10, 255, 255 * alphaFactor);
    strokeWeight(distanceFactor);
    point(location.x, location.y, location.z);
  }
  
  boolean isDead() {
    return remainingLifespan <= 0;
  }

}
