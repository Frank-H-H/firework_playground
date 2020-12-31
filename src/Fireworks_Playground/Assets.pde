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
      "data/abschuss 1.wav",
      "data/abschuss 2.wav",
      "data/abschuss 3.wav",
      "data/abschuss 4.wav",
      "data/Bottle Rocket-SoundBible.com-332895117.wav",
      "data/rocket01.mp3",
      "data/misc113.mp3",
      "data/misc114.mp3",
      "data/misc115.mp3"
    };
    largeExplosionSounds = new String[] {
      "data/knall 1.wav",
      "data/knall 3.wav",
      "data/salamisound-4330966-loud-firecrackers-shot-or.wav",
      "data/salamisound-8469902-loud-firecrackers-shot-or.wav",
      "data/explosion03.mp3"
    };
    smallExplosionSounds = new String[] {
      "data/knall 2.wav",
      "data/salamisound-4330966-loud-firecrackers-shot-or.wav",
      "data/salamisound-8469902-loud-firecrackers-shot-or.wav",
      "data/explosion02.mp3"
    };
    volcanoSounds = new String[] {
      "data/FRWKRec_Sparkling candle 1 (ID 1278)_BSB.mp3",
      "data/FRWKRec_Sparkling candle 2 (ID 1279)_BSB.mp3",
      "data/volcano01.mp3",
      "data/volcano02.mp3",
      "data/volcano03.mp3"
    };
    bombStartSounds = new String[]{
      "data/FireWorks-Single-A-www.fesliyanstudios.com.wav",
      "data/FireWorks-Single-B-www.fesliyanstudios.com.wav",
      "data/FireWorks-Single-C-www.fesliyanstudios.com.wav",
      "data/FireWorks-Single-D-www.fesliyanstudios.com.wav",
      "data/FireWorks-Single-E-www.fesliyanstudios.com.wav",
      "data/explosion01.mp3"
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
