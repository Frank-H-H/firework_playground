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

PeasyCam camera;

void setup() {
  fullScreen(P3D);
  //size(800, 600, P3D);
  camera = new PeasyCam(this, 0, 0, 500, 1500);
  camera.rotateX(-1.7);
  camera.setYawRotationMode();

  colorMode(HSB);
  background(0);
  
  httpServer = new Server(this, 8080);
  
  thread("checkForClients");
  
  this.fireworks = new ArrayList<Firework>();
}

// zeichnen
void draw() {
  if (random(1) < 0.01) {
  }

  background(0);
  rotateZ(frameCount*0.003);

  // Floor
  stroke(100);
  strokeWeight(1);
  fill(20);
  beginShape();
  vertex(-500, -500, 0);
  vertex(-500, 500, 0);
  vertex(500, 500, 0);
  vertex(500, -500, 0);
  endShape(CLOSE);
  
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
  this.fireworks.add(new Volcano());
}

void keyPressed() {
  this.fireworks.add(new Volcano());
}
