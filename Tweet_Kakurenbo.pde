//発表時
//ハッシュタグを本番用に変える
//キーの取得をするファイルを戻す

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
CreateTweet        createTweet;

PFont arial;

enum Phase {
  TITLE, 
    INVITE, 
    HIDE, 
    SEARCH, 
    THANKS,
};
Phase phase;

TitlePhase titlePhase;

InvitePhase invitePhase;
boolean inviteInitialized = false;

HidePhase hidePhase;
boolean hideInitialized = false;

SearchPhase searchPhase;
boolean searchInitialized = false;

ThanksPhase thanksPhase;
boolean thanksInitialized = false;


//参加者のデータを格納するための二次元のHashMap
//id%5をキー、idを格納
HashMap<Integer, HashMap<Long, Integer>> playerIndex 
  = new HashMap<Integer, HashMap<Long, Integer>>();

//HashMapを操作するためのクラス
ManageMap manageMap = new ManageMap();

ArrayList<Player>    player    = new ArrayList<Player>();
ArrayList<HidePoint> hidePoint = new ArrayList<HidePoint>();

PImage plain, tree, cave, grass;

String filterTag   = "#FMS_new_test";
String tagSentence = "%23FMS_new_test";

enum PhaseOfSearch {
  SOMEONE_FOUND, 
    SEARCH, 
    WINNER,
};

void setup() {
  //APIを使うための設定
  apiSettings = new TwitterAPISettings();
  createTweet = new CreateTweet();

  size(800, 600);
  arial      = loadFont("ArialUnicodeMS-48.vlw");
  phase      = Phase.TITLE;
  titlePhase = new TitlePhase();

  plain = loadImage("plain.jpg");
  tree  = loadImage("tree.png");
  cave  = loadImage("doukutsu.png");
  grass = loadImage("kusamura.png");
}

void draw() {
  //background(#D6F6FF);
  //背景
  image(plain, 0, 0);
  image(tree, 0, 100, 200, 200);
  image(cave, 605, 420, 200, 200);
  image(grass, -30, 220, 300, 600);

  pushMatrix();
  translate(600, 0);
  fill(255, 200, 0);
  noStroke();
  ellipse(100, 100, 100, 100);
  for (int i=0; i<10; i++) {
    float x1 = 100 + 60 * cos( radians(40 * i -90) );
    float y1 = 100 + 60 * sin( radians(40 * i -90) );
    float x2 = 100 + 100 * cos( radians(40 * i -85) );
    float y2 = 100 + 100 * sin( radians(40 * i -85) );
    float x3 = 100 + 100 * cos( radians(40 * i -95) );
    float y3 = 100 + 100 * sin( radians(40 * i -95) );
    triangle(x1, y1, x2, y2, x3, y3);
  }
  strokeWeight(1);
  popMatrix();


  switch (phase) {

  case TITLE:
    titlePhase.display();
    break;

  case INVITE:
    //参加者を募るフェイズ
    if (!inviteInitialized) {
      invitePhase = new InvitePhase();
      inviteInitialized = true;
    }
    invitePhase.display();
    break;

  case HIDE:
    //参加者が隠れるフェイズ
    if (!hideInitialized) {
      //隠れ場所の追加
      hidePoint.add( new HidePoint(100, 250) );
      hidePoint.add( new HidePoint(150, 550) );
      hidePoint.add( new HidePoint(700, 100) );
      hidePoint.add( new HidePoint(700, 550) );

      hidePhase = new HidePhase();
      hideInitialized = true;
    }
    hidePhase.display();
    break;

  case SEARCH:
    //かめが探すフェイズ
    if (!searchInitialized) {
      searchPhase = new SearchPhase();
      searchInitialized = true;
    }
    searchPhase.display();
    break;

  case THANKS:
    if (!thanksInitialized) {
      thanksPhase = new ThanksPhase();
      thanksInitialized = true;
    }
    thanksPhase.display();
    break;
  }
}

void keyPressed() {
  if (keyCode==ENTER) {
    switch (phase) {

    case TITLE:
      phase = Phase.INVITE;
      break;

    case INVITE:
      phase = Phase.HIDE;
      break;

    case HIDE:
      phase = Phase.SEARCH;
      break;
    }
  } else if (keyCode==TAB) {
    phase = Phase.THANKS;
  }
}