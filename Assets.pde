import processing.sound.*;

class Assets {

  PApplet parent;
  
  String[] rocketStartSounds;
  String[] bombStartSounds; 
  String[] volcanoSounds; 
  String[] explosionSounds;
  
  
  Assets (PApplet aParent){
    this.parent = aParent;
    
    rocketStartSounds = new String[] {
      "abschuss 1.wav",
      "abschuss 2.wav",
      "abschuss 3.wav",
      "abschuss 4.wav",
      "Bottle Rocket-SoundBible.com-332895117.wav"
    };
    explosionSounds = new String[] {
      "knall 1.wav",
      "knall 2.wav",
      "knall 3.wav",
      "salamisound-4330966-loud-firecrackers-shot-or.wav",
      "salamisound-8469902-loud-firecrackers-shot-or.wav"
    };
    volcanoSounds = new String[] {
      "FRWKRec_Sparkling candle 1 (ID 1278)_BSB.wav",
      "FRWKRec_Sparkling candle 2 (ID 1279)_BSB.wav"
    };
    bombStartSounds = new String[]{
      "FireWorks-Single-A-www.fesliyanstudios.com.wav",
      "FireWorks-Single-B-www.fesliyanstudios.com.wav",
      "FireWorks-Single-C-www.fesliyanstudios.com.wav",
      "FireWorks-Single-D-www.fesliyanstudios.com.wav",
      "FireWorks-Single-E-www.fesliyanstudios.com.wav"
    };
  }

  SoundFile randomRocketStartSound() {
    return new SoundFile(parent, rocketStartSounds[int(random(rocketStartSounds.length))]);
  }
  
  SoundFile randomBombStartSound() {
    return new SoundFile(parent, bombStartSounds[int(random(bombStartSounds.length))]);
  }

  SoundFile randomVolcanoSound() {
    String sound = volcanoSounds[int(random(volcanoSounds.length))];
    println(sound);
    return new SoundFile(parent, sound);
  }

  SoundFile randomExplosionSound() {
    return new SoundFile(parent, explosionSounds[int(random(explosionSounds.length))]);
  }
}
