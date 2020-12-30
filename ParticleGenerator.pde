import toxi.geom.*;

class ParticleGenerator {
  Vec3D location;
  Vec3D direction;
  float directionJitter;
  float hue;
  float duration;
  float durationJitter;
  float airResistance;
  float airResistanceJitter;
  float smokeDuration;

  ArrayList<Particle> particles = new ArrayList<Particle>();
  
  ParticleGenerator(Vec3D aLocation, Vec3D aDirection) {
    location = aLocation;
    direction = aDirection;
  }

  ParticleGenerator directionJitter(float aDirectionJitter) {
    directionJitter = aDirectionJitter;
    return this;
  }

  ParticleGenerator hue(float aHue) {
    hue = aHue;
    return this;
  }

  ParticleGenerator duration(float aDuration) {
    duration = aDuration;
    return this;
  }

  ParticleGenerator durationJitter(float aDurationJitter) {
    durationJitter = aDurationJitter;
    return this;
  }

  ParticleGenerator airResistance(float anAirResistance) {
    airResistance = anAirResistance;
    return this;
  }

  ParticleGenerator airResistanceJitter(float anAirResistanceJitter) {
    airResistanceJitter = anAirResistanceJitter;
    return this;
  }
  
  ParticleGenerator averageSmokeDuration(float anAverageSmokeDuration) {
    smokeDuration = anAverageSmokeDuration;
    return this;
  }
  
  void setLocation(Vec3D aLocation) {
    location = aLocation;
  }
  
  void update() {
    for (int i = this.particles.size()-1; i >= 0; i--) {
      Particle particle = this.particles.get(i);
      if (particle.isDead()) {
        this.particles.remove(i);
      }
      particle.doOneCycle();
    }
  }
  
  void emitParticle() {
    this.particles.add(new Particle(this.location.copy())
      .moving(direction.copy().jitter(directionJitter))
      .hue(hue)
      .lifespan(random(duration - durationJitter, duration + durationJitter))
      .airResistance(random(airResistance - airResistanceJitter, airResistance + airResistanceJitter))
      .smokeDuration(random(smokeDuration * 0.5, smokeDuration * 1.5)));
  }

  void emitParticles(int count) {
    for(int i = 0; i <= count; i++) {
      emitParticle();
    }
  }

  
  boolean isDead() {
    return particles.isEmpty();
  }
}
