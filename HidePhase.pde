class HidePhase {
  HidePhase() {
    //このフェイズの初期化
    //初期位置の設定
    int hideColumn  = 0;
    int hideRow     = 8;
    int hideIconW = 50;
    for (int i=0; i<user.size(); i++) {
      int hidePositionControl = i - hideColumn * hideRow;
      if (hidePositionControl!=0 && hidePositionControl%hideRow==0) {
        hideColumn++;
        hidePositionControl -= hideRow;
      }
      float hideIconX = 200 + hidePositionControl * hideIconW;
      float hideIconY = height/2-50 + hideColumn * hideIconW;

      user.get(i).setPosition(hideIconX, hideIconY);
      user.get(i).setHidePoint();        //ランダムで隠れる場所を設定
      if (user.get(i).hidePointNum==hidePoint.size()) {
        //隠れていない場合、直にfoundUserに追加
        foundUser.add( user.get(i) );
      }
    }
  }

  void display() {

    for (int j=0; j<hidePoint.size(); j++) {
      fill(255, 100, 100);
      ellipse(hidePoint.get(j).pointX, hidePoint.get(j).pointY, 100, 100);
    }

    for (int i=0; i<user.size(); i++) {
      user.get(i).move();
      user.get(i).displayPlayer();
    }
  }
}