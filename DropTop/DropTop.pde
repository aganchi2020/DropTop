//Arman H. Ganchi
//import processing.sound.*;
//SoundFile song;
PImage pic;
color Cloud;
color Stripes;
color Dots;
color outline;
color base = color(143, 217, 245);
color yellow = color(249, 250, 20);
color orange = color(255, 159, 3);
color pink = color(255, 0, 222);
color green = color(24, 211, 0);
color dBlue = color(255);
color grey = color(121, 160, 157);
color purple = color(111, 5, 234);
color red = color(255,0,0);
color black = color(0);


boolean Stripe, Dot, colorSelector;
boolean left, right, up, down;
boolean easy, medium, hard, expert;

String gameState;
String helpNum;

float pointsNeeded;

int badDropNum, filled, filled2;

Player c;
Raindrops[] raindrop = new Raindrops[100];
Baddrops[] baddrop = new Baddrops[100];
Heart h;

//******************************** SETUP FUNCTION **********************************************************

void setup() {
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



  Cloud = base;
  filled = 255;
  filled2 = 255;
  Stripes = color(0, 0, 0, filled);
  Dots = color(0, 0, 0, filled2);
  outline = color(0,0,0);
  colorSelector = true;
  Stripe = false;
  Dot = false;
  //song.play();
}

//******************************** DRAW FUNCTION **********************************************************

void draw() {
  background(0, 88, 118);
  if (gameState == "START") {
    startGame();
  } else if (gameState == "PLAY") {
    playGame();
  } else if (gameState == "WIN") {
    winGame();
  } else if (gameState == "LOSE") {
    loseGame();
  } else if (gameState == "CUSTOMIZE") {
    customize();
  }
}

//******************************** START GAME **********************************************************
//initialization of key values
void startGame() {
  posX = 350;
  posY = 550;
  lives = 3;
  points = 0;
  easy = false;
  medium = false;
  hard = false;
  expert = false;
  HX = random(30, 720);
  HY = random(-2500, -3500);
  speY = 6;

  for (int i = 0; i < raindrop.length; i++) {
    raindrop[i].update();
  }

  for (int i = 0; i < baddrop.length; i++) {
    baddrop[i].update();
  }

  //player cloud
  drawCloud();

  noFill();
  strokeWeight(3);
  stroke(0);
  arc(posX-3, posY-10, 10, 10, PI, 2*PI);
  arc(posX+17, posY-10, 10, 10, PI, 2*PI);
  stroke(255, 0, 0);
  arc(posX+7, posY, 10, 10, 0, PI);

  if (Dot == false && Stripe == false) {
    stroke(outline);
    strokeWeight(2);
    noFill();
    arc(posX+60, posY+28, 40, 40, 0, PI/2);
    arc(posX+35, posY+33, 40, 40, 0, PI/2);
    arc(posX+10, posY+33, 40, 40, 0, PI/2);
    arc(posX+35, posY+5, 40, 40, 0, PI/2);
  }

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
  stroke(255, 0, 0);
  rect(360, 398.5, 175, 50);
  stroke(100);
  fill(base);
  rect(width/2, 700, 200, 50);
  popMatrix();

  textAlign(CENTER);
  textSize(32);
  stroke(255);
  fill(255);
  text("Select a Difficulty to Start", width/2, 465);
  textSize(24);
  text("Collect the blue drops, and avoid the red drops", width/2, 775);
  text("Use the arrow keys to move", width/2, 800);

  textSize(100);
  text("DropTop", width/2, 230);
  fill(0);
  textSize(32);
  text("Easy", 210, 338);
  text("Medium", 360, 338);
  text("Hard", 510, 338);
  fill(175);
  text("Expert", 360, 409);
  fill(0);
  text("Customize", width/2, 710);


  //navigating the Start Screen. Difficulty and Customize buttons
  if (mousePressed && mouseX > 147.5 && mouseX < 272.5 && mouseY > 302.5 && mouseY < 352.5) {
    gameState = "PLAY";
    easy = true;
    pointsNeeded = 100;
    helpNum = "100";
    badDropNum = 20;
  }

  if (mousePressed && mouseX > 297.5 && mouseX < 422.5 && mouseY > 302.5 && mouseY < 352.5) {
    gameState = "PLAY";
    medium = true;
    pointsNeeded = 150;
    helpNum = "150";
    badDropNum = 28;
  }

  if (mousePressed && mouseX > 447.5 && mouseX < 572.5 && mouseY > 302.5 && mouseY < 352.5) {
    gameState = "PLAY";
    hard = true;
    pointsNeeded = 200;
    helpNum = "200";
    badDropNum = 35;
  }

  if (mousePressed && mouseX > 272.5 && mouseX < 447.5 && mouseY > 373.5 && mouseY < 423.5) {
    gameState = "PLAY";
    expert = true;
    pointsNeeded = 250;
    helpNum = "250";
    badDropNum = 40;
  }

  if (mousePressed && mouseX > 275 && mouseX < 475 && mouseY > 675 && mouseY < 725) {
    gameState = "CUSTOMIZE";
  }
}

//******************************** PLAY GAME **********************************************************

void playGame() {
  textAlign(CORNER);
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



  if (lives == 0) {
    gameState = "LOSE";
  } else if (points == pointsNeeded) {
    gameState = "WIN";
  }
}

//******************************** LOSE GAME **********************************************************

void loseGame() {
  posX = 350;
  posY = 550;
  textAlign(CORNER);
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
  drawCloud();

  noFill();
  strokeWeight(3);
  stroke(0);
  arc(posX-3, posY-10, 10, 10, PI, 2*PI);
  arc(posX+17, posY-10, 10, 10, PI, 2*PI);
  stroke(255, 0, 0);
  arc(posX+7, posY+5, 10, 10, PI, 2*PI);

  if (Stripe == false && Dot == false) {
    stroke(outline);
    strokeWeight(2);
    noFill();
    arc(posX+60, posY+28, 40, 40, 0, PI/2);
    arc(posX+35, posY+33, 40, 40, 0, PI/2);
    arc(posX+10, posY+33, 40, 40, 0, PI/2);
    arc(posX+35, posY+5, 40, 40, 0, PI/2);
  }
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

  if (easy == true) {
    stroke(0, 125);
    fill(145, 250, 61);
    rectMode(CENTER);
    rect(675, 35, 125, 50);
    fill(0);
    textSize(32);
    text("Easy", 645, 45);
  } else if (medium == true) {
    stroke(0, 125);
    fill(232, 172, 19);
    rectMode(CENTER);
    rect(675, 35, 125, 50);
    fill(0);
    textSize(32);
    text("Medium", 620, 45);
  } else if (hard == true) {
    stroke(0, 125);
    fill(240, 44, 22);
    rectMode(CENTER);
    rect(675, 35, 125, 50);
    fill(0);
    textSize(32);
    text("Hard", 643, 45);
  } else if (expert == true) {
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

  if (keyCode == 32) {
    gameState = "START";
  }
}

//******************************** WIN GAME **********************************************************

void winGame() {
  posX = 350;
  posY = 550;
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
  smooth();
  drawCloud();

  noFill();
  strokeWeight(3);
  stroke(0);
  arc(posX-3, posY-10, 10, 10, PI, 2*PI);
  arc(posX+17, posY-10, 10, 10, PI, 2*PI);
  stroke(255, 0, 0);
  fill(255, 0, 0);
  arc(posX+7, posY, 10, 10, 0, PI);
  noFill();

  if (Dot == false && Stripe == false) {
    stroke(outline);
    strokeWeight(2);
    noFill();
    arc(posX+60, posY+28, 40, 40, 0, PI/2);
    arc(posX+35, posY+33, 40, 40, 0, PI/2);
    arc(posX+10, posY+33, 40, 40, 0, PI/2);
    arc(posX+35, posY+5, 40, 40, 0, PI/2);
  }

  if (keyCode == 32) {
    gameState = "START";
  }
}


//******************************** CUSTOMIZE **********************************************************


void customize() {
  posY = 650;
  drawCloud();

  noFill();
  strokeWeight(3);
  stroke(0);
  arc(posX-3, posY-10, 10, 10, PI, 2*PI);
  arc(posX+17, posY-10, 10, 10, PI, 2*PI);
  stroke(255, 0, 0);
  arc(posX+7, posY, 10, 10, 0, PI);

  if (Stripe == false && Dot == false) {
    stroke(outline);
    strokeWeight(2);
    noFill();
    arc(posX+60, posY+28, 40, 40, 0, PI/2);
    arc(posX+35, posY+33, 40, 40, 0, PI/2);
    arc(posX+10, posY+33, 40, 40, 0, PI/2);
    arc(posX+35, posY+5, 40, 40, 0, PI/2);
  }

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
  rect(width/2, 750, 200, 50);
  textSize(32);
  fill(0);
  text("Main Menu", width/2, 760);

  textSize(32);
  stroke(255);
  fill(255);
  textAlign(CENTER);
  if (colorSelector == true) {
    text("Select a Color!", width/2, 600);
  } else {
    text("Select a Design!", width/2, 600);
  }


  textSize(100);
  text("DropTop", width/2, 230);
  rectMode(CENTER);
  stroke(0, 180);
  fill(base);
  rect(220, 315, 75, 75);
  fill(orange);
  rect(320, 315, 75, 75);
  fill(yellow);
  rect(420, 315, 75, 75);
  fill(pink);
  rect(520, 315, 75, 75);
  fill(green);
  rect(220, 415, 75, 75);
  fill(dBlue);
  rect(320, 415, 75, 75);
  fill(grey);
  rect(420, 415, 75, 75);
  fill(purple);
  rect(520, 415, 75, 75);
  
  if(colorSelector == false){
    fill(red);
    rect(620, 315, 75, 75);
    fill(black);
    rect(620, 415, 75 ,75);
  }

  if (colorSelector == false) {
    //line design panel
    strokeWeight(3);
    fill(Cloud);
    stroke(Stripes);
    rect(85, 515, 80, 80);
    strokeWeight(3);
    line(50, 475, 45, 480);
    line(75, 475, 45, 505);
    line(100, 475, 45, 530);
    line(125, 475, 45, 555);
    line(125, 500, 70, 555);
    line(125, 525, 95, 555);
    line(125, 550, 120, 555);
    
    //dot design panel
    fill(Cloud);
    stroke(Dots);
    strokeWeight(3);
    rect(85, 415, 80, 80);
    strokeWeight(5);                      
    point(89, 380);        
    point(60, 380);
    point(113, 387);
    point(113, 405);
    point(72, 393);
    point(95, 395);
    point(52, 397);
    point(80, 410);  
    point(98, 415);
    point(62, 410);
    point(115, 420);
    point(74, 422);
    point(90, 430);
    point(55, 430);
    point(105, 433);
    point(115, 443);
    point(74, 440);
    point(90, 445);
    point(55, 447);
    
    //base design panel
    strokeWeight(3);
    fill(Cloud);
    stroke(outline);
    strokeWeight(3);
    rect(85,315,80,80);
    noFill();
    arc(75, 333, 40, 40, 0, PI/2);
    arc(45, 333, 40, 40, 0, PI/2);
    arc(75, 303, 40, 40, 0, PI/2);
    arc(102, 303, 40, 40, 0, PI/2);
    
  }

  pushMatrix();
  textSize(32);
  if (colorSelector == false) {
    fill(0);
    stroke(100);
  } else {
    fill(255);
    stroke(0);
  }
  rect(300, 515, 150, 50);
  if (colorSelector == false) {
    fill(100);
  } else {
    fill(0);
  }
  text("Color", 295, 525);
  if (colorSelector == true) {
    fill(0);
    stroke(100);
  } else {
    fill(255);
    stroke(0);
  }
  rect(440, 515, 150, 50);
  if (colorSelector == true) {
    fill(100);
  } else {
    fill(0);
  }
  text("Design", 440, 525);

  popMatrix();

  if (mousePressed && mouseX > 275 && mouseX < 475 && mouseY > 725 && mouseY < 775) {
    gameState = "START";
  }

  if (mousePressed && mouseX > 182.5 && mouseX < 257.5 && mouseY > 277.5 && mouseY < 352.5) {
    if (colorSelector == true) {
      Cloud = base;
    } else if (Stripe == true) {
      Stripes = base;
    } else if (Dot == true) {
      Dots = base;
    } else if(colorSelector == false && Stripe == false && Dot == false){
      outline = base;
    }
  }

  if (mousePressed && mouseX > 282.5 && mouseX < 357.5 && mouseY > 277.5 && mouseY < 352.5) {
    if (colorSelector == true) {
      Cloud = orange;
    } else if (Stripe == true) {
      Stripes = orange;
    } else if (Dot == true) {
      Dots = orange;
    } else if(colorSelector == false && Stripe == false && Dot == false){
      outline = orange;
    }
  }

  if (mousePressed && mouseX > 382.5 && mouseX < 457.5 && mouseY > 277.5 && mouseY < 352.5) {
    if (colorSelector == true) {
      Cloud = yellow;
    } else if (Stripe == true) {
      Stripes = yellow;
    } else if (Dot == true) {
      Dots = yellow;
    } else if(colorSelector == false && Stripe == false && Dot == false){
      outline = yellow;
    }
  }

  if (mousePressed && mouseX > 482.5 && mouseX < 557.5 && mouseY > 277.5 && mouseY < 352.5) {
    if (colorSelector == true) {
      Cloud = pink;
    } else if (Stripe == true) {
      Stripes = pink;
    } else if (Dot == true) {
      Dots = pink;
    } else if(colorSelector == false && Stripe == false && Dot == false){
      outline = pink;
    }
  }
  
  if (mousePressed && mouseX > 582.5 && mouseX < 657.5 && mouseY > 277.5 && mouseY < 352.5 && colorSelector == false) {
    if (Stripe == true) {
      Stripes = red;
    } else if (Dot == true) {
      Dots = red;
    } else if(colorSelector == false && Stripe == false && Dot == false){
      outline = red;
    }
  }

  if (mousePressed && mouseX > 182.5 && mouseX < 257.5 && mouseY > 377.5 && mouseY < 452.5) {
    if (colorSelector == true) {
      Cloud = green;
    } else if (Stripe == true) {
      Stripes = green;
    } else if (Dot == true) {
      Dots = green;
    } else if(colorSelector == false && Stripe == false && Dot == false){
      outline = green;
    }
  }

  if (mousePressed && mouseX > 282.5 && mouseX < 357.5 && mouseY > 377.5 && mouseY < 452.5) {
    if (colorSelector == true) {
      Cloud = dBlue;
    } else if (Stripe == true) {
      Stripes = dBlue;
    } else if (Dot == true) {
      Dots = dBlue;
    } else if(colorSelector == false && Stripe == false && Dot == false){
      outline = dBlue;
    }
  }

  if (mousePressed && mouseX > 382.5 && mouseX < 457.5 && mouseY > 377.5 && mouseY < 452.5) {
    if (colorSelector == true) {
      Cloud = grey;
    } else if (Stripe == true) {
      Stripes = grey;
    } else if (Dot == true) {
      Dots = grey;
    } else if(colorSelector == false && Stripe == false && Dot == false){
      outline = grey;
    }
  }

  if (mousePressed && mouseX > 482.5 && mouseX < 557.5 && mouseY > 377.5 && mouseY < 452.5) {
    if (colorSelector == true) {
      Cloud = purple;
    } else if (Stripe == true) {
      Stripes = purple;
    } else if (Dot == true) {
      Dots = purple;
    } else if(colorSelector == false && Stripe == false && Dot == false){
      outline = purple;
    }
  }
  
  if (mousePressed && mouseX > 582.5 && mouseX < 657.5 && mouseY > 377.5 && mouseY < 452.5 && colorSelector == false) {
    if (Stripe == true) {
      Stripes = black;
    } else if (Dot == true) {
      Dots = black;
    } else if(colorSelector == false && Stripe == false && Dot == false){
      outline = black;
    }
  }

  if (mousePressed && mouseX > 45 && mouseX < 125 && mouseY > 475 && mouseY < 555 && colorSelector == false) {
    Stripe = true;
    Dot = false;
  }

  if (mousePressed && mouseX > 45 && mouseX < 125 && mouseY > 375 && mouseY < 455 && colorSelector == false) {
    Dot = true;
    Stripe = false;
  }
  
  if(mousePressed && mouseX > 45 && mouseX < 125 && mouseY > 275 && mouseY < 355 && colorSelector == false){
    Dot = false;
    Stripe = false;
  }
  
  if(mousePressed && mouseX > 365 && mouseX < 515 && mouseY > 490 && mouseY < 540 && colorSelector == true){
    colorSelector = false;
  }
  
  if(mousePressed && mouseX > 225 && mouseX < 375 && mouseY > 490 && mouseY < 540 && colorSelector == false){
    colorSelector = true;
  }
}


//******************************** CUSTOMIZE **********************************************************


//movement code
void keyPressed() {
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
void keyReleased() {
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

void drawCloud() {
  fill(Cloud);
  if (Stripe == true) {
    stroke(Stripes);
  } else if (Dot == true) {
    stroke(Dots);
  } else if(Stripe == false && Dot == false){
    stroke(outline);
  } else{
    stroke(0);
  }
  strokeWeight(2);
  ellipse(posX+7, posY, 50, 50);
  noStroke();
  ellipse(posX+32, posY-5, 50, 50);
  if (Stripe == true) {
    stroke(Stripes);
  } else if (Dot == true) {
    stroke(Dots);
  } else if(Stripe == false && Dot == false){
    stroke(outline);
  } else {
    stroke(0);
  }
  strokeWeight(2);
  arc(posX+32, posY-5, 50, 50, 1.27*PI, 2.15*PI);
  noStroke();
  ellipse(posX-18, posY+25, 50, 50);
  if (Stripe == true) {
    stroke(Stripes);
  } else if (Dot == true) {
    stroke(Dots);
  } else if(Stripe == false && Dot == false){
    stroke(outline);
  } else {
    stroke(0);
  }
  strokeWeight(2);
  arc(posX-18, posY+25, 50, 50, PI/2.45, 3*PI/2);
  noStroke();
  ellipse(posX+7, posY+30, 50, 50);
  if (Stripe == true) {
    stroke(Stripes);
  } else if (Dot == true) {
    stroke(Dots);
  } else if(Stripe == false && Dot == false){
    stroke(outline);
  } else {
    stroke(0);
  }
  arc(posX+7, posY+30, 50, 50, PI/2.9, PI/1.35);
  noStroke();
  ellipse(posX+32, posY+30, 50, 50);
  if (Stripe == true) {
    stroke(Stripes);
  } else if (Dot == true) {
    stroke(Dots);
  } else if(Stripe == false && Dot == false){
    stroke(outline);
  } else {
    stroke(0);
  }
  arc(posX+32, posY+30, 50, 50, PI/3.6, PI/1.50);
  noStroke();
  ellipse(posX+57, posY+25, 50, 50);
  noFill();
  if (Stripe == true) {
    stroke(Stripes);
  } else if (Dot == true) {
    stroke(Dots);
  } else if(Stripe == false && Dot == false){
    stroke(outline);
  } else {
    stroke(0);
  }
  strokeWeight(2);
  arc(posX+57, posY+25, 50, 50, (3*PI)/2, 2.6*PI);

  if (Stripe == true) {
    stroke(Stripes);
    strokeWeight(3);
    line(posX - 24, posY+1, posX - 42, posY + 22);
    line(posX + 17, posY - 25, posX -35, posY + 42);
    line(posX + 45, posY - 25, posX - 10, posY + 47);
    line(posX + 56, posY-1, posX + 21, posY + 50);
    line(posX + 75, posY+ 10, posX + 48, posY + 48);
  }

  if (Dot == true) {
    stroke(Dots);
    strokeWeight(5);
    point(posX + 25, posY + 20);
    point(posX + 30, posY + 40);
    point(posX + 45, posY + 20);
    point(posX + 55, posY + 35);
    point(posX + 65, posY + 10);
    point(posX + 75, posY + 25);
    point(posX + 50, posY );
    point(posX + 30, posY +5);
    point(posX + 35, posY -20);
    point(posX + 10, posY + 30);
    point(posX + 5, posY + 45);
    point(posX -10, posY + 30);
    point(posX, posY + 15);
    point(posX-25, posY + 15);
    point(posX-30, posY + 35);
    point(posX-10, posY + 5);
  }
}
