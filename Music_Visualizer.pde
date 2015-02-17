import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer player;
AudioInput in;
AudioOutput out;
FFT fft;
Oscil wave;

void setup(){
  size(800,500);

  minim = new Minim(this);
  minim.debugOn();  
  player = minim.loadFile("song.mp3", 1024);
  player.loop();
  in = minim.getLineIn(); //Minim.STEREO, 512
  fft = new FFT(player.bufferSize(), player.sampleRate());
  //out = minim.getLineOut();
  //wave = new Oscil(440, .5f, Waves.SINE);
  //patch the oscil to the output
  //wave.patch(out);
  
  stroke(255);
  
}

void draw(){
  
  background(0);
  fft.forward(player.mix);
  
  for(int i = 0; i < fft.specSize(); i++){
    line(i, height, i, height - fft.getBand(i) * 4);
  }
  
  for(int i = 0; i < player.bufferSize() - 1; i++)  {
    float x1 = map( i, 0, player.bufferSize(), 0, width );
    float x2 = map( i+1, 0, player.bufferSize(), 0, width );
    line( x1, 50 + player.left.get(i)*50, x2, 50 + player.left.get(i+1)*50 );
    line( x1, 150 + player.right.get(i)*50, x2, 150 + player.right.get(i+1)*50 );
  }
}
