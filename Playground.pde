class Playground {
  PVector frontLeft;
  PVector frontRight;
  PVector backLeft;
  PVector backRight;
  Playground() {
    frontLeft = new PVector(-120, 2000, 0);
    frontRight = new PVector(120, 2000, 0);
    backLeft = new PVector(-2900, -2000, 0);
    backRight = new PVector(2900, -2000, 0);
  }
  
  void display() {
    stroke(100);
    strokeWeight(1);
    fill(20);
    beginShape();
    vertex(backLeft.x, backLeft.y, backLeft.z);
    vertex(frontLeft.x, frontLeft.y, frontLeft.z);
    vertex(frontRight.x, frontRight.y, frontRight.z);
    vertex(backRight.x, backRight.y, backRight.z);
    endShape(CLOSE);
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
}
