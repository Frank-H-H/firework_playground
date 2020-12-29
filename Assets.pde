import processing.sound.*;

class Assets {

  PApplet parent;
  
  SoundFile[] startSounds;
  String[] explosionSounds;
  String[] bombStartSounds; 
  
  
  Assets (PApplet aParent){
    this.parent = aParent;
    
    startSounds = new SoundFile[] { new SoundFile(parent, "abschuss 1.wav"),
      new SoundFile(parent, "abschuss 2.wav"),
      new SoundFile(parent, "abschuss 3.wav"),
      new SoundFile(parent, "abschuss 4.wav")};
    explosionSounds = new String[] { "knall 1.wav",
      "knall 2.wav",
      "knall 3.wav",
      "salamisound-4330966-loud-firecrackers-shot-or.mp3",
      "salamisound-8469902-loud-firecrackers-shot-or.mp3"
    };
    bombStartSounds = new String[]{
      "FireWorks-Single-A-www.fesliyanstudios.com.mp3",
      "FireWorks-Single-B-www.fesliyanstudios.com.mp3",
      "FireWorks-Single-C-www.fesliyanstudios.com.mp3",
      "FireWorks-Single-D-www.fesliyanstudios.com.mp3",
      "FireWorks-Single-E-www.fesliyanstudios.com.mp3"
    };
  }

  SoundFile randomRocketStartSound() {
    return startSounds[int(random(startSounds.length))];
  }
  
  SoundFile randomBombStartSound() {
    return new SoundFile(parent, bombStartSounds[int(random(bombStartSounds.length))]);
  }

  SoundFile randomExplosionSound() {
    return new SoundFile(parent, explosionSounds[int(random(explosionSounds.length))]);
  }
}
