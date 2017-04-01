class TitlePhase {
  void display() {
    //タイトルフェイズ
    textFont(arial, 150);
    fill(#017C0E);
    textAlign(CENTER);

    text("ツイート", width/2, height/2-50);
    text("かくれんぼ", width/2, height/2+150);
    textAlign(CORNER);
  }
}