import processing.sound.*;

class Assets {

  PApplet parent;
  
  SoundFile[] startSounds;
  SoundFile[] explosionSounds;
  String[] bombStartSounds; 
  
  
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
    bombStartSounds = new String[]{
      "FireWorks-Single-A-www.fesliyanstudios.com.mp3",
      "FireWorks-Single-B-www.fesliyanstudios.com.mp3"};
  }

  SoundFile randomRocketStartSound() {
    return startSounds[int(random(startSounds.length))];
  }
  
  SoundFile randomBombStartSound() {
    return new SoundFile(parent, bombStartSounds[int(random(bombStartSounds.length))]);
  }

  SoundFile randomExplosionSound() {
    return explosionSounds[int(random(explosionSounds.length))];
  }
}
