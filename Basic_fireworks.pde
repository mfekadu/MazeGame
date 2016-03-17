//Example for the firework lab for CSC 123 - zj wood

//define a particle
class Particle {
  
  PVector loc;
  PVector vel;
  PVector accel;
  float r;
  float life;
  PVector pcolor;
  
  //constructor
  Particle(PVector start, PVector in_c) {
    accel = new PVector(0, 0.05, 0); //gravity
    vel = new PVector(random(-1, 1), random(-2, 0), 0);
    pcolor = in_c.get();
    pcolor.x += random(-18, 18);
    pcolor.y += random(-18, 18);
    pcolor.z += random(-18, 18);
    loc = start.get();
    r = 8.0;
    life = 100;
  }
  
    //constructor
  Particle(PVector start) {
    accel = new PVector(0, 0.05, 0); //gravity
    vel = new PVector(random(-2, 2), random(-6, 0), 0);
    pcolor = new PVector(random(255), random(255), random(255));
    loc = start.get();
    r = 8.0;
    life = 100;
  }
  
  //what to do each frame
  void run() {
    updateP();
    renderP();
  }
  
  void stopDraw() {
    renderP();
  }
  
  //how to move
  void updateP() {
    vel.add(accel);
    loc.add(vel);
    life -= 1.0;
    r -= 0.05;
  }
  
  //how to draw a particle
  void renderP() {
    pushMatrix();
      ellipseMode(CENTER);
      stroke(pcolor.x, pcolor.y, pcolor.z, life*2);
      fill(pcolor.x, pcolor.y, pcolor.z, life/1.2);
      translate(loc.x, loc.y);
      rotate(vel.heading2D());
      ellipse(0, 0, vel.mag()*1.5*r, r);
    popMatrix();
  }
  
  boolean alive() {
    if (life <= 0.0) {
      return false;
    } else {
      return true;
    }
  }
} //end of particle object definition


//define a group of particles as a particleSys
class PSys{
  ArrayList particles; //all the particles
  PVector source; //where all the particles emit from
  PVector shade;
  
  //constructor
  PSys(int num, PVector init_loc) {
    particles = new ArrayList();
    source = init_loc.get();
    shade = new PVector(random(255), random(255), random(255));
    for (int i=0; i < num; i++) {
      particles.add(new Particle(source, shade));
    }
  }
    
    //what to do each frame
    void run() {
      //go through backwards for deletes
      for (int i=particles.size()-1; i >=0; i--) {
        Particle p = (Particle) particles.get(i);
        //update each particle per frame
        p.run();
        if ( !p.alive()) {
          particles.remove(i);
        }
      }
    }
    
    void stopDraw() {
      for (int i=0; i < particles.size(); i++) {
        Particle p = (Particle) particles.get(i);
        p.stopDraw();
      }
    }
    
    
    //options for adding particles to the system - default
    void addParticle() {
      particles.add(new Particle(source));
    }
    
    //add at a specific point
    void addParticle(float x, float y) {
      particles.add(new Particle(new PVector(x, y)));
    }
    
    //add for an already defined particle
    void addParticle(Particle p) {
      particles.add(p);
    }
    
    //is particle still populated?
    boolean dead() {
        if (particles.isEmpty() ) {
          return true;
        } else {
          return false;
        }
    }
}

//declare a particle system
/*PSys fireW[];
int frame;
int numF, numA;

void setup() {
  size(500, 500);
  colorMode(RGB, 255, 255, 255, 100);
  numF = 6;
  fireW = new PSys[numF];
  for (int i= 0; i < numF; i++) {
    fireW[i] = new PSys(100, new PVector(random(width-20), random(height/2), 0));
  }
  smooth();
  frame = 0;
  frameRate(40);
  numA = 1;
}

void draw() {
  background(0);
  if (mousePressed !=true) {

    if (frame%20 ==0 && numA < numF) {
      numA++;
    }
    
    for (int i= 0; i < numA; i++) {
      fireW[i].run();
      if (fireW[i].dead() == true) {
        fireW[i] = new PSys(100, new PVector(random(width-20), random(height/2), 0));
      }
    }
      
    frame++;
 
  } else {

    for (int i= 0; i < numF; i++) {
      fireW[i].stopDraw();
    }
    //saveFrame("Fireworks.jpg");
  
  }

  
}*/
