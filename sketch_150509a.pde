PImage ruin;
float r = random(1,10); //Værdier til size of point()
float q = random(-45,45); //Værdier til place of point()
float h = random(-10,10); // Random angles
int opa = 255; //Opacity - skal gå ned til 0 lidt efter lidt

ArrayList<ExplosionHandler> systems;

//Explosion [] bang = new Explosion[100]; // An array

boolean startAnimation = false;
float xMouseClick = 0;
float yMouseClick = 0;
int animationCount = 0;

void setup () { 
  size (600,600);
  smooth();

  ruin = loadImage ("ruins1.jpg");  //any image will do....  
  //initialize array
  //lets init an empty array list for the Explosion handler class
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
    fill(255);
    textAlign(CENTER);
    text("Attack ?", width/2, height/2);
  }  
}

void mousePressed(){
  systems.add(new ExplosionHandler(1, new PVector(mouseX, mouseY)));
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
  float seta;
  
  SecondExplosion(PVector l){
    super(l);
    seta = 0.0;
  }
  
  void update(){
    super.update();
    float vel = (velocity.x * velocity.mag() / 10.0f);
  }
  
  void display(){
    super.display();
    pushMatrix();
    translate(location.x, location.y);
    rotate(seta);
    stroke(255, lifespan);
    line(0, 0 , 23, 0);
    popMatrix();
  }
  
}

class Explosion{
  
  PVector gravity;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  
  Explosion(PVector l ){
    acceleration = new PVector(0, 0.05);
    location = l.get();
//    print(l.get());
    velocity = new PVector(random(-10,10),random(-10,10));
    gravity = new PVector (0.13,0.02);
    lifespan = 1.2;
//    maxspeed = 8;
//    acceleration = new PVector(0,0.1);
//    point (location.x + random(q,q), location.x + random(q,q)); 
  }
  
  void run(){
    update();
    display();
  }
  
  void update(){
    velocity.add(acceleration);
    velocity.limit(8);
    location.add(velocity);
    lifespan -= 1.0;
    
  }
  
  void display(){
//    print(lifespan);
    noSmooth();
    stroke(255, lifespan);
    fill(255, lifespan);
    point(location.x, location.y);
//    ellipse(location.x, location.y, 8, 8);
  }
  
  boolean isDead(){
    return (lifespan < 0.0);
  }
  
}
    
    
//    class Explosion {
//      
//      PVector gravity;
//      PVector location;
//      PVector velocity;
//      PVector acceleration;
//      float maxspeed;
//      
//    Explosion() {
//      location = new PVector(height/2,width/2);
//      velocity = new PVector(random(-10,10),random(-10,10));
//      gravity = new PVector (0.13,0.02);
//      maxspeed = 8;
//      acceleration = new PVector(0,0.1);
//      point (xMouseClick + random(q,q), yMouseClick + random(q,q)); 
//      
//    }
//    
//    
//    void update() {     //Bevægelses algoritme
//      velocity.add (gravity);
//      velocity.add (acceleration); //
//      velocity.limit(maxspeed);
//      location.add(velocity);
//    }
//    
//
//    void explode() { 
//     stroke(255,opa); // Farve på point() og opa
//     smooth(); 
//
//
//      if (mousePressed) {
//        
//        strokeWeight(r); // Size of point() 
//        point (location.x,location.y); //Particles
//        gravity.x = 0;
//     
//    }
//
//    }
//  
//  
//   void checkEdges() {
//    
//     // Bounce off walls
//     if (location.x > width || location.x < 0) {
//       
//       velocity.x = velocity.x * -1;
//       
//     } 
//  
//    
//    if (location.y > height || location.y < 0) {
//     
//      velocity.y = velocity.y * -1;
//      
//    }
//   
//    
//   }
//   
//   void reset(){
//     if(!startAnimation){
////       velocity.add (0);
////       velocity.add (0); //
////       velocity.limit(0);
////       location.add(0);
//     }
//   }
//   
//   }
//   
