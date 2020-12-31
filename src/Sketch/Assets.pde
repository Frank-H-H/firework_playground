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
      "../assets/abschuss 1.wav",
      "../assets/abschuss 2.wav",
      "../assets/abschuss 3.wav",
      "../assets/abschuss 4.wav",
      "../assets/Bottle Rocket-SoundBible.com-332895117.wav",
      "../assets/rocket01.mp3",
      "../assets/misc113.mp3",
      "../assets/misc114.mp3",
      "../assets/misc115.mp3"
    };
    largeExplosionSounds = new String[] {
      "../assets/knall 1.wav",
      "../assets/knall 3.wav",
      "../assets/salamisound-4330966-loud-firecrackers-shot-or.wav",
      "../assets/salamisound-8469902-loud-firecrackers-shot-or.wav",
      "../assets/explosion03.mp3"
    };
    smallExplosionSounds = new String[] {
      "../assets/knall 2.wav",
      "../assets/salamisound-4330966-loud-firecrackers-shot-or.wav",
      "../assets/salamisound-8469902-loud-firecrackers-shot-or.wav",
      "../assets/explosion02.mp3"
    };
    volcanoSounds = new String[] {
      "../assets/FRWKRec_Sparkling candle 1 (ID 1278)_BSB.mp3",
      "../assets/FRWKRec_Sparkling candle 2 (ID 1279)_BSB.mp3",
      "../assets/volcano01.mp3",
      "../assets/volcano02.mp3",
      "../assets/volcano03.mp3"
    };
    bombStartSounds = new String[]{
      "../assets/FireWorks-Single-A-www.fesliyanstudios.com.wav",
      "../assets/FireWorks-Single-B-www.fesliyanstudios.com.wav",
      "../assets/FireWorks-Single-C-www.fesliyanstudios.com.wav",
      "../assets/FireWorks-Single-D-www.fesliyanstudios.com.wav",
      "../assets/FireWorks-Single-E-www.fesliyanstudios.com.wav",
      "../assets/explosion01.mp3"
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
