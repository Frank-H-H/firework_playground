// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/CKeyIbT3vXI

import peasy.*;
import processing.sound.*;
import processing.net.*;
import toxi.geom.*;


ArrayList<Firework> fireworks;

Server httpServer;

long lastFrameWithActivity = 0;

Vec3D gravity = new Vec3D(0, 0, -0.1);
Vec3D wind = new Vec3D(random(-0.05,0.05), random(-0.05,0.05), 0);

Playground playground;

PeasyCam camera;

Sound sound;
Assets assets;

void setup() {
  sound = new Sound(this);
  assets = new Assets(this);

  fullScreen(P3D);
  //size(800, 600, P3D);
  camera = new PeasyCam(this, 0, 1500, 200, 700);
  camera.rotateX(-1.79);
  camera.setPitchRotationMode();

  colorMode(HSB);
  blendMode(ADD);
  
  playground = new Playground();
  
  httpServer = new Server(this, 8080);
  
  thread("checkForClients");
  
  this.fireworks = new ArrayList<Firework>();
}

void draw() {
  if(frameCount - frameRate * 60 > lastFrameWithActivity) {
    if(random(0,1000) <= 5 - fireworks.size()) {
      addBomb();
    }
    if(random(0,1000) <= 5 - fireworks.size()) {
      addVolcano();
    }
    if(random(0,1000) <= 5 - fireworks.size()) {
      addRocket();
    }
  }
  physics();
  render();
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
  if(frameRate <= 30) { 
    return;
  }
  background(0);
  playground.display();
  
  // running firework
  for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework firework = fireworks.get(i);
    if (firework.isDead()) {
      fireworks.remove(i);
    }
    firework.render();
  }
  if(frameCount % 100 == 0)
    println("Number of Fireworks:", fireworks.size());
}

void checkForClients() {
  while(true) {
//    Client newClient = httpServer.available();
//    if (newClient !=null) {
//      new Thread(new ClientHandler(newClient)).start();
//    } 
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
        lastFrameWithActivity = frameCount;
        if(whatClientSaid.contains("Volcano")) {
          addVolcano();
        }
        if(whatClientSaid.contains("Rocket")) {
          addRocket();
        }
        if(whatClientSaid.contains("Bomb")) {
          addBomb();
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

void keyPressed() {
  lastFrameWithActivity = frameCount;
  if (key == 'v') {
    addVolcano();
  }
  if (key == 'r') {
    addRocket();
  }
  if (key == 'b') {
    addBomb();
  }
}
