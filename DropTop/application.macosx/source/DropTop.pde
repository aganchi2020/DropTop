// Arman H. Ganchi
//DropTop Game!

//import processing.sound.*;
//SoundFile song;
PImage pic;
color Cloud;
color base = color(143, 217, 245);
color yellow = color(249,250,20);
color orange = color(255, 159, 3);
color pink = color(255, 0, 222);

boolean Base, Yellow, Orange, Pink;
boolean left, right, up, down;
boolean easy, medium, hard, expert;

String gameState;
String helpNum;

float pointsNeeded;
float timer;
int badDropNum;

Player c;
Raindrops[] raindrop = new Raindrops[100];
Baddrops[] baddrop = new Baddrops[100];
Heart h;

//******************************** SETUP FUNCTION **********************************************************

void setup(){
  //pic = loadImage("cloud.icns");
  //surface.setIcon(pic);
  size(750, 850);
  background(0, 88, 118);
  smooth();
  frameRate(60);
  
  //song = new SoundFile(this, "cloud.mp3");
  
  c = new Player();
  
  h = new Heart();
  
  for (int i = 0; i < raindrop.length; i++) {
  raindrop[i] = new Raindrops();
}
  
  for (int i = 0; i < baddrop.length; i++) {
  baddrop[i] = new Baddrops();
}
  
  left = false;
  right = false;
  up = false;
  down = false;
  gameState = "START";
  timer = 0;
  
  
  Cloud = base;
  Base = true;
  Yellow = false;
  Pink = false;
  Orange = false;
  //song.play();
  
}

//******************************** DRAW FUNCTION **********************************************************

void draw(){
    background(0, 88, 118);
    if (gameState == "START"){
      startGame();
    } else if (gameState == "PLAY"){
      playGame();
    } else if (gameState == "WIN"){
      winGame();
    } else if (gameState == "LOSE"){
      loseGame();
    } else if (gameState == "CUSTOMIZE"){
      customize();
    }
    
    if (Base == true){
      Cloud = base;
    } else if (Yellow == true){
      Cloud = yellow;
    } else if (Pink == true){
      Cloud = pink;
    } else if (Orange == true){
      Cloud = orange;
    }
}

//******************************** START GAME **********************************************************
//initialization of key values
void startGame(){
    posX = 350;
    posY = 550;
    lives = 3;
    points = 0;
    easy = false;
    medium = false;
    hard = false;
    expert = false;
    HX = random(30, 720);
    HY = random(-2500,-3500);
    speY = 6;
  

    for (int i = 0; i < raindrop.length; i++) {
  raindrop[i].update();
}
    
    
    for (int i = 0; i < baddrop.length; i++) {
  baddrop[i].update();
  
}

 
 //player cloud 
  smooth();
    noStroke();
    fill(Cloud);
    ellipse(posX, posY, 50, 50);
    ellipse(posX+25, posY-5, 50, 50);
    ellipse(posX-25, posY+25, 50, 50);
    ellipse(posX, posY+30, 50, 50);
    ellipse(posX+25, posY+30, 50, 50);
    ellipse(posX+50, posY+25, 50, 50);
    
    //face
    strokeWeight(4);
    stroke(0); 
    arc(posX-10, posY-10, 10, 10, PI, 2*PI);
    arc(posX+10, posY-10, 10, 10, PI, 2*PI);
    stroke(255, 0, 0);
    arc(posX, posY, 10, 10, 0, PI);
    
    
    //cloud outlines
    stroke(0);
    strokeWeight(3);
    noFill();
    arc(posX+53, posY+28, 40, 40, 0, PI/2);
    arc(posX+28, posY+33, 40, 40, 0, PI/2);
    arc(posX+3, posY+33, 40, 40, 0, PI/2);
    arc(posX+28, posY+5, 40, 40, 0, PI/2);
    
    
    //Sky Clouds
    smooth();
    noStroke();
    fill(100);
    ellipseMode(CENTER);
    rectMode(CENTER);
    ellipse(20, 50, 150, 150);
    ellipse(110, 60, 150, 150);
    ellipse(210, 50, 150, 150);
    ellipse(300, 60, 150, 150);
    ellipse(390, 60, 150, 150);
    ellipse(490, 50, 150, 150);
    ellipse(590, 60, 150, 150);
    ellipse(690, 50, 150, 150);
    ellipse(780, 50, 150, 150);
    
    //outline sky clouds
    stroke(0, 125);
    strokeWeight(3);
    noFill();
    arc(20, 50, 150, 150, PI/4, PI);
    arc(110, 60, 150, 150, PI/4, 3*PI/4.1);
    arc(210, 50, 150, 150, PI/4, 3*PI/4);
    arc(300, 60, 150, 150, PI/3.3, 3*PI/4.1);
    arc(390, 60, 150, 150, PI/5, 3*PI/4);
    arc(490, 50, 150, 150, PI/3.3, 3*PI/4.3);
    arc(590, 60, 150, 150, PI/5.5, 3*PI/3.7);
    arc(690, 50, 150, 150, PI/3.3, 3*PI/4.3);
    arc(780, 50, 150, 150, PI/5.5, 3*PI/3.7);
    
    pushMatrix();
    rectMode(CENTER);
    fill(145, 250, 61);
    rect(210, 327.5, 125, 50);
    fill(232, 172, 19);
    rect(360, 327.5, 125, 50);
    fill(240, 44, 22);
    rect(510, 327.5, 125, 50);
    fill(0);
    stroke(255,0,0);
    rect(360, 398.5, 175, 50);
    stroke(100);
    fill(base);
    rect(360, 700, 200, 50);
    popMatrix();
    
    textSize(32);
    stroke(255);
    fill(255);
    text("Select a Difficulty to Start", 190, 465);
    
    textSize(100);
    text("DropTop", 185, 230); 
    fill(0);
    textSize(32);
    text("Easy", 180, 338);
    text("Medium", 305, 338);
    text("Hard", 475, 338);
    fill(175);
    text("Expert", 317, 409);
    fill(0);
    text("Customize", 292, 710);
    
    //navigating the Start Screen. Difficulty and Customize buttons
    if (mousePressed && mouseX > 147.5 && mouseX < 272.5 && mouseY > 302.5 && mouseY < 352.5){
      gameState = "PLAY";
      easy = true;
      pointsNeeded = 100;
      helpNum = "100";
      badDropNum = 20;
    }
    
    if (mousePressed && mouseX > 297.5 && mouseX < 422.5 && mouseY > 302.5 && mouseY < 352.5){
      gameState = "PLAY";
      medium = true;
      pointsNeeded = 150;
      helpNum = "150";
      badDropNum = 28;
    }
    
    if (mousePressed && mouseX > 447.5 && mouseX < 572.5 && mouseY > 302.5 && mouseY < 352.5){
      gameState = "PLAY";
      hard = true;
      pointsNeeded = 200;
      helpNum = "200";
      badDropNum = 35;
    }
    
    if (mousePressed && mouseX > 272.5 && mouseX < 447.5 && mouseY > 373.5 && mouseY < 423.5){
      gameState = "PLAY";
      expert = true;
      pointsNeeded = 250;
      helpNum = "250";
      badDropNum = 40;
    }
    
    if (mousePressed && mouseX > 260 && mouseX < 460 && mouseY > 675 && mouseY < 725){
      gameState = "CUSTOMIZE";
    }
    
}

//******************************** PLAY GAME **********************************************************

void playGame(){
   
      h.update();
      h.display();
  
    for (int i = 0; i < raindrop.length; i++) {
  raindrop[i].update();
  raindrop[i].display();
}
    
    
    for (int i = 0; i < badDropNum; i++) {
  baddrop[i].update();
  baddrop[i].display();
}
    
    c.update();
    c.display();
    
    
    
    if (lives == 0){
      gameState = "LOSE";
    } else if (points == pointsNeeded){
      gameState = "WIN";
    }

}

//******************************** LOSE GAME **********************************************************

void loseGame(){
      background(0, 88, 118);
      fill(255);
      stroke(255);
      textSize(50);
      text("You Lost!", 260, 350);
      text("Press Space To Try Again", 130, 425);
      
     
for (int i = 0; i < 100; i++) {
  baddrop[i].update();
  baddrop[i].display();
}     
      
    //player cloud  
    noStroke();
    fill(Cloud);
    
    ellipse(345, 475, 50, 50);
    ellipse(370, 470, 50, 50);
    ellipse(320, 500, 50, 50);
    ellipse(345, 505, 50, 50);
    ellipse(370, 505, 50, 50);
    ellipse(395, 500, 50, 50);
    
    //face
    strokeWeight(4);
    stroke(0);
    arc(335, 465, 10, 10, 0, PI);
    arc(355, 465, 10, 10, 0, PI);
    stroke(255, 0, 0);
    arc(345, 480, 10, 10, PI, TWO_PI);
    
    //player cloud outlines
    stroke(0);
    strokeWeight(3);
    noFill();
    arc(398, 503, 40, 40, 0, PI/2);
    arc(373, 508, 40, 40, 0, PI/2);
    arc(358, 508, 40, 40, 0, PI/2);
    arc(373, 480, 40, 40, 0, PI/2);
  
    //sky clouds  
    smooth();
    noStroke();
    fill(100);
    ellipseMode(CENTER);
    rectMode(CENTER);
    ellipse(20, 50, 150, 150);
    ellipse(110, 60, 150, 150);
    ellipse(210, 50, 150, 150);
    ellipse(300, 60, 150, 150);
    ellipse(390, 60, 150, 150);
    ellipse(490, 50, 150, 150);
    ellipse(590, 60, 150, 150);
    ellipse(690, 50, 150, 150);
    ellipse(780, 50, 150, 150);
    
    //outline sky clouds
    stroke(0, 125);
    strokeWeight(3);
    noFill();
    arc(20, 50, 150, 150, PI/4, PI);
    arc(110, 60, 150, 150, PI/4, 3*PI/4.1);
    arc(210, 50, 150, 150, PI/4, 3*PI/4);
    arc(300, 60, 150, 150, PI/3.3, 3*PI/4.1);
    arc(390, 60, 150, 150, PI/5, 3*PI/4);
    arc(490, 50, 150, 150, PI/3.3, 3*PI/4.3);
    arc(590, 60, 150, 150, PI/5.5, 3*PI/3.7);
    arc(690, 50, 150, 150, PI/3.3, 3*PI/4.3);
    arc(780, 50, 150, 150, PI/5.5, 3*PI/3.7);     
    
    if (easy == true){
      stroke(0, 125);
      fill(145, 250, 61);
      rectMode(CENTER);
      rect(675, 35, 125, 50);
      fill(0);
      textSize(32);
      text("Easy", 645, 45);
      
    } else if (medium == true){
      stroke(0, 125);
      fill(232, 172, 19);
      rectMode(CENTER);
      rect(675, 35, 125, 50);
      fill(0);
      textSize(32);
      text("Medium", 620, 45);
    } else if (hard == true){
      stroke(0, 125);
      fill(240, 44, 22);
      rectMode(CENTER);
      rect(675, 35, 125, 50);
      fill(0);
      textSize(32);
      text("Hard", 643, 45);
    } else if (expert == true){
      stroke(255, 0, 0);
      fill(0);
      rectMode(CENTER);
      rect(675, 35, 125, 50);
      fill(175);
      textSize(32);
      text("Expert", 630, 45);
    }
    
    stroke(255);
    fill(255);
    textSize(32);
    text(Points + points, 15, 40);
    
    if (keyCode == 32){
      gameState = "START";
    }
}

//******************************** WIN GAME **********************************************************

void winGame(){
    background(0, 88, 118);
    fill(255);
    stroke(255);
    textSize(50);
    text("You Won!", 260, 350);
    text("Press Space To Play Again", 120, 425);
    
    
    textSize(32);
    text(Points + points, 15, 40);

for (int i = 0; i < raindrop.length; i++) {
  raindrop[i].update();
  raindrop[i].display();
}
    
  smooth();
    
    
    //sun
    fill(234, 216, 5);
    stroke(222, 187, 9);
    ellipse(710, 40, 150, 150);
    strokeWeight(3);
    line(625, 40, 600, 40);
    line(635, 10, 600, 0);
    line(635, 70, 600, 90);
    line(655, 100, 640, 115);
    line(680, 115, 670, 145);
    line(715, 123, 715, 143);
    line(745, 115, 755, 143);
    
    //sun face
    ellipseMode(CENTER);
    stroke(0);
    noFill();
    strokeWeight(4);
    arc(665, 40, 30, 20, PI, TWO_PI);
    arc(720, 40, 30, 20, PI, TWO_PI);
    fill(0);
    arc(692.5, 60, 30, 20, 0, PI);
    
    //sky clouds
    noStroke();
    fill(230);
    rectMode(CENTER);
    ellipse(20, 50, 150, 150);
    ellipse(110, 60, 150, 150);
    ellipse(210, 50, 150, 150);
    ellipse(300, 60, 150, 150);
    ellipse(390, 60, 150, 150);
    ellipse(490, 50, 150, 150);
    //ellipse(590, 60, 150, 150);
    //ellipse(690, 50, 150, 150);
    //ellipse(780, 50, 150, 150);
    
    //outline sky clouds
    stroke(0, 125);
    strokeWeight(3);
    noFill();
    arc(20, 50, 150, 150, PI/4, PI);
    arc(110, 60, 150, 150, PI/4, 3*PI/4.1);
    arc(210, 50, 150, 150, PI/4, 3*PI/4);
    arc(300, 60, 150, 150, PI/3.3, 3*PI/4.1);
    arc(390, 60, 150, 150, PI/5, 3*PI/4);
    arc(490, 50, 150, 150, PI/3.3, 3*PI/4.3);
    //arc(590, 60, 150, 150, PI/5.5, 3*PI/3.7);
    //arc(690, 50, 150, 150, PI/3.3, 3*PI/4.3);
    //arc(780, 50, 150, 150, PI/5.5, 3*PI/3.7);
    
    
    //player cloud
    noStroke();
    fill(Cloud);
    
    ellipse(345, 475, 50, 50);
    ellipse(370, 470, 50, 50);
    ellipse(320, 500, 50, 50);
    ellipse(345, 505, 50, 50);
    ellipse(370, 505, 50, 50);
    ellipse(395, 500, 50, 50);
    
    //face
    strokeWeight(4);
    stroke(0);
    arc(335, 465, 10, 10, PI, 2*PI);
    arc(355, 465, 10, 10, PI, 2*PI);
    stroke(255, 0, 0);
    fill(255,0,0);
    arc(345, 475, 10, 10, 0, PI);
    
    
    //cloud outlines
    stroke(0);
    strokeWeight(3);
    noFill();
    arc(398, 503, 40, 40, 0, PI/2);
    arc(373, 508, 40, 40, 0, PI/2);
    arc(358, 508, 40, 40, 0, PI/2);
    arc(373, 480, 40, 40, 0, PI/2);
    
    if (keyCode == 32){
      gameState = "START";
    }
}


//******************************** CUSTOMIZE **********************************************************


void customize(){
  smooth();
    noStroke();
    fill(Cloud);
    ellipse(posX, posY, 50, 50);
    ellipse(posX+25, posY-5, 50, 50);
    ellipse(posX-25, posY+25, 50, 50);
    ellipse(posX, posY+30, 50, 50);
    ellipse(posX+25, posY+30, 50, 50);
    ellipse(posX+50, posY+25, 50, 50);
    
    //face
    strokeWeight(4);
    stroke(0); 
    arc(posX-10, posY-10, 10, 10, PI, 2*PI);
    arc(posX+10, posY-10, 10, 10, PI, 2*PI);
    stroke(255, 0, 0);
    arc(posX, posY, 10, 10, 0, PI);
    
    
    //cloud outlines
    stroke(0);
    strokeWeight(3);
    noFill();
    arc(posX+53, posY+28, 40, 40, 0, PI/2);
    arc(posX+28, posY+33, 40, 40, 0, PI/2);
    arc(posX+3, posY+33, 40, 40, 0, PI/2);
    arc(posX+28, posY+5, 40, 40, 0, PI/2);
    
    
    //Sky Clouds
    smooth();
    noStroke();
    fill(100);
    ellipseMode(CENTER);
    rectMode(CENTER);
    ellipse(20, 50, 150, 150);
    ellipse(110, 60, 150, 150);
    ellipse(210, 50, 150, 150);
    ellipse(300, 60, 150, 150);
    ellipse(390, 60, 150, 150);
    ellipse(490, 50, 150, 150);
    ellipse(590, 60, 150, 150);
    ellipse(690, 50, 150, 150);
    ellipse(780, 50, 150, 150);
    
    //outline sky clouds
    stroke(0, 125);
    strokeWeight(3);
    noFill();
    arc(20, 50, 150, 150, PI/4, PI);
    arc(110, 60, 150, 150, PI/4, 3*PI/4.1);
    arc(210, 50, 150, 150, PI/4, 3*PI/4);
    arc(300, 60, 150, 150, PI/3.3, 3*PI/4.1);
    arc(390, 60, 150, 150, PI/5, 3*PI/4);
    arc(490, 50, 150, 150, PI/3.3, 3*PI/4.3);
    arc(590, 60, 150, 150, PI/5.5, 3*PI/3.7);
    arc(690, 50, 150, 150, PI/3.3, 3*PI/4.3);
    arc(780, 50, 150, 150, PI/5.5, 3*PI/3.7);
  
    stroke(100);
    fill(base);
    rect(360, 650, 200, 50);
    textSize(32);
    fill(0);
    text("Main Menu", 290, 660);
    
    textSize(32);
    stroke(255);
    fill(255);
    text("Select a Color", 270, 465);
    
    textSize(100);
    text("DropTop", 185, 230); 
    
    stroke(0, 180);
    fill(base);
    rect(150, 350, 100, 100);
    fill(orange);
    rect(300, 350, 100, 100);
    fill(yellow);
    rect(450, 350, 100, 100);
    fill(pink);
    rect(600, 350, 100, 100);
    
    if (mousePressed && mouseX > 260 && mouseX < 460 && mouseY > 625 && mouseY < 675){
      gameState = "START";
    }
    
    if (mousePressed && mouseX > 100 && mouseX < 200 && mouseY > 300 && mouseY < 400){
      Base = true;
      Orange = false;
      Yellow = false;
      Pink = false;
    }
    
    if (mousePressed && mouseX > 250 && mouseX < 350 && mouseY > 300 && mouseY < 400){
      Base = false;
      Orange = true;
      Yellow = false;
      Pink = false;
    }
    
    if (mousePressed && mouseX > 400 && mouseX < 500 && mouseY > 300 && mouseY < 400){
      Base = false;
      Orange = false;
      Yellow = true;
      Pink = false;
    }
    
    if (mousePressed && mouseX > 550 && mouseX < 650 && mouseY > 300 && mouseY < 400){
      Base = false;
      Orange = false;
      Yellow = false;
      Pink = true;
    }
  
}


//******************************** CUSTOMIZE **********************************************************


//movement code
void keyPressed(){
  switch(keyCode) {
    case 37: //left
      left = true;
      break;
    case 38: //up
      up = true;
      break;
    case 39: //right
      right = true;
      break;
    case 40: //down
      down = true;
      break;
  }  
}

//movement code
void keyReleased(){
  switch(keyCode) {
    case 37: //left
      left = false;
      break;
    case 38: //up
      up = false;
      break;
    case 39: //right
      right = false;
      break;
    case 40: //down
      down = false;
      break;
  }
}
