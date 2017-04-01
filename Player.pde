class Player {
  float iconX, iconY, iconW;
  float moveVelocityX, moveVelocityY;
  float roll;

  int hidePointNum;
  boolean reachedHidePoint;

  PImage iconImage;

  Player(PImage _playerImage) {
    iconW            = 50;
    roll             = 0;
    reachedHidePoint = false;
    iconImage        = _playerImage;
    hidePointNum     = -1;
  }

  void displayParticipant(float _x, float _y, float _w) {
    image(iconImage, _x, _y, _w, _w);
  }

  //隠れる時の表示
  void displayPlayer() {
    if (reachedHidePoint) {
      //回転しながら小さくなって隠れるやつの描画
      pushMatrix();
      translate(iconX, iconY);
      roll += 0.1;
      rotate(roll);
      imageMode(CENTER);
      image(iconImage, 0, 0, iconW, iconW);
      imageMode(CORNER);
      popMatrix();
    } else {
      //移動中の描画
      imageMode(CENTER);
      image(iconImage, iconX, iconY, iconW, iconW);
      imageMode(CORNER);
    }
  }

  //見つかった時の表示
  void displayFound(float _foundIconX, float _foundIconY, float _foundIconW) {
    //SearchPhaseのsomeoneFoundFlag内から実行
    imageMode(CENTER);
    image(iconImage, _foundIconX, _foundIconY, _foundIconW, _foundIconW);
    imageMode(CORNER);
  }

  void setPosition(float _iconX, float _iconY) {
    iconX = _iconX;
    iconY = _iconY;
  }

  //Twitterで取得した各Playerの隠れ場所を設定
  void setHidePoint(int _hidePointNum) {
    if (hidePointNum!=-1) {
      println("this user has already hidden");
      return;
    }
    hidePointNum = _hidePointNum;

    hidePoint.get(hidePointNum).setHidePlayer(this);
    moveVelocityX = (hidePoint.get(hidePointNum).pointX-iconX)/200.0;
    moveVelocityY = (hidePoint.get(hidePointNum).pointY-iconY)/200.0;

    //searchPhase.phaseOfSearch = PhaseOfSearch.search;
    //隠れない時はそもそもこれが実行されないことが問題があった
    //SearchPhaseのコンストラクタに記述することで対応
  }

  void move() {
    if (hidePointNum<hidePoint.size() && hidePointNum!=-1) {
      if ( this.farFromHidePoint() ) {
        iconX += moveVelocityX;
        iconY += moveVelocityY;
      } else if (iconW >= 0) {
        reachedHidePoint = true;
        iconW -= 0.4;
      }
    }
  }

  boolean farFromHidePoint() {
    float hidePointX = hidePoint.get(hidePointNum).pointX;
    float hidePointY = hidePoint.get(hidePointNum).pointY;
    return dist(iconX, iconY, hidePointX, hidePointY)>30;
  }
}