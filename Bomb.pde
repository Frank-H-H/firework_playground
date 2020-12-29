class Bomb implements Firework {
  PVector location;
  PVector velocity;
  float distanceFromViewer;
  float startParticleColor;
  float horizontalStartSpread;
  float startParticleLifespan;
  float startParticleAirResistance;
  ArrayList<Particle> startParticles;
  Explosion explosion;

  Bomb(PVector aLocation) {
    this.location = new PVector(aLocation.x, aLocation.y, 0.1);
    this.velocity = new PVector(0, 0, random(14,16));
    this.startParticleColor = random(255);
    this.horizontalStartSpread = random(0.20, 0.5);
    this.startParticleLifespan = random(15, 80);
    this.startParticleAirResistance = random(0.1, 0.2);
    this.startParticles = new ArrayList<Particle>();
    distanceFromViewer = playground.distanceFactorFromViewer(this.location);
    SoundFile startSound = assets.randomBombStartSound();
    startSound.amp(map(distanceFromViewer,0,1,0.6,0.02));
    startSound.play();
    for(int i = 0; i<= 200; i++) {
      emitStartParticle();
    }
  }

  void doOneCycle() {
    this.update();
    this.display();
  }

  void update() {
    if(this.velocity.z <= 0 && explosion == null) {
      this.explode();
    }
    if(this.explosion != null) {
      this.explosion.doOneCycle();
    } else {
      this.velocity.add(gravity);
      this.location.add(this.velocity);
    }
    for (int i = this.startParticles.size()-1; i >= 0; i--) {
      Particle particle = this.startParticles.get(i);
      if (particle.isDead()) {
        this.startParticles.remove(i);
      }
      particle.doOneCycle();
    }
  }

  // Method to display
  void display() {
    // render launcher
    pushMatrix();
    noStroke();
    translate(location.x, location.y, 0);
    fill(startParticleColor, 100, 80, 255);
    box(3, 3, 20);
    popMatrix();

    // render bomb itself
    stroke(0, 0, 50, 255);
    strokeWeight(map(distanceFromViewer, 0, 1, 5, 0.1));
    point(location.x, location.y, location.z);
  }
  
  void explode() {
    this.explosion = new Explosion(location);
  }
  
  void emitStartParticle() {
    this.startParticles.add(new Particle(
      this.location.copy(),
      new PVector(
        random(-this.horizontalStartSpread,this.horizontalStartSpread),
        random(-this.horizontalStartSpread,this.horizontalStartSpread),
        random(this.velocity.z*0.5, this.velocity.z*1)),
      this.startParticleColor,
      random(startParticleLifespan * 0.8, startParticleLifespan * 1.2), random(startParticleAirResistance*0.9, startParticleAirResistance*1.1)));
  }


  boolean isDead() {
    return this.explosion != null && explosion.isDead() && this.startParticles.isEmpty();
  }
}
