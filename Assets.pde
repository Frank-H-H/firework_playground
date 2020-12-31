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
      "Bottle Rocket-SoundBible.com-332895117.wav",
      "rocket01.mp3",
      "misc113.mp3",
      "misc114.mp3",
      "misc115.mp3"
    };
    largeExplosionSounds = new String[] {
      "knall 1.wav",
      "knall 3.wav",
      "salamisound-4330966-loud-firecrackers-shot-or.wav",
      "salamisound-8469902-loud-firecrackers-shot-or.wav",
      "explosion03.mp3"
    };
    smallExplosionSounds = new String[] {
      "knall 2.wav",
      "salamisound-4330966-loud-firecrackers-shot-or.wav",
      "salamisound-8469902-loud-firecrackers-shot-or.wav",
      "explosion02.mp3"
    };
    volcanoSounds = new String[] {
      "FRWKRec_Sparkling candle 1 (ID 1278)_BSB.mp3",
      "FRWKRec_Sparkling candle 2 (ID 1279)_BSB.mp3",
      "volcano01.mp3",
      "volcano02.mp3",
      "volcano03.mp3"
    };
    bombStartSounds = new String[]{
      "FireWorks-Single-A-www.fesliyanstudios.com.wav",
      "FireWorks-Single-B-www.fesliyanstudios.com.wav",
      "FireWorks-Single-C-www.fesliyanstudios.com.wav",
      "FireWorks-Single-D-www.fesliyanstudios.com.wav",
      "FireWorks-Single-E-www.fesliyanstudios.com.wav",
      "explosion01.mp3"
    };
  }

  AudioPlayer randomRocketStartSound() {
    return minim.loadFile(rocketStartSounds[int(random(rocketStartSounds.length))]);
  }
  
  AudioPlayer randomBombStartSound() {
    return minim.loadFile(bombStartSounds[int(random(bombStartSounds.length))]);
  }

  AudioPlayer randomVolcanoSound() {
    return minim.loadFile(volcanoSounds[int(random(volcanoSounds.length))]);
  }

  AudioPlayer randomLargeExplosionSound() {
    return minim.loadFile(largeExplosionSounds[int(random(largeExplosionSounds.length))]);
  }

  AudioPlayer  randomSmallExplosionSound() {
    return minim.loadFile(smallExplosionSounds[int(random(smallExplosionSounds.length))]);
  }
}
