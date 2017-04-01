class HidePoint {  
  float pointX, pointY;
  ArrayList<Player> hidePlayer;

  HidePoint(float _pointX, float _pointY) {
    pointX = _pointX;
    pointY = _pointY;
    hidePlayer = new ArrayList<Player>();
  }

  void setHidePlayer(Player _player) {
    hidePlayer.add(_player);
  }

  void display() {
    fill(255, 100, 100);
    ellipse(pointX, pointY, 100, 100);
  }
}