PImage ruin;
float r = random(1,10); //Værdier til size of point()
float q = random(-45,45); //Værdier til place of point()
float h = random(-10,10); // Random angles
int opa = 255; //Opacity - skal gå ned til 0 lidt efter lidt
Explosion [] bang = new Explosion[100]; // An array
boolean startAnimation = false;
float xMouseClick = 0;
float yMouseClick = 0;
int animationCount = 0;

void setup () { 
  size (600,600);
  smooth();

  ruin = loadImage ("ruins1.jpg");  //any image will do....  
  //initialize array
  
  for (int v = 0; v < bang.length; v++) { 
    bang[v] = new Explosion();
  }
}

void draw() {
  background(ruin);
  noStroke();
 if(startAnimation) { 
   opa = opa - 1;
   if(animationCount % 2 == 0){
   
   }else {
   
   }
    for (int v = 0; v < bang.length; v++) {
      bang[v].update();
      bang[v].checkEdges();
      bang[v].explode();
    }
  }
  
}
void mousePressed(){
   startAnimation = true;
}

void mouseReleased(){
  animationCount = animationCount + 1;
  startAnimation = false;
}

void mouseClicked(){
  xMouseClick = mouseX;
  yMouseClick = mouseY;
}

    
    class Explosion {
      
      PVector gravity;
      PVector location;
      PVector velocity;
      PVector acceleration;
      float maxspeed;
      
    Explosion() {
      location = new PVector(height/2,width/2);
      velocity = new PVector(random(-10,10),random(-10,10));
      gravity = new PVector (0.13,0.02);
      maxspeed = 8;
      acceleration = new PVector(0,0.1);
      point (xMouseClick + random(q,q), yMouseClick + random(q,q)); 
      
    }
    
    
    void update() {     //Bevægelses algoritme
      velocity.add (gravity);
      velocity.add (acceleration); //
      velocity.limit(maxspeed);
      location.add(velocity);
    }
    

    void explode() { 
     stroke(255,opa); // Farve på point() og opa
     smooth(); 


      if (mousePressed) {
        
        strokeWeight(r); // Size of point() 
        point (location.x,location.y); //Particles
        gravity.x = 0;
     
    }

    }
  
  
   void checkEdges() {
    
     // Bounce off walls
     if (location.x > width || location.x < 0) {
       
       velocity.x = velocity.x * -1;
       
     } 
  
    
    if (location.y > height || location.y < 0) {
     
      velocity.y = velocity.y * -1;
      
    }
   
    
   }
   
   void reset(){
     if(!startAnimation){
//       velocity.add (0);
//       velocity.add (0); //
//       velocity.limit(0);
//       location.add(0);
     }
   }
   
   }
   
   class SecondExplotion extends Explosion {
     
//     Explosion() {
//      location = new PVector(height/2,width/2);
//      velocity = new PVector(random(-10,10),random(-10,10));
//      gravity = new PVector (0.13,0.02);
//      maxspeed = 8;
//      acceleration = new PVector(0,0.1);
//      point (xMouseClick + random(q,q), yMouseClick + random(q,q)); 
//      
//    }
    
    
    void update() {     //Bevægelses algoritme
      velocity.add (gravity);
      velocity.add (acceleration); //
      velocity.limit(maxspeed);
      location.add(velocity);
    }
    

    void explode() { 
     stroke(255,opa); // Farve på point() og opa
     smooth(); 


      if (mousePressed) {
        
        strokeWeight(r); // Size of point() 
        point (location.x,location.y); //Particles
        gravity.x = 0;
     
    }

    }
  
  
   void checkEdges() {
    
     // Bounce off walls
     if (location.x > width || location.x < 0) {
       
       velocity.x = velocity.x * -1;
       
     } 
  
    
    if (location.y > height || location.y < 0) {
     
      velocity.y = velocity.y * -1;
      
    }
   
    
   }
   
   }
   
