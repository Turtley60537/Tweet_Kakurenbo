class SearchPhase {
  float blackout = 0;
  int intervalCount;
  boolean foundUserVisible = false;
  boolean settingNextSearchFlag = true;

  SearchPhase() {
  }

  void display() {

    for (int i=0; i<hidePoint.size(); i++) {
      //目印
      hidePoint.get(i).display();
    }
    //println("someoneFoundFlag = "+someoneFoundFlag);
    if (someoneFoundFlag) {
      //見つかったフェーズ

      //println("(blackout, intervalCount)=("+blackout+", "+intervalCount+")");
      if (blackout<180 && intervalCount<10) {
        //フェードイン
        intervalCount = 0;
        blackout += 15;
      } else if (blackout>=0 && intervalCount>150) {
        //フェードアウト
        foundUserVisible = false;
        blackout -= 10;
      } else if (blackout<0 && intervalCount>150) {
        //見つかった際の各値の初期化
        blackout = 0;
        intervalCount = 0;
        //次のフェーズへ
        someoneFoundFlag = false;
        settingNextSearchFlag = true;
      }
      if (blackout>=180) foundUserVisible = true;
      intervalCount++;

      fill(0, blackout);
      rect(0, 0, width, height);
      if (foundUserVisible) {

        //見つかった人を並べて表示
        int foundColumn = 0;
        int foundRow    = 6;
        println(foundUser.size());
        println(kame.nextPatrolNum);
        for (int i=0; i<foundUser.size(); i++) {
          int foundPositionControl = i - foundColumn * foundRow;
          if (foundPositionControl!=0 && foundPositionControl%foundRow==0) {
            foundColumn++;
            foundPositionControl -= foundRow;
          }
          float foundIconW = 100;
          float foundIconX = 100 + foundPositionControl * (foundIconW+20);
          float foundIconY = height/2-50 + foundColumn * (foundIconW+20);
          foundUser.get(i).displayFound(foundIconX, foundIconY, foundIconW);

          textFont(arial, 100);
          fill(#017C0E);
          textAlign(CENTER);
          text("見つかった", width/2, 150);
          textAlign(CORNER);
        }
      }
    } else {
      //巡回のフェーズ

      if (settingNextSearchFlag) {
        //巡回の準備
        kame.settingNextSearch();
        foundUser = new ArrayList<User>();
        foundUser = hidePoint.get(kame.patrol[kame.nextPatrolNum]).hideUser;
        settingNextSearchFlag = false;
      } else {
        if (!emargeKameFlag) {
          //かめが現れる
          kame.emarge();
          if (kame.iconW>100) {
            kame.iconW = 100;
            emargeKameFlag = true;
          }
        } else {
          kame.move();
        }
        kame.display();
      }
    }
  }
}