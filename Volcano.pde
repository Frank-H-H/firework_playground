
class Volcano {
  PVector location;
  float particleColor;
  
  // Beim Erzeugen eines Vulkans
  Volcano() {
    location = new PVector(random(-width/2, width/2), height/2, random(-800, 800));
    particleColor = random(255);
  }
  
  void run() {
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
}
