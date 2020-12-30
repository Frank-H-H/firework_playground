import toxi.geom.*;

class ParticleGenerator {
  PVector location;
  PVector direction;
  float directionJitter;
  float hue;
  float duration;
  float durationJitter;
  float airResistance;
  float airResistanceJitter;

  ArrayList<Particle> particles = new ArrayList<Particle>();
  
  ParticleGenerator(PVector aLocation, PVector aDirection, float aDirectionJitter, float aHue, float aDuration, float aDurationJitter, float anAirResistance, float anAirResistanceJitter) {
    location = aLocation;
    direction = aDirection;
    directionJitter = aDirectionJitter;
    hue = aHue;
    duration = aDuration;
    durationJitter = aDurationJitter;
    airResistance = anAirResistance;
    airResistanceJitter = anAirResistanceJitter;
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
    Vec3D baseDir = new Vec3D(direction.x, direction.y, direction.z);
    baseDir = baseDir.jitter(directionJitter);
    PVector targetDirection = new PVector(baseDir.x, baseDir.y, baseDir.z);
    this.particles.add(new Particle(
      this.location.copy(),
      targetDirection,
      hue,
      random(duration - durationJitter, duration + durationJitter),
      random(airResistance - airResistanceJitter, airResistance + airResistanceJitter)));
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
