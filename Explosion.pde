class Explosion implements Firework {
  PVector location;
  float timeAfterExplosion;

  Explosion(PVector aLocation) {
    this.location = aLocation;
    this.timeAfterExplosion = 0;
  }

  void doOneCycle() {
    update();
    display();
    this.timeAfterExplosion++;
  }

  void update() {
  }

  // Method to display
  void display() {
    // render flash
    if(this.timeAfterExplosion <= 20) {
      for (int radius = 10; radius <= 100; radius = radius + 5) {
        stroke(0, 0, 255, 255 / (this.timeAfterExplosion * this.timeAfterExplosion * 4 + 5));
        strokeWeight(radius);
        point(location.x, location.y, location.z);
        if(this.timeAfterExplosion == 0) {
          background(255, 0, 255);
        }
      }
    }
    
    
    
//    stroke(60, 0, 255, 255 / (this.timeAfterExplosion * this.timeAfterExplosion * 0.05 + 1));
//    strokeWeight(150);
//    point(location.x, location.y, location.z);
  }

  boolean isDead() {
    return this.timeAfterExplosion >= 100;
  }
}
