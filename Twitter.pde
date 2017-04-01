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

    println(name, screenName, id);
    println("  " + text);
    println();

    if (phase==Phase.invite) {
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
        player.add( new Player(newPlayerIcon) );
      }
    } else if (phase==Phase.hide) {
      //println("phase2 getTweet\n");
      int playerIndex = manageMap.searchIndex(id);
      if (playerIndex==-1) {
        println("関係ないツイート\n");
        return;
      }

      if (text.contains("草むら")) {
        println("kusamura");
        player.get(playerIndex).setHidePoint(0);
        
      } else if (text.contains("木")) {
        println("ki");
        player.get(playerIndex).setHidePoint(1);
        
      } else if (text.contains("砂場")) {
        println("sunaba");
        player.get(playerIndex).setHidePoint(2);
        
      } else if (text.contains("すべり台")) {
        println("suberidai");
        player.get(playerIndex).setHidePoint(3);
        
      }
    }
  }

  boolean containJoinWord() {
    return text.contains("かくれんぼゲームに参加");
  }
}