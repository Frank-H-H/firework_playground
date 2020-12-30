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

  ArrayList<Particle> particles = new ArrayList<Particle>();
  
  ParticleGenerator(Vec3D aLocation, Vec3D aDirection, float aDirectionJitter, float aHue, float aDuration, float aDurationJitter, float anAirResistance, float anAirResistanceJitter) {
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
    this.particles.add(new Particle(this.location.copy())
      .moving(direction.copy().jitter(directionJitter))
      .hue(hue)
      .lifespan(random(duration - durationJitter, duration + durationJitter))
      .airResistance(random(airResistance - airResistanceJitter, airResistance + airResistanceJitter)));
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
