// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/CKeyIbT3vXI

import peasy.*;
import ddf.minim.*;
import processing.net.*;
import toxi.geom.*;


ArrayList<Firework> fireworks;

Server httpServer;

long lastFrameWithActivity = 0;

Vec3D gravity = new Vec3D(0, 0, -0.1);
Vec3D wind = new Vec3D(random(-0.05,0.05), random(-0.05,0.05), 0);

Playground playground;

PeasyCam camera;

Minim minim;
Assets assets;
long startupTime;
boolean autoMode = true;

void setup() {
  startupTime = System.nanoTime();
  minim = new Minim(this);
  assets = new Assets(this);

  fullScreen(P3D);
  //size(800, 600, P3D);
  camera = new PeasyCam(this, 0, 0, 1100, 3000);
  camera.rotateX(-1.9);
  camera.setPitchRotationMode();
  
  colorMode(HSB);
  
  playground = new Playground();
  
  httpServer = new Server(this, 8080);
  
  this.fireworks = new ArrayList<Firework>();
}

void draw() {
  if(autoMode && frameCount - frameRate * 60 > lastFrameWithActivity) {
    if(random(0, 1000) <= 10 - this.fireworks.size()) {
      addBomb();
    }
    if(random(0, 5000) <= 10 - this.fireworks.size()) {
      addVolcano();
    }
    if(random(0, 1000) <= 10 - this.fireworks.size()) {
      addRocket();
    }
  }
  long startTime = System.nanoTime();
  physics();
  long physicsDuration = System.nanoTime() - startTime;
  render();
  long renderDuration = System.nanoTime() - startTime - physicsDuration;
  if(frameCount % 100 == 0) {
    long particleCount = 0;
    for (int i = fireworks.size()-1; i >= 0; i--) {
      particleCount += fireworks.get(i).particleCount();
    }
    println("total runtime:", (startTime - startupTime) / 1000 / 1000 / 1000 / 60, "min", "framerate:",  frameRate, "# Fireworks:", fireworks.size(), "particleCount:",  particleCount, "physicsDuration:", physicsDuration / 1000, "renderDuration:",  renderDuration / 1000);
  }
}

void physics() {
  // running firework
  for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework firework = fireworks.get(i);
    if (firework.isDead()) {
      fireworks.remove(i);
    }
    firework.physics();
  }
}

void render() {
  if(frameRate <= 30 && (frameCount % 100 != 0)) {
    // skip, but only, if we are not in an important frame
    return;
  }
  background(0);
  playground.display();
  
  // running firework
  for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework firework = fireworks.get(i);
    if (firework.isDead()) {
      firework.destroy();
      fireworks.remove(i);
    }
    firework.render();
  }
}

String HTTP_HEADER = "HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n";

class ClientHandler implements Runnable {
  
  Client client;
  boolean finished;
  ClientHandler(Client aClient) {
    println("new thread");
    this.client = aClient;
  }
  
  void run() {
    while(!finished) {
      String whatClientSaid = client.readString();
      if (whatClientSaid != null) {
        println(client.ip() + ": " + whatClientSaid);
        if(whatClientSaid.contains("Volcano")) {
          addVolcano();
          lastFrameWithActivity = frameCount;
        }
        if(whatClientSaid.contains("Rocket")) {
          addRocket();
          lastFrameWithActivity = frameCount;
        }
        if(whatClientSaid.contains("Bomb")) {
          addBomb();
          lastFrameWithActivity = frameCount;
        }
        if(whatClientSaid.contains("Wind")) {
          toggleWind();
        }
        if(whatClientSaid.contains("Gravity")) {
          toggleGravity();
        }
        if(whatClientSaid.contains("AutoMode")) {
          toggleAutoMode();
        }
        client.write(HTTP_HEADER);
        client.write("<html><head><title>Processing talkin'</title></head><body><h3>Your base are belong to us!");
        client.write("</h3></body></html>");
        client.stop();
        finished = true;
      }
    }
  }
}

// ServerEvent message is generated when a new client connects 
// to an existing server.
void serverEvent(Server someServer, Client someClient) {
  println("We have a new client: " + someClient.ip());
  new Thread(new ClientHandler(someClient)).start();
}

void addVolcano() {
  this.fireworks.add(new Volcano(playground.randomPointOnPlayground()));
}

void addRocket() {
  this.fireworks.add(new Rocket(playground.randomPointOnPlayground()));
}

void addBomb() {
  this.fireworks.add(new Bomb(playground.randomPointOnPlayground()));
}

void toggleWind() {
  if(wind.magnitude() == 0) {
    wind = new Vec3D(random(-0.05, 0.05), random(-0.05, 0.05), 0);
  } else {
    wind = new Vec3D(0, 0, 0);
  }
}

void toggleAutoMode() {
  autoMode = !autoMode;
}

void toggleGravity() {
  if(gravity.magnitude() > 0.1) {
    gravity = new Vec3D(0, 0, -0.1);
  } else {
    gravity = new Vec3D(0, 0, -0.2);
  }
}

void keyPressed() {
  if (key == 'v') {
    lastFrameWithActivity = frameCount;
    addVolcano();
  }
  if (key == 'r') {
    lastFrameWithActivity = frameCount;
    addRocket();
  }
  if (key == 'b') {
    lastFrameWithActivity = frameCount;
    addBomb();
  }
}
