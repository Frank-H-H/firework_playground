class Particle {
  Vec3D location;
  Vec3D velocity;
  float hue;
  float remainingLifespan;
  float airResistanceFactor;
  float totalSmokeDuration;
  float remainingSmokeDuration;
  
  private Particle(Vec3D aLocation) {
    location = aLocation;
  }
  
  Particle moving(Vec3D aVelocity) {
    velocity = aVelocity.copy();
    return this;
  }
  
  Particle hue(float aHue) {
    hue = aHue;
    return this;
  }
  
  Particle lifespan(float aLifespan) {
    remainingLifespan = aLifespan;
    return this;
  }

  Particle airResistance(float anAirResistanceFactor) {
    airResistanceFactor = anAirResistanceFactor;
    return this;
  }
  
  Particle smokeDuration(float aSmokeDuration) {
    totalSmokeDuration = aSmokeDuration;
    remainingSmokeDuration = totalSmokeDuration;
    return this;
  }
  
  void doOneCycle() {
    update();
    display();
  }

  void update() {
    remainingLifespan--;
    if(remainingLifespan <= 0) {
      remainingSmokeDuration--;
    }
    // already hit the ground. dont move
    if(location.z <= 0) {
      return;
    }
    velocity.scaleSelf(1 - airResistanceFactor);
    if(remainingLifespan > 0) {
      velocity.addSelf(gravity);
    } else {
      velocity.addSelf(gravity.scale(0.03));
    }
    velocity.addSelf(wind);
    location.addSelf(velocity);
    // particles should not enter earth
    location.z = max(location.z, 0);
  }

  void display() {
    if(remainingLifespan > 0) {
      renderGlowing();
    } else {
      if(remainingSmokeDuration > 0) {
        renderSmoke();
      }
    }
  }

  void renderGlowing() {
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
    // actual particle
    stroke(hue, 10, 255, 255 * alphaFactor);
    strokeWeight(distanceFactor);
    point(location.x, location.y, location.z);
  }

  void renderSmoke() {
    float alphaFactor = 1;
    if(remainingSmokeDuration <= 100) {
      alphaFactor = remainingSmokeDuration / 100;
    }
    
    float distance = map(location.y, playground.frontLeft.y, playground.backLeft.y, 0, 1);
    float distanceFactor = map(distance, 0, 1, 2, 0.1);
    
    // outer smoke
    stroke(hue, 0, 30, 100 * alphaFactor);
    strokeWeight(distanceFactor * 2);
    point(location.x, location.y, location.z);
    // smoke
    stroke(hue, 0, 30, 255 * alphaFactor);
    strokeWeight(distanceFactor * 1);
    point(location.x, location.y, location.z);
  }
  
  boolean isDead() {
    return remainingLifespan <= 0 && remainingSmokeDuration <= 0;
  }
  
}
