class InvitePhase {
  int initTime, nowTime, countDown;

  InvitePhase() {
    //このフェイズの初期化
    initTime = minute()*60 + second();
  }

  void display() {
    //カウントダウンの表示
    nowTime   = minute()*60 + second();
    countDown = 60 - (nowTime-initTime);

    textFont(loadFont("Ricty-Bold-48.vlw"), 100);
    textAlign(CENTER);
    text(countDown, width/2, 100);
    textAlign(CORNER);

    if (countDown==0) {
      phase = Phase.hide;
    }

    //参加者のアイコンを並べて表示
    //10人で改行
    float firstIconX  = 20;
    float firstIconY  = 200;
    int inviteColumn  = 0;
    int inviteRow     = 10;
    float inviteIconW = (width-40)/inviteRow;

    for (int i=0; i<player.size(); i++) {
      int invitePositionControl = i - inviteColumn * inviteRow;
      if (invitePositionControl!=0 && invitePositionControl%inviteRow==0) {
        inviteColumn++;
        invitePositionControl -= inviteRow;
      }
      float inviteIconX = firstIconX + invitePositionControl * inviteIconW;
      float inviteIconY = firstIconY + inviteColumn * inviteIconW;

      player.get(i).displayParticipant( inviteIconX, inviteIconY, inviteIconW );
    }
  }
}