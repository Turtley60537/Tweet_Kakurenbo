class HidePhase {
  HidePhase() {
    //このフェイズの初期化
    //初期位置の設定
    float firstIconX  = 200;
    float firstIconY  = height/2-50;
    float hideIconW   = 50;
    int hideColumn    = 0;
    int hideRow       = 8;
    
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
  }

  void display() {

    for (int j=0; j<hidePoint.size(); j++) {
      //隠れ場所の目印
      fill(255, 100, 100);
      ellipse(hidePoint.get(j).pointX, hidePoint.get(j).pointY, 100, 100);
    }

    for (int i=0; i<player.size(); i++) {
      player.get(i).move();
      player.get(i).displayPlayer();
    }
  }
}