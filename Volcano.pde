
class Volcano implements Firework {
  PVector location;
  float particleColor;
  float remainingTime;
  
  // Beim Erzeugen eines Vulkans
  Volcano() {
    location = new PVector(random(-width/2, width/2), height/2, random(-800, 800));
    particleColor = random(255);
    remainingTime = random(200, 400);
  }
  
  void doOneCycle() {
    remainingTime--;
    fill(particleColor,255,255);
    display();
  }
  
  // Method to display
  void display() {
    stroke(particleColor, 255, 255, 255);
    strokeWeight(4);
    pushMatrix();
    translate(location.x, location.y, location.z);
    point(0, 0);
    popMatrix();
  }
  
  boolean isDead() {
    return remainingTime <= 0;
  }
}
