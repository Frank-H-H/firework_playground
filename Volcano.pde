
class Volcano implements Firework {
  PVector location;
  float particleColor;
  float remainingLifespan;
  ArrayList<Particle> particles;
  
  // Beim Erzeugen eines Vulkans
  Volcano() {
    location = new PVector(random(-width/2, width/2), height/2, random(-800, 800));
    particleColor = random(255);
    remainingLifespan = random(200, 400);
    particles = new ArrayList<Particle>();
  }
  
  void doOneCycle() {
    update();
    display();
    remainingLifespan--;
  }
  
  void update() {
    if(remainingLifespan > 0) {
      // chance to emit a particle
      if(random(1) < 0.5) {
        particles.add(new Particle(location.copy(), new PVector(0,-20,0), particleColor, 255));
      }
    }
    // even though the lifespan of the volcano has been ended, it's particles still may be active
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle particle = particles.get(i);
      if (particle.isDead()) {
        particles.remove(i);
      }
      particle.doOneCycle();
    }
  }

  // Method to display
  void display() {
    if(remainingLifespan <= 0) {
      return;
    }
    fill(particleColor,255,255);
    stroke(particleColor, 255, 255, 255);
    strokeWeight(4);
    pushMatrix();
    translate(location.x, location.y, location.z);
    point(0, 0);
    popMatrix();
  }
  
  boolean isDead() {
    return remainingLifespan <= 0;
  }
}
