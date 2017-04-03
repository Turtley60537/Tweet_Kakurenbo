class SearchPhase {
  PhaseOfSearch phaseOfSearch;
  Kame kame;

  float blackout    = 0;
  int intervalCount = 0;

  ArrayList<Player> foundPlayer = new ArrayList<Player>();
  boolean foundPlayerVisible    = false;  //かめがたどり着いた場所に隠れているプレイヤーがいればtrue
  boolean tweetFound            = false;

  boolean settingNextSearchFlag = true;
  boolean emargeKameFlag        = false;

  boolean winnerInitializeFlag  = true;
  boolean kameWonFlag           = false;
  boolean tweetWinner           = true;

  PImage mitsuketa, kachi, kamenokachi;

  SearchPhase() {
    kame = new Kame();
    phaseOfSearch = PhaseOfSearch.SEARCH;
    foundPlayer = new ArrayList<Player>();

    for (int i=0; i<player.size(); i++) {
      if (player.get(i).hidePointNum==-1) {
        //hidePointNum!=-1の時
        //すなわち、隠れていない時
        phaseOfSearch = PhaseOfSearch.SOMEONE_FOUND;
        foundPlayer.add( player.get(i) );

        tweetFound = true;
      }
    }

    //natsunomushi = loadImage("natsunomushi.png");
    mitsuketa    = loadImage("mitsuketa.png");
    kachi        = loadImage("kachi.png");
    kamenokachi  = loadImage("kamenokachi.png");
  }

  void display() {
    ////HidePointの目印
    //for (int i=0; i<hidePoint.size(); i++) {
    //  hidePoint.get(i).display();
    //}

    switch (phaseOfSearch) {

      //見つかったフェーズ
    case SOMEONE_FOUND:
      if (blackout<180 && intervalCount<10) {
        if (tweetFound) {

          //createTweet.found(foundPlayer);
          tweetFound = false;
        }
        //フェードイン
        intervalCount = 0;
        blackout += 15;
      } else if (blackout>=0 && intervalCount>150) {
        //フェードアウト
        foundPlayerVisible = false;
        blackout -= 10;
      } else if (blackout<0 && intervalCount>150) {

        //見つかった際の各値の初期化
        blackout      = 0;
        intervalCount = 0;

        //次のフェーズへ
        if (kame.nextPatrolNum<kame.patrol.length-2) {
          phaseOfSearch = PhaseOfSearch.SEARCH;
          settingNextSearchFlag = true;
        } else {
          phaseOfSearch = PhaseOfSearch.WINNER;
        }
      }

      if (blackout>=180) foundPlayerVisible = true;
      intervalCount++;
      //暗くするためのrect
      fill(0, blackout);
      strokeWeight(0);
      rect(0, 0, width, height);
      strokeWeight(1);

      //見つかった人を並べて表示
      if (foundPlayerVisible) {

        this.showFoundPlayer(mitsuketa, mitsuketa.width, mitsuketa.height);
      }
      break;

      //巡回のフェーズ
    case SEARCH:
      if (settingNextSearchFlag) {
        //巡回の準備
        kame.settingNextSearch();
        foundPlayer = new ArrayList<Player>();
        foundPlayer = hidePoint.get(kame.patrol[kame.nextPatrolNum]).hidePlayer;
        if (foundPlayer.size()>0) {
          tweetFound = true;
        }
        settingNextSearchFlag = false;

        tweetFound    = true;
      }

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
      break;

      //勝者のフェーズ
    case WINNER:

      //winnerPhaseの初期設定
      if (winnerInitializeFlag) {
        if (hidePoint.get(kame.patrol[kame.nextPatrolNum+1]).hidePlayer.size()>0) {
          foundPlayer = hidePoint.get(kame.patrol[kame.nextPatrolNum+1]).hidePlayer;
          foundPlayerVisible   = false;

          //隠れ切った人がいればその人たちの勝利をツイート
          kameWonFlag = false;
        } else {
          //foundPlayer = hidePoint.get(kame.patrol[kame.nextPatrolNum]).hidePlayer;

          //隠れ切った人がいなければかめの勝利をツイート
          kameWonFlag = true;
        }
        winnerInitializeFlag = false;
      }

      if (blackout<180 && intervalCount<10) {

        //フェードイン
        intervalCount = 0;
        blackout += 5;
      } else if (blackout>=0 && intervalCount>150) {
        //フェードアウト
        foundPlayerVisible = false;
        blackout -= 10;
      } else if (blackout<0 && intervalCount>200) {
        //見つかった際の各値の初期化
        blackout      = 0;
        intervalCount = 0;
        phase = Phase.THANKS;
      }
      if (blackout>=180) foundPlayerVisible = true;
      intervalCount++;

      if (tweetWinner && intervalCount==150) {
        if (kameWonFlag) {
          createTweet.kameWin();
        } else {
          createTweet.winner(foundPlayer);
        }
        tweetWinner = false;
      }

      fill(0, blackout);
      strokeWeight(0);
      rect(0, 0, width, height);
      strokeWeight(1);

      if (foundPlayerVisible) {
        if (kameWonFlag) {
          kame.displayAsWinner(kamenokachi);
        } else {
          //見つかった人を並べて表示
          this.showFoundPlayer(kachi, kachi.width, kachi.height);
        }
      }
      break;
    }
  }

  void showFoundPlayer(PImage _sentenceImage, float _sentenceW, float _sentenceH) {

    float firstIconX = 100;
    float firstIconY = height/2-50;
    int foundColumn  = 0;
    int foundRow     = 6;

    for (int i=0; i<foundPlayer.size(); i++) {
      int foundPositionControl = i - foundColumn * foundRow;
      if (foundPositionControl!=0 && foundPositionControl%foundRow==0) {
        foundColumn++;
        foundPositionControl -= foundRow;
      }
      float foundIconW = 100;
      float foundIconX = firstIconX + foundPositionControl * (foundIconW+20);
      float foundIconY = firstIconY + foundColumn * (foundIconW+20);

      foundPlayer.get(i).displayFound(foundIconX, foundIconY, foundIconW);

      //textFont(arial, 100);
      //fill(#017C0E);
      //textAlign(CENTER);
      //text(_sentence, width/2, 150);
      //textAlign(CORNER);
    }

    imageMode(CENTER);
    image(_sentenceImage, width/2, 100, _sentenceW, _sentenceH);
    imageMode(CORNER);
  }
}