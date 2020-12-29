// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/CKeyIbT3vXI

import peasy.*;
import processing.sound.*;
import processing.net.*;

ArrayList<Firework> fireworks;

Server httpServer;

PVector gravity = new PVector(0, 0, -0.1);

Playground playground;

PeasyCam camera;

void setup() {
  fullScreen(P3D);
  //size(800, 600, P3D);
  camera = new PeasyCam(this, 0, 1500, 200, 700);
  camera.rotateX(-1.79);
  camera.setPitchRotationMode();

  colorMode(HSB);
  
  playground = new Playground();
  
  httpServer = new Server(this, 8080);
  
  thread("checkForClients");
  
  this.fireworks = new ArrayList<Firework>();
}

// zeichnen
void draw() {
  background(0);

  playground.display();
  
  // running firework
  for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework firework = fireworks.get(i);
    if (firework.isDead()) {
      fireworks.remove(i);
    }
    firework.doOneCycle();
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
