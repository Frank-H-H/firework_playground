
interface Firework {
  // Determines, whether the firework is completely dead or if there is still anything going off
  boolean isDead();
  
  // Let's this firework step one cycle forward (physics) and also renders all parts of this firework
  void doOneCycle();
}
