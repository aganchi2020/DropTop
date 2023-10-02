class Baddrops{
float length;
float VX, VY; 
float X, Y;

  Baddrops(){
    X = random(10, 740);
    Y = random(-2000, 0);
    VX = 0;
    VY = random(3, 7);
    length = random(20, 30);
    lives = 3;
    
  }
  
  
  void update(){
    
    Y = Y + VY;
    VY = VY + 0.01;
    
    if (Y > height) {
      Y = random(-2000, 100);
      VY = random(3, 7);
      X = random(10, 740);
    } 
    
    if (gameState == "PLAY" && X > posX - 50  &&  X < posX + 75  &&  Y > posY - 30  &&  Y < posY + 55){
        Y = random(-2000, 100);
        VY = random(3, 7);
        X = random(10, 740);
        lives = lives - 1;
       }
       
    if (gameState == "START"){
      X = random(10, 740);
      Y = random(-2000, 0);
      VX = 0;
      VY = random(3, 7);
    } 
    
  }
  
  
  void display(){
    stroke(185, 0, 28);
    strokeWeight(5);
    line(X, Y, X, Y+length); 
    
  }
  
  
}
