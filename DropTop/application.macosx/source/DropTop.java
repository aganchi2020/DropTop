/* autogenerated by Processing revision 1276 on 2021-11-14 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class DropTop extends PApplet {

// Arman H. Ganchi
//DropTop Game!

//import processing.sound.*;
//SoundFile song;
PImage pic;
int Cloud;
int base = color(143, 217, 245);
int yellow = color(249,250,20);
int orange = color(255, 159, 3);
int pink = color(255, 0, 222);

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

 public void setup(){
  //pic = loadImage("cloud.icns");
  //surface.setIcon(pic);
  /* size commented out by preprocessor */;
  background(0, 88, 118);
  /* smooth commented out by preprocessor */;
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

 public void draw(){
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
 public void startGame(){
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
    arc(110, 60, 150, 150, PI/4, 3*PI/4.1f);
    arc(210, 50, 150, 150, PI/4, 3*PI/4);
    arc(300, 60, 150, 150, PI/3.3f, 3*PI/4.1f);
    arc(390, 60, 150, 150, PI/5, 3*PI/4);
    arc(490, 50, 150, 150, PI/3.3f, 3*PI/4.3f);
    arc(590, 60, 150, 150, PI/5.5f, 3*PI/3.7f);
    arc(690, 50, 150, 150, PI/3.3f, 3*PI/4.3f);
    arc(780, 50, 150, 150, PI/5.5f, 3*PI/3.7f);
    
    pushMatrix();
    rectMode(CENTER);
    fill(145, 250, 61);
    rect(210, 327.5f, 125, 50);
    fill(232, 172, 19);
    rect(360, 327.5f, 125, 50);
    fill(240, 44, 22);
    rect(510, 327.5f, 125, 50);
    fill(0);
    stroke(255,0,0);
    rect(360, 398.5f, 175, 50);
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
    if (mousePressed && mouseX > 147.5f && mouseX < 272.5f && mouseY > 302.5f && mouseY < 352.5f){
      gameState = "PLAY";
      easy = true;
      pointsNeeded = 100;
      helpNum = "100";
      badDropNum = 20;
    }
    
    if (mousePressed && mouseX > 297.5f && mouseX < 422.5f && mouseY > 302.5f && mouseY < 352.5f){
      gameState = "PLAY";
      medium = true;
      pointsNeeded = 150;
      helpNum = "150";
      badDropNum = 28;
    }
    
    if (mousePressed && mouseX > 447.5f && mouseX < 572.5f && mouseY > 302.5f && mouseY < 352.5f){
      gameState = "PLAY";
      hard = true;
      pointsNeeded = 200;
      helpNum = "200";
      badDropNum = 35;
    }
    
    if (mousePressed && mouseX > 272.5f && mouseX < 447.5f && mouseY > 373.5f && mouseY < 423.5f){
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

 public void playGame(){
   
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

 public void loseGame(){
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
    arc(110, 60, 150, 150, PI/4, 3*PI/4.1f);
    arc(210, 50, 150, 150, PI/4, 3*PI/4);
    arc(300, 60, 150, 150, PI/3.3f, 3*PI/4.1f);
    arc(390, 60, 150, 150, PI/5, 3*PI/4);
    arc(490, 50, 150, 150, PI/3.3f, 3*PI/4.3f);
    arc(590, 60, 150, 150, PI/5.5f, 3*PI/3.7f);
    arc(690, 50, 150, 150, PI/3.3f, 3*PI/4.3f);
    arc(780, 50, 150, 150, PI/5.5f, 3*PI/3.7f);     
    
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

 public void winGame(){
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
    arc(692.5f, 60, 30, 20, 0, PI);
    
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
    arc(110, 60, 150, 150, PI/4, 3*PI/4.1f);
    arc(210, 50, 150, 150, PI/4, 3*PI/4);
    arc(300, 60, 150, 150, PI/3.3f, 3*PI/4.1f);
    arc(390, 60, 150, 150, PI/5, 3*PI/4);
    arc(490, 50, 150, 150, PI/3.3f, 3*PI/4.3f);
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


 public void customize(){
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
    arc(110, 60, 150, 150, PI/4, 3*PI/4.1f);
    arc(210, 50, 150, 150, PI/4, 3*PI/4);
    arc(300, 60, 150, 150, PI/3.3f, 3*PI/4.1f);
    arc(390, 60, 150, 150, PI/5, 3*PI/4);
    arc(490, 50, 150, 150, PI/3.3f, 3*PI/4.3f);
    arc(590, 60, 150, 150, PI/5.5f, 3*PI/3.7f);
    arc(690, 50, 150, 150, PI/3.3f, 3*PI/4.3f);
    arc(780, 50, 150, 150, PI/5.5f, 3*PI/3.7f);
  
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
 public void keyPressed(){
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
 public void keyReleased(){
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
  
  
   public void update(){
    
    Y = Y + VY;
    VY = VY + 0.01f;
    
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
  
  
   public void display(){
    stroke(185, 0, 28);
    strokeWeight(5);
    line(X, Y, X, Y+length); 
    
  }
  
  
}
float HX, HY;
float speY;

class Heart{

  Heart(){
    HX = random(30, 720);
    HY = random(-2500,-3500);
    speY = 6;
  }
  
   public void update(){
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
  
   public void display(){
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
class Plane{
 float x, y, vx, vy;
 
 Plane(){
   x = random(50, 700);
   y = random(0, 145);
   vx = 0;
   vy = 0;
 }
   
   
    public void update(){
   
   }
   
   
    public void display(){
   
   }
   
   
    public void chase(float chaseX, float chaseY){
   
   }
 
}
float posX, posY;
float speedX, speedY, maxSpeed;
int points;
String Points;
int lives;
String Lives;

class Player{
  //properties
    
  
  //constructor
  Player(){
    posX = 350;
    posY = 550;
    maxSpeed = 7;
    speedX = 0;
    speedY = 0;
    Points = "Drops: ";
    Lives = ": x";
  }
  
  //methods
   public void update(){
    
    //horizontal movement
    if(left){ speedX = -maxSpeed;}
    
    if(right){speedX = maxSpeed;}
    
    if((!left && !right) || (left && right)){speedX = 0;}
    
    
    //vertical movement
    if (up){speedY = -maxSpeed;}
    
    if (down){speedY = maxSpeed;}
    
    if ((!up && !down) || (up && down)){speedY = 0;}
    
    checkBounds();
    
    //update position
    posX = posX + speedX;
    posY = posY + speedY;
    timer = timer + 0.01666667f;
  }
  
   public void display(){
   
    
    //Player cloud
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
    arc(110, 60, 150, 150, PI/4, 3*PI/4.1f);
    arc(210, 50, 150, 150, PI/4, 3*PI/4);
    arc(300, 60, 150, 150, PI/3.3f, 3*PI/4.1f);
    arc(390, 60, 150, 150, PI/5, 3*PI/4);
    arc(490, 50, 150, 150, PI/3.3f, 3*PI/4.3f);
    arc(590, 60, 150, 150, PI/5.5f, 3*PI/3.7f);
    arc(690, 50, 150, 150, PI/3.3f, 3*PI/4.3f);
    arc(780, 50, 150, 150, PI/5.5f, 3*PI/3.7f);
    
    //cloud hitbox
    rectMode(CORNERS);
    noStroke();
    fill(0, 0);
    rect(posX - 50, posY - 30, posX + 75, posY + 55);
 
   //point system and other text
    stroke(255);
    fill(255);
    textSize(32);
    text(Points + points, 15, 40);
    text(Lives, 55, 80);
   
   // cloud life icon
    pushMatrix();
    noStroke();
    fill(Cloud);
    ellipse(30, 69, 15, 15);
    ellipse(37, 68, 15, 15);
    ellipse(42, 73, 15, 15);
    ellipse(38, 75, 15, 15);
    ellipse(30, 75, 15, 15);
    ellipse(25, 72, 15, 15);
    popMatrix();
    
    //life counter modifier
    if(lives == 10){
      Lives = ": x10"; 
    }
    
    if(lives == 9){
      Lives = ": x9"; 
    }
    
    if(lives == 8){
      Lives = ": x8"; 
    }
    
    if(lives == 7){
      Lives = ": x7"; 
    }
    
    if(lives == 6){
      Lives = ": x6"; 
    }
    
    if(lives == 5){
      Lives = ": x5"; 
    }
    
    if(lives == 4){
      Lives = ": x4"; 
    }
    
    if(lives == 3){
      Lives = ": x3"; 
    }
    
    if(lives == 2){
      Lives = ": x2"; 
    }
    
    if(lives == 1){
      Lives = ": x1";
    }
    
    
    //catch raindrops to win
    stroke(255, 200);
    fill(255);
    textSize(20);
    text("Catch " + helpNum + " Raindrops to Win", 260, 30);
    stroke(255,0,0);
    line(310, 35, 345, 35);
    
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
    
  }
  //screen barriers
   public void checkBounds(){
    if (posX > width- 50){posX = width - 50;}
    if (posX < 20){posX = 20;}
    if (posY > height- 50){posY = height - 50;}
    if (posY < 145){posY = 145;}
  }

}


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
  
  
   public void update(){
    y = y + vy;
    vy = vy + 0.01f;
    
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
  
   public void display(){
    stroke(157, 230, 255);
    strokeWeight(5);
    line(x, y, x, y+len); 
    
  
  }
}


  public void settings() { size(750, 850);
smooth(); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DropTop" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}