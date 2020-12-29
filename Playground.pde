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
  
  PVector randomPointOnPlayground() {
    PVector randomPoint;
    do {
      randomPoint = new PVector(
        random(min(frontLeft.x, frontRight.x),max(frontLeft.x, frontRight.x)),
        random(min(frontLeft.y, backLeft.y),max(frontLeft.y, backLeft.y)),
        0);
    } while (!contains(randomPoint));
    return randomPoint;
  }
  
  boolean contains(PVector aVector) {
    return true;
  }

}
