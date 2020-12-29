class Playground {
  PVector frontLeft;
  PVector frontRight;
  PVector backLeft;
  PVector backRight;
  ArrayList<Star> stars;
  Playground() {
    frontLeft = new PVector(-120, 2000, 0);
    frontRight = new PVector(120, 2000, 0);
    backLeft = new PVector(-2900, -2000, 0);
    backRight = new PVector(2900, -2000, 0);
    
    stars = new ArrayList<Star>();
    for(int i = 0; i<= 150; i++) {
      addStar();
    }
  }
  
  void display() {
    stroke(40);
    strokeWeight(1);
    fill(10);
    beginShape();
    vertex(backLeft.x, backLeft.y, backLeft.z);
    vertex(frontLeft.x, frontLeft.y, frontLeft.z);
    vertex(frontRight.x, frontRight.y, frontRight.z);
    vertex(backRight.x, backRight.y, backRight.z);
    endShape(CLOSE);
    
    // render stars
    for (int i = this.stars.size()-1; i >= 0; i--) {
      Star star = this.stars.get(i);
      stroke(star.hue, star.saturation, 255, 255);
      strokeWeight(star.size);
      point(star.location.x, star.location.y, star.location.z);
    }
  }
  
  // The playground is not a rectangle. First, a random distance is chosen. Depending on
  // that distance from the near plane (given by the both front points), an x coordinate is
  // randomly selected
  PVector randomPointOnPlayground() {
    float randomY = random(min(frontLeft.y, backLeft.y), max(frontLeft.y, backLeft.y));
    float distanceFromViewer = map(randomY, frontLeft.y, backLeft.y, 0, 1);
    float minXValueAtThatDistance = map(distanceFromViewer, 0, 1, frontLeft.x, backLeft.x);
    float maxXValueAtThatDistance = map(distanceFromViewer, 0, 1, frontRight.x, backRight.x);
    float randomX = random(minXValueAtThatDistance, maxXValueAtThatDistance);
    return new PVector(randomX, randomY, 0);
  }
  
  // Returns the distance of the provided location from the viewer in a factor
  // 0 -> very near
  // 1 -> very far
  float distanceFactorFromViewer(PVector aLocation) {
    return map(aLocation.y, playground.frontLeft.y, playground.backLeft.y, 0, 1);
  }

  void addStar() {
    float hue;
    do {
      hue = random(0, 255);
    } while (!potentialStarColor(hue));
    
    stars.add(new Star(
      new PVector(
        random(min(backLeft.x, backRight.x)*1.1, max(backLeft.x, backRight.x))*1.1,
        -2000,
        random(100, 4000)),
      random(0.5, 1) * random(1, 4),
      hue,
      random(0, 60)));
  }
  
  boolean potentialStarColor(float aHue) {
    if(aHue < 48) {
      // red, could be a star color
      return true;
    }
    if(aHue < 130) {
      // avoid green stars
      return false;
    }
    if(aHue < 192) {
      // blueish, potentially a star color
      return true;
    }
    if(aHue < 240) {
      // violet and pink, not a star
      return false;
    }
    // remining up until 255 is red again
    return true;
  }
}
