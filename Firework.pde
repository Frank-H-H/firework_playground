
interface Firework {
  // Determines, whether the firework is completely dead or if there is still anything going off
  boolean isDead();
  
  // Updates the internal state of this firework for one cycle
  void physics();

  // Renders the firework in its current state
  void render();
}
