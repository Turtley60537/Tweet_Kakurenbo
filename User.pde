class User {
  float iconX, iconY;
  float iconW;
  int hidePointNum;
  float moveVelocityX, moveVelocityY;
  float roll;
  boolean reachedHidePoint;
  color red   = (int)random(255);
  color green = (int)random(255);
  color blue  = (int)random(255);

  User() {
    iconW = 50;
    roll = 0;
    reachedHidePoint = false;
  }

  void displayParticipant(float _x, float _y, float _w) {
    fill(red, green, blue);
    rect(_x, _y, _w, _w);
  }

  void displayPlayer() {
    if (reachedHidePoint) {
      pushMatrix();
      translate(iconX, iconY);
      roll += 0.1;
      rotate(roll);
      fill(red, green, blue);
      rectMode(CENTER);
      rect(0, 0, iconW, iconW);
      rectMode(CORNER);
      popMatrix();
    } else {
      fill(red, green, blue);
      rectMode(CENTER);
      rect(iconX, iconY, iconW, iconW);
      rectMode(CORNER);
    }
    println(red, green, blue);
  }

  void displayFound(float _foundIconX, float _foundIconY, float _foundIconW) {
    rectMode(CENTER);
    fill(red, green, blue);
    rect(_foundIconX, _foundIconY, _foundIconW, _foundIconW);
    rectMode(CORNER);
    println(red, green, blue);
  }

  void setPosition(float _iconX, float _iconY) {
    iconX = _iconX;
    iconY = _iconY;
  }

  void setHidePoint() {
    hidePointNum = (int)random(hidePoint.size()+1);

    if (hidePointNum<hidePoint.size()) {
      hidePoint.get(hidePointNum).setHideUser(this);

      moveVelocityX = (hidePoint.get(hidePointNum).pointX-iconX)/200.0;
      moveVelocityY = (hidePoint.get(hidePointNum).pointY-iconY)/200.0;
    } else {
      someoneFoundFlag = true;
    }
  }

  void move() {
    if (hidePointNum<hidePoint.size()) {
      if ( this.distHidePoint() ) {

        iconX += moveVelocityX;
        iconY += moveVelocityY;
      } else if (iconW>=0) {
        reachedHidePoint = true;
        iconW -= 0.4;
      }
    }
  }

  boolean distHidePoint() {
    float hidePointX = hidePoint.get(hidePointNum).pointX;
    float hidePointY = hidePoint.get(hidePointNum).pointY;
    return dist(iconX, iconY, hidePointX, hidePointY)>30;
  }
}