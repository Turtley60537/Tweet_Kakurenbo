class MyStatusListener extends StatusAdapter {
  public void onStatus(Status s) {
    Tweet tweet = new Tweet(s);
  }
}

class Tweet {
  long id;
  String text;
  String name;
  String screenName;
  String iconUrl;

  public Tweet(Status status) {
    text       = status.getText();      //本文
    User user  = status.getUser();
    id         = user.getId();          //固有id
    name       = user.getName();        //ユーザー名
    screenName = user.getScreenName();  //@name
    iconUrl    = user.getProfileImageURL();
    
    if(screenName.matches("kame_data")) return;
    if(text.contains("かめかめ")) return;

    println(name, "@"+screenName, id);
    println("  " + text);
    println();

    if (phase==Phase.INVITE) {
      println("phase1 getTweet");
      if (!containJoinWord()) {
        println("関係ないツイート\n");
        return;
      } else if ( manageMap.alreadySaved(id) ) {
        println("参加済み\n");
        return;
      } else {
        //参加者の情報を取得する
        manageMap.setIndex(id);
        println(iconUrl);
        //playerに新たにプレイヤーを追加
        PImage newPlayerIcon = loadImage(iconUrl);
        player.add( new Player(newPlayerIcon, screenName) );
      }
    } else if (phase==Phase.HIDE) {
      //println("phase2 getTweet\n");
      int playerIndex = manageMap.searchIndex(id);
      if (playerIndex==-1) {
        println("関係ないツイート\n");
        return;
      }

      if (text.contains("木")) {
        println("ki");
        player.get(playerIndex).setHidePoint(0);
      } else if (text.contains("草むら")) {
        println("kusamura");
        player.get(playerIndex).setHidePoint(1);
      } else if (text.contains("太陽")) {
        println("taiyou");
        player.get(playerIndex).setHidePoint(2);
      } else if (text.contains("洞窟")) {
        println("doukutsu");
        player.get(playerIndex).setHidePoint(3);
      }
    }
  }

  boolean containJoinWord() {
    return text.contains("ゲームに参加");
  }

  void createInviteTweet() {
  }
}

class CreateTweet {

  void invite() {
    String sendingText = filterTag + " リンクに飛んで、ゲームに参加するためのツイートをしよう！かめかめ\nhttps://twitter.com/intent/tweet?text=%E3%82%B2%E3%83%BC%E3%83%A0%E3%81%AB%E5%8F%82%E5%8A%A0%20" + tagSentence;
    try {
      Status status = rest.updateStatus(sendingText);
      println("Successfully update the status to [" + status.getText() + "].");
    } 
    catch ( TwitterException e ) {
      println(e.getStatusCode());
    }
  }

  void hide() {
    String sendingText = filterTag + " リンクに飛んで、隠れよう！かめかめ\n木\nhttps://twitter.com/intent/tweet?text=%E6%9C%A8%20"+tagSentence+"\n草むら\nhttps://twitter.com/intent/tweet?text=%E8%8D%89%E3%82%80%E3%82%89%20"+tagSentence+"\n洞窟\nhttps://twitter.com/intent/tweet?text=%E6%B4%9E%E7%AA%9F%20"+tagSentence+"\n太陽\nhttps://twitter.com/intent/tweet?text=%E5%A4%AA%E9%99%BD%20"+tagSentence;
    try {
      Status status = rest.updateStatus(sendingText);
      println("Successfully update the status to [" + status.getText() + "].");
    }
    catch ( TwitterException e ) {
      println(e.getStatusCode());
    }
  }

  //void found( ArrayList<Player> _foundPlayer ) {
  //  String sendingText = "";
  //  for (int i=0; i<_foundPlayer.size(); i++) {
  //    sendingText += "@"+ _foundPlayer.get(i).screenName + " ";
  //  }
  //  sendingText += "を見つけました！\n" + filterTag;
  //  try {
  //    Status status = rest.updateStatus(sendingText);
  //    println("Successfully update the status to [" + status.getText() + "].");
  //  }
  //  catch ( TwitterException e ) {
  //    println(e.getStatusCode());
  //  }
  //}

  void winner( ArrayList<Player> _winnerPlayer ) {
    String sendingText = "";
    for (int i=0; i<_winnerPlayer.size(); i++) {
      sendingText += "@"+ _winnerPlayer.get(i).screenName + " ";
    }
    sendingText += "が隠れ切りました\n" + filterTag;
    try {
      Status status = rest.updateStatus(sendingText);
      println("Successfully update the status to [" + status.getText() +"].");
    }
    catch ( TwitterException e ){
      println(e.getStatusCode());
    }
  }
  
  void kameWin(){
    String sendingText = "私の勝ちです\n" + filterTag;
    try {
      Status status = rest.updateStatus(sendingText);
      println("Successfully update the status to [" + status.getText() +"].");
    }
    catch ( TwitterException e ){
      println(e.getStatusCode());
    }
  }
}