

class Raindrops{
  float x, y, vx, vy;
float len; 
  
  
  Raindrops(){
    x = random(10, 740);
    y = random(-2000, 0);
    vx = 0;
    vy = random(3, 7);
    len = random(10, 20);
    points = 0;
    
  }
  
  
  void update(){
    y = y + vy;
    vy = vy + 0.01;
    
    if (y > height) {
      y = random(-2000, 100);
      vy = random(3, 7);
      x = random(10, 740);
    } 


    if (gameState == "PLAY" && x > posX - 50  &&  x < posX + 75  &&  y > posY - 30  &&  y < posY + 55){
        y = random(-2000, 100);
        vy = random(3, 7);
        x = random(10, 740);
        points = points + 1;
       }

    if (gameState == "START"){
      x = random(10, 740);
      y = random(-2000, 0);
      vx = 0;
      vy = random(3, 7);
    } 
    
    
  }
  
  void display(){
    stroke(157, 230, 255);
    strokeWeight(5);
    line(x, y, x, y+len); 
    
  
  }
}
