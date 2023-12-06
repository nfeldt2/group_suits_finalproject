import processing.sound.*;

class AudioManager {
  
  SoundFile music;
  
  AudioManager(PApplet parent) {
    music = new SoundFile(parent, "audio/music.mp3");  
  }
  
  void startMusic() {
    if (!music.isPlaying()) {
      music.loop(); 
    }
  }
  
  void stopMusic() {
    music.pause();
  }
   
}
