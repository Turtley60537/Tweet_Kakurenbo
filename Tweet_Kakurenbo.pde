//現在ツイッター関連の実装はなし

//import twitter4j.*;
//import twitter4j.api.*;
//import twitter4j.conf.*;
//import twitter4j.http.*;
//import twitter4j.internal.async.*;
//import twitter4j.internal.http.*;
//import twitter4j.internal.logging.*;
//import twitter4j.internal.org.json.*;
//import twitter4j.internal.util.*;
//import twitter4j.util.*;



PFont arial;
//phase...
//0:invite
//1:
ArrayList<User>      user      = new ArrayList<User>();
ArrayList<HidePoint> hidePoint = new ArrayList<HidePoint>();

int phase;

TitlePhase titlePhase = new TitlePhase();

InvitePhase invitePhase;
boolean inviteInitialized = false;

HidePhase hidePhase;
boolean hideInitialized = false;

SearchPhase searchPhase;
boolean searchInitialized = false;
boolean someoneFoundFlag = false;
ArrayList<User> foundUser = new ArrayList<User>();
Kame kame;
boolean emargeKameFlag = false;

void setup() {
  size(800, 600);
  arial = loadFont("ArialUnicodeMS-48.vlw");
  phase = 0;

  hidePoint.add( new HidePoint(100, 100) );
  hidePoint.add( new HidePoint(200, 500) );
  hidePoint.add( new HidePoint(750, 200) );
  hidePoint.add( new HidePoint(500, 500) );

  kame = new Kame();
}

void draw() {
  background(#D6F6FF);
  if ( phase==0 ) {

    titlePhase.display();
  } else if ( phase==1 ) {

    //参加者を募るフェイズ
    if (!inviteInitialized) {
      invitePhase = new InvitePhase();
      inviteInitialized = true;
    }
    invitePhase.display();
  } else if (phase==2) {

    //参加者が隠れるフェイズ
    if (!hideInitialized) {
      hidePhase = new HidePhase();
      hideInitialized = true;
    }
    hidePhase.display();
  } else if (phase==3) {

    //かめが探すフェイズ
    if (!searchInitialized) {
      searchPhase = new SearchPhase();
      searchInitialized = true;
    }
    searchPhase.display();
  }
}

void keyPressed() {
  switch(keyCode) {
  case ENTER:
    if (phase==0) {
      phase = 1;
    } else if (phase==1) {
      phase = 2;
    } else if (phase==2) {
      phase = 3;
    }
    break;

  case TAB:
    if (phase==1) {
      user.add( new User() );
    }
    break;
  }
}