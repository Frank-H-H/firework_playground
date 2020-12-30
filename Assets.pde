class Assets {

  PApplet parent;
  
  String[] rocketStartSounds;
  String[] bombStartSounds; 
  String[] volcanoSounds; 
  String[] largeExplosionSounds;
  String[] smallExplosionSounds;
  
  
  Assets (PApplet aParent){
    this.parent = aParent;
    
    rocketStartSounds = new String[] {
      "abschuss 1.wav",
      "abschuss 2.wav",
      "abschuss 3.wav",
      "abschuss 4.wav",
      "Bottle Rocket-SoundBible.com-332895117.wav"
    };
    largeExplosionSounds = new String[] {
      "knall 1.wav",
      "knall 3.wav",
      "salamisound-4330966-loud-firecrackers-shot-or.wav",
      "salamisound-8469902-loud-firecrackers-shot-or.wav"
    };
    smallExplosionSounds = new String[] {
      "knall 2.wav",
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
    return new SoundFile(parent, volcanoSounds[int(random(volcanoSounds.length))]);
  }

  SoundFile randomLargeExplosionSound() {
    return new SoundFile(parent, largeExplosionSounds[int(random(largeExplosionSounds.length))]);
  }

  SoundFile randomSmallExplosionSound() {
    return new SoundFile(parent, smallExplosionSounds[int(random(smallExplosionSounds.length))]);
  }
}
