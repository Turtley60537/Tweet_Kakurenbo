class Kame {
  float iconX, iconY, iconW;
  int[] patrol;
  int nextPatrolNum;

  float nextPointX, nextPointY;
  float thetaToNextHidePoint;
  float moveVelocity;
  float moveVelocityX, moveVelocityY;

  Kame() {
    //かめの巡回場所を設定
    patrol = new int[hidePoint.size()];
    for (int i=0; i<patrol.length; i++) {
      patrol[i] = -1;
    }
    for (int i=0; i<patrol.length; i++) {
      while (true) {
        int settingNum = (int)random(hidePoint.size());
        if ( alreadySetPlace(settingNum) ) {
          continue;
        }
        patrol[i] = settingNum;
        break;
      }
    }

    iconX = width/2;
    iconY = height/2;
    iconW = 0;

    moveVelocity = 2;
    nextPatrolNum = -1;
  }

  void emarge() {
    iconW += 1;
  }

  void display() {
    rectMode(CENTER);
    rect(iconX, iconY, iconW, iconW);
    rectMode(CORNER);
  }

  void settingNextSearch() {
    nextPatrolNum ++;

    nextPointX = hidePoint.get(patrol[nextPatrolNum]).pointX;
    nextPointY = hidePoint.get(patrol[nextPatrolNum]).pointY;
    thetaToNextHidePoint = atan2( nextPointY-this.iconY, nextPointX-this.iconX );
    moveVelocityX = moveVelocity * cos( thetaToNextHidePoint );
    moveVelocityY = moveVelocity * sin( thetaToNextHidePoint );
  }

  void move() {
    iconX += moveVelocityX;
    iconY += moveVelocityY;
    if( dist(iconX, iconY, nextPointX, nextPointY)<20 ){
      someoneFoundFlag = true;
    }
  }

  boolean alreadySetPlace(int _settingNum) {
    for (int i=0; i<patrol.length; i++) {
      if ( patrol[i]==_settingNum ) {
        return true;
      }
    }
    return false;
  }
}