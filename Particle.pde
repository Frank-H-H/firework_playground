class Particle {
  Vec3D location;
  Vec3D velocity;
  float hue;
  float remainingLifespan;
  float airResistanceFactor;
  float totalSmokeDuration;
  float remainingSmokeDuration;
  float distanceFromViewer;
  boolean isSmoke;
  
  private Particle(Vec3D aLocation) {
    location = aLocation;
    distanceFromViewer = map(location.y, playground.frontLeft.y, playground.backLeft.y, 0, 1);
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
  
  void physics() {
    remainingLifespan--;
    isSmoke = remainingLifespan <= 0;
    if(isSmoke) {
      remainingSmokeDuration--;
      if(location.z <= 0) {
        // smoke already hit the ground, now it's dead
        remainingSmokeDuration = 0;
        return;
      }
    }
    // already hit the ground. dont move at all
    if(location.z <= 0) {
      return;
    }
    // update velocity
    velocity.addSelf(wind);
    velocity.scaleSelf(1 - airResistanceFactor);
    if(isSmoke) {
      // gravity is not that high for smoke
      velocity.addSelf(gravity.scale(0.03));
    } else {
      // gravity is not that high for particles
      velocity.addSelf(gravity.scale(0.1));
    }
    // apply velocity to location
    if(isSmoke) {
      // velocity is not that important for smoke
      location.addSelf(velocity.scale(0.3));
    } else {
      location.addSelf(velocity);
    }
    // particles should not enter earth
    location.z = max(location.z, 0);
  }

  void render() {
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

    // glow
    renderParticle(5, hue, 200, 255, 50 * alphaFactor);
    // glow
    renderParticle(3, hue, 70, 255, 100 * alphaFactor);
    // actual particle
    renderParticle(1, hue, 10, 255, 255 * alphaFactor);
  }

  void renderSmoke() {
    float alphaFactor = 1;
    if(remainingSmokeDuration <= 100) {
      alphaFactor = remainingSmokeDuration / 100;
    }
    
    // outer smoke
    renderParticle(4, hue, 0, 200, 50 * alphaFactor);
    // smoke
    renderParticle(2, hue, 0, 200, 100 * alphaFactor);
  }
  
  void renderParticle(float size, float hue, float saturation, float brightness, float alpha) {
    if(distanceFromViewer <= 0.1) {
      // render as circle
      noStroke();
      normal(0, -1, 0);
      fill(hue, saturation, brightness, alpha);
      beginShape(TRIANGLE_FAN);
      vertex(location.x, location.y, location.z);
      
      vertex(location.x - size, location.y, location.z + size); // top left
      vertex(location.x, location.y, location.z + size * 1.4); // top
      vertex(location.x + size, location.y, location.z + size); // top right
      vertex(location.x + size * 1.4, location.y, location.z); // right
      vertex(location.x + size, location.y, location.z - size); // bottom right
      vertex(location.x, location.y, location.z - size * 1.4); // bottom
      vertex(location.x - size, location.y, location.z - size); // bottom left
      vertex(location.x - size * 1.4, location.y, location.z); // left
      vertex(location.x - size, location.y, location.z + size); // top left
      endShape();
    } else {
      // render as quad
      noStroke();
      normal(0, -1, 0);
      fill(hue, saturation, brightness, alpha);
      beginShape(QUADS);
      vertex(location.x - size, location.y, location.z + size);
      vertex(location.x + size, location.y, location.z + size);
      vertex(location.x + size, location.y, location.z - size);
      vertex(location.x - size, location.y, location.z - size);
      endShape();
    }
  }
  
  boolean isDead() {
    return remainingLifespan <= 0 && remainingSmokeDuration <= 0;
  }
  
}
