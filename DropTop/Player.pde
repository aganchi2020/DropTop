float posX, posY;
float speedX, speedY, maxSpeed;
int points;
String Points;
int lives;
String Lives;

class Player {
  //properties


  //constructor
  Player() {
    posX = 350;
    posY = 550;
    maxSpeed = 7;
    speedX = 0;
    speedY = 0;
    Points = "Drops: ";
    Lives = ": x";
  }

  //methods
  void update() {

    //horizontal movement
    if (left) {
      speedX = -maxSpeed;
    }

    if (right) {
      speedX = maxSpeed;
    }

    if ((!left && !right) || (left && right)) {
      speedX = 0;
    }


    //vertical movement
    if (up) {
      speedY = -maxSpeed;
    }

    if (down) {
      speedY = maxSpeed;
    }

    if ((!up && !down) || (up && down)) {
      speedY = 0;
    }

    checkBounds();

    //update position
    posX = posX + speedX;
    posY = posY + speedY;
  }

  void display() {


    //Player cloud
    smooth();
    drawCloud();

    //draw face
    noFill();
    strokeWeight(3);
    stroke(0);
    arc(posX-3, posY-10, 10, 10, PI, 2*PI);
    arc(posX+17, posY-10, 10, 10, PI, 2*PI);
    stroke(255, 0, 0);
    arc(posX+7, posY, 10, 10, 0, PI);

    //player cloud outlines
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
    Lives = ": x" + lives;

    //catch raindrops to win
    stroke(255, 200);
    fill(255);
    textSize(20);
    text("Catch " + helpNum + " Raindrops to Win", 260, 30);
    stroke(255, 0, 0);
    line(310, 35, 345, 35);

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
  }
  //screen barriers
  void checkBounds() {
    if (posX > width- 50) {
      posX = width - 50;
    }
    if (posX < 20) {
      posX = 20;
    }
    if (posY > height- 50) {
      posY = height - 50;
    }
    if (posY < 145) {
      posY = 145;
    }
  }
}
