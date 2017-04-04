class HidePhase {
  int initTime, nowTime, countDown;
  PImage hideSample;

  HidePhase() {
    hideSample = loadImage("hideSample.png");

    //このフェイズの初期化
    //初期位置の設定
    float firstIconX  = 200;
    float firstIconY  = height/2-50;
    float hideIconW   = 50;
    int hideColumn    = 0;
    int hideRow       = 10;

    for (int i=0; i<player.size(); i++) {
      int hidePositionControl = i - hideColumn * hideRow;
      if (hidePositionControl!=0 && hidePositionControl%hideRow==0) {
        hideColumn++;
        hidePositionControl -= hideRow;
      }
      float hideIconX = firstIconX + hidePositionControl * hideIconW;
      float hideIconY = firstIconY + hideColumn * hideIconW;

      player.get(i).setPosition(hideIconX, hideIconY);
    }

    initTime = minute()*60 + second();
    createTweet.hide();
  }

  void display() {

    //カウントダウンの表示
    nowTime   = minute()*60 + second();
    countDown = 60 - (nowTime-initTime);
    fill(#FF7403);
    textFont(loadFont("Ricty-Bold-48.vlw"), 100);
    textAlign(CENTER);
    text(countDown, 100, 100);
    textAlign(CORNER);

    if (countDown==0) {
      phase = Phase.SEARCH;
    }

    //参加方法のテンプレートを表示
    pushMatrix();
    scale(0.5);
    image(hideSample, 340, 40);
    popMatrix();

    //for (int j=0; j<hidePoint.size(); j++) {
    //  //隠れ場所の目印
    //  fill(255, 100, 100);
    //  ellipse(hidePoint.get(j).pointX, hidePoint.get(j).pointY, 100, 100);
    //}
    fill(#FF4603);
    textFont(arial);
    text("木", 80, 200);
    text("草むら", 50, height-100);
    text("洞窟", width-150, height-160);
    text("太陽", width-150, 120);

    for (int i=0; i<player.size(); i++) {
      player.get(i).move();
      player.get(i).displayPlayer();
    }
  }
}