class ManageMap {
  //一次のキーを作成
  int keyInit(long __id) {
    return int(__id % 5);
  }

  //保存されていなければ、グループデータをセット
  void setIndex(long _id) {

    int getKey = keyInit(_id);
    
    if (playerIndex.get(getKey)==null) {
      playerIndex.put( getKey, new HashMap<Long, Integer>() );
    }
    //最後尾のインデックスを保存
    playerIndex.get(getKey).put(_id, player.size());
  }

  //参加済みか判定
  boolean alreadySaved(long _id) {
    
    int getKey = keyInit(_id);

    if (playerIndex.get(getKey) == null) {
      return false;
    } else if (playerIndex.get(getKey).get(_id) == null) {
      return false;
    } else {
      return true;
    }
  }

  //与えられたidからプレイヤーのインデックスを取得
  int searchIndex(long _id) {

    int getKey = keyInit(_id);

    if (playerIndex.get(getKey).get(_id) != null) {
      return playerIndex.get(getKey).get(_id);
    } else {
      return -1;
    }
  }
}