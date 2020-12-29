import processing.sound.*;

class Assets {

  PApplet parent;
  
  SoundFile[] startSounds;
  SoundFile[] explosionSounds;
  
  Assets (PApplet aParent){
    this.parent = aParent;
    
    startSounds = new SoundFile[] { new SoundFile(parent, "abschuss 1.wav"),
      new SoundFile(parent, "abschuss 2.wav"),
      new SoundFile(parent, "abschuss 3.wav"),
      new SoundFile(parent, "abschuss 4.wav")};
    explosionSounds = new SoundFile[] { new SoundFile(parent, "knall 1.wav"),
      new SoundFile(parent, "knall 2.wav"),
      new SoundFile(parent, "knall 3.wav"),
      new SoundFile(parent, "knall 4.wav")};
    
  }

  SoundFile randomRocketStartSound() {
    return startSounds[int(random(startSounds.length))];
  }
  
  SoundFile randomBombStartSound() {
    return explosionSounds[0];
  }

  SoundFile randomExplosionSound() {
    return explosionSounds[int(random(explosionSounds.length))];
  }
}
