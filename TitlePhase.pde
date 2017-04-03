class TitlePhase {
  PImage tweet, kakurenbo, topSentence, bottomSentence;

  TitlePhase() {
    tweet          = loadImage("tweet.png");
    kakurenbo      = loadImage("kakurenbo.png");
    topSentence    = loadImage("topSentence.png");
    bottomSentence = loadImage("bottomSentence.png");
  }

  void display() {
    //タイトルフェイズ
    //textFont(arial, 150);
    //fill(#FF7403);
    //textAlign(CENTER);

    //text("ツイート", width/2, height/2-50);
    //text("かくれんぼ", width/2, height/2+150);
    //textAlign(CORNER);
    fill(0, 0, 0, 90);
    rect(0, 0, width, height);
    imageMode(CENTER);
    image(topSentence, width/2, height/2-70);
    image(tweet, width/2, height/2-70);
    image(kakurenbo, width/2, height/2+70);
    image(bottomSentence, width/2, height/2+70);
    imageMode(CORNER);
  }
}