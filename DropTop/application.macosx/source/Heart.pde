float HX, HY;
float speY;

class Heart{

  Heart(){
    HX = random(30, 720);
    HY = random(-2500,-3500);
    speY = 6;
  }
  
  void update(){
    HY = HY + speY;
    
    if (HY > height) {
      HY = random(-2500, -3500);
      speY = 6;
      HX = random(30, 720);
    } 
    
    
    if (HX > posX - 50  &&  HX < posX + 75  &&  HY > posY - 30  &&  HY < posY + 55){
        HY = random(-2500, -3500);
        speY = 6;
        HX = random(30, 720);
        lives = lives + 1;
       }
    
    
  }
  
  void display(){
    noStroke();
    fill(212, 175, 55);
    ellipse(HX, HY, 15, 15);
    ellipse(HX + 7, HY - 1, 15, 15);
    ellipse(HX + 12, HY + 4, 15, 15);
    ellipse(HX + 8, HY + 6, 15, 15);
    ellipse(HX, HY + 6, 15, 15);
    ellipse(HX - 5, HY + 3, 15, 15);
  }
}
