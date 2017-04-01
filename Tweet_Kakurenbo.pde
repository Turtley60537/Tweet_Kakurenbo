import twitter4j.*;
import twitter4j.api.*;
import twitter4j.conf.*;
import twitter4j.http.*;
import twitter4j.internal.async.*;
import twitter4j.internal.http.*;
import twitter4j.internal.logging.*;
import twitter4j.internal.org.json.*;
import twitter4j.internal.util.*;
import twitter4j.util.*;

//TwitterAPIを利用するためのもの
Twitter            rest;
TwitterStream      stream;
TwitterAPISettings apiSettings;

PFont arial;    //フォント

enum Phase {
  title, 
    invite, 
    hide, 
    search, 
    thanks,
};
Phase phase;

TitlePhase titlePhase;

InvitePhase invitePhase;
boolean inviteInitialized = false;

HidePhase hidePhase;
boolean hideInitialized = false;

SearchPhase searchPhase;
boolean searchInitialized = false;


//参加者のデータを格納するための二次元のHashMap
//id%5をキー、idを格納
HashMap<Integer, HashMap<Long, Integer>> playerIndex 
  = new HashMap<Integer, HashMap<Long, Integer>>();

//HashMapを操作するためのクラス
ManageMap manageMap = new ManageMap();

ArrayList<Player>    player    = new ArrayList<Player>();
ArrayList<HidePoint> hidePoint = new ArrayList<HidePoint>();

enum PhaseOfSearch {
  someoneFound, 
    search, 
    winner,
};

void setup() {
  //APIを使うための設定
  apiSettings = new TwitterAPISettings();
  
  size(800, 600);
  arial      = loadFont("ArialUnicodeMS-48.vlw");
  phase      = Phase.title;
  titlePhase = new TitlePhase();
}

void draw() {
  background(#D6F6FF);
  switch (phase) {

  case title:
    titlePhase.display();
    break;

  case invite:
    //参加者を募るフェイズ
    if (!inviteInitialized) {
      invitePhase = new InvitePhase();
      inviteInitialized = true;
    }
    invitePhase.display();
    break;

  case hide:
    //参加者が隠れるフェイズ
    if (!hideInitialized) {
      //隠れ場所の追加
      hidePoint.add( new HidePoint(100, 100) );
      hidePoint.add( new HidePoint(200, 500) );
      hidePoint.add( new HidePoint(750, 200) );
      hidePoint.add( new HidePoint(500, 500) );

      hidePhase = new HidePhase();
      hideInitialized = true;
    }
    hidePhase.display();
    break;

  case search:
    //かめが探すフェイズ
    if (!searchInitialized) {
      searchPhase = new SearchPhase();
      searchInitialized = true;
    }
    searchPhase.display();
    break;

  case thanks:
    textFont(arial, 50);
    fill(#017C0E);
    textAlign(CENTER);

    text("ありがとうございました", width/2, height/2);
    textAlign(CORNER);
    break;
  }
}

void keyPressed() {
  if (keyCode==ENTER) {
    switch (phase) {

    case title:
      phase = Phase.invite;
      break;

    case invite:
      phase = Phase.hide;
      break;

    case hide:
      phase = Phase.search;
      break;
    }
  }
}