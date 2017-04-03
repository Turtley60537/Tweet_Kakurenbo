class ThanksPhase {
  PImage thanks;

  ThanksPhase() {
    thanks = loadImage("thanks.png");
  }

  void display() {
    //textFont(arial, 70);
    //fill(#FF7403);
    //textAlign(CENTER);

    //text("ありがとうございました", width/2, height/2);
    //textAlign(CORNER);
    fill(0, 0, 0, 90);
    rect(0, 0, width, height);
    pushMatrix();
    scale(2);
    imageMode(CENTER);

    image(thanks, width/4, height/4 + 100);
    imageMode(CORNER);
    popMatrix();
  }
}