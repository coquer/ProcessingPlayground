PImage ruin;
float r = random(10,18); //Værdier til size of point()
float q = random(-45,45); //Værdier til place of point()
float h = random(-10,10); // Random angles


ArrayList<ExplosionHandler> systems;

boolean startAnimation = false;
float xMouseClick = 0;
float yMouseClick = 0;
int animationCount = 0;

void setup () { 
  size (600,600);
  smooth();
  ruin = loadImage ("ruins1.jpg");  //any image will do....  
  systems = new ArrayList<ExplosionHandler>();
}

void draw() {
  background(ruin);
  noStroke();
  for(ExplosionHandler eh: systems){
    eh.run();
    eh.addExplosion();
    
  }

  if(systems.isEmpty()){
    fill(10,255,100);
    textAlign(CENTER);
    text("Explode me ?", width/2+30, height/2-10);
  }  
}

void mousePressed(){
  systems.add(new ExplosionHandler(1, new PVector(mouseX, mouseY)));
  r=random(1,10);
}

class ExplosionHandler{
  ArrayList<Explosion> Explosions;
  PVector origin;
  
  ExplosionHandler(int num, PVector v){
    Explosions = new ArrayList<Explosion>();
    origin = v.get();
    for(int y = 0; y < num; y++){
      Explosions.add(new Explosion(origin));
    }
  }
  
  void run(){
    for(int x = Explosions.size() - 1; x >= 0; x--){
      Explosion e = Explosions.get(x);
      e.run();
      if(e.isDead()){
        Explosions.remove(x);
      }
    }
  }
  
  void addExplosion(){
    Explosion e;
    if(int(random(0, 2)) == 0 ){
      e = new Explosion(origin);
    }else{
      e = new SecondExplosion(origin);
    }
    Explosions.add(e);
  }
  
  void addExplosion(Explosion e){
    Explosions.add(e);
  }
  
  boolean dead(){
    return Explosions.isEmpty();
  }
  
}

class SecondExplosion extends Explosion {
  
  
  SecondExplosion(PVector l){
    super(l);
    
  }
  
  void update(){
    super.update();
    float vel = (velocity.x * velocity.mag() / 10.0f);
  }
  
  void display(){
    super.display(); 
    pushMatrix(); //saves the current coordinate system to the stack 
    translate(location.x, location.y);
    fill(10, 255, 255,0);
    line(0, 0 , 0, 0);
    popMatrix(); //restores the prior coordinate system
  }
  
}

class Explosion{
  
  PVector gravity;
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector friction;
  float lifespan;
  
  Explosion(PVector l ){
    acceleration = new PVector(0, 0.05);
    location = l.get();
    velocity = new PVector(random(-5,5),random(-5,5));
    gravity = new PVector (0.0000,0.12);
    lifespan = 50.0;
    friction = new PVector(-1,-1);
  }
  
  void run(){
    update();
    display();
    checkEdges();
  }
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    velocity.add (gravity);
    lifespan -= 1.0;
    
  }
  
  void display(){
    noSmooth();
    //RGB(221, 197, 186)
    stroke(0, 120, 235, lifespan);
   // fill(0, 250, 250, lifespan);
    strokeWeight(r); // Size of point() 
    point (location.x,location.y); //Particles
  }
  
  boolean isDead(){
    return (lifespan < 0.0);
  }
  
  void checkEdges() {
     if ( location.x > width) {
       location.x = width;
       velocity.x *= -1;
     }
     else if( location.x <0) {
       velocity.x *= -1;
       location.x = 0;
     }
     
     if ( location.y > height) {
       velocity.y *= -1;
       location.y = height;
     }
   
   
   
    
    }
   }
