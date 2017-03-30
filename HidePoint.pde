class HidePoint {
  float pointX, pointY;
  ArrayList<User> hideUser;

  HidePoint(float _pointX, float _pointY) {
    pointX = _pointX;
    pointY = _pointY;
    hideUser = new ArrayList<User>();
  }

  void setHideUser(User _user) {
    hideUser.add(_user);
  }


  void display() {
    fill(255, 100, 100);
    ellipse(pointX, pointY, 100, 100);
  }
}