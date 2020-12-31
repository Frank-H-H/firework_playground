class Playground {
  PVector frontLeft;
  PVector frontRight;
  PVector backLeft;
  PVector backRight;
  ArrayList<Star> stars;
  Playground() {
    frontLeft = new PVector(-540, 2000, 0);
    frontRight = new PVector(540, 2000, 0);
    backLeft = new PVector(-3250, -2000, 0);
    backRight = new PVector(3250, -2000, 0);
    
    stars = new ArrayList<Star>();
    for(int i = 0; i<= 300; i++) {
      addStar();
    }
  }
  
  void display() {
    
    // display earth
    fill(5);
    beginShape();
    vertex(-100000, -100000, -0.1);
    vertex(-100000, 100000, -0.1);
    vertex(100000, 100000, -0.1);
    vertex(100000, -100000, -0.1);
    endShape(CLOSE);
    
    // display playground
    stroke(20);
    strokeWeight(1);
    fill(5);
    beginShape();
    vertex(backLeft.x, backLeft.y, backLeft.z);
    vertex(frontLeft.x, frontLeft.y, frontLeft.z);
    vertex(frontRight.x, frontRight.y, frontRight.z);
    vertex(backRight.x, backRight.y, backRight.z);
    endShape(CLOSE);
    
    // render stars
    for (int i = this.stars.size()-1; i >= 0; i--) {
      Star star = this.stars.get(i);
      noStroke();
      normal(0, 0, -1);
      fill(star.hue, star.saturation, 255, 255);
      beginShape(QUADS);
      vertex(star.location.x - star.size, star.location.y, star.location.z + star.size);
      vertex(star.location.x + star.size, star.location.y, star.location.z + star.size);
      vertex(star.location.x + star.size, star.location.y, star.location.z - star.size);
      vertex(star.location.x - star.size, star.location.y, star.location.z - star.size);
      endShape();
    }
  }
  
  // The playground is not a rectangle. First, a random distance is chosen. Depending on
  // that distance from the near plane (given by the both front points), an x coordinate is
  // randomly selected
  Vec3D randomPointOnPlayground() {
    float randomY = random(min(frontLeft.y, backLeft.y), max(frontLeft.y, backLeft.y));
    float distanceFromViewer = map(randomY, frontLeft.y, backLeft.y, 0, 1);
    float minXValueAtThatDistance = map(distanceFromViewer, 0, 1, frontLeft.x, backLeft.x);
    float maxXValueAtThatDistance = map(distanceFromViewer, 0, 1, frontRight.x, backRight.x);
    float randomX = random(minXValueAtThatDistance, maxXValueAtThatDistance);
    return new Vec3D(randomX, randomY, 0);
  }
  
  // Returns the distance of the provided location from the viewer in a factor
  // 0 -> very near
  // 1 -> very far
  float distanceFactorFromViewer(Vec3D aLocation) {
    return map(aLocation.y, playground.frontLeft.y, playground.backLeft.y, 0, 1);
  }

  void addStar() {
    float hue;
    do {
      hue = random(0, 255);
    } while (!potentialStarColor(hue));
    Vec3D vec;
    do {
      vec = Vec3D.randomVector();
    } while (vec.z <= 0);
    stars.add(new Star(
      vec.scale(5000),
      random(3, 10),
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
