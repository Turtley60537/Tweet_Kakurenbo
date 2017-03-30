//class MyStatusListener extends StatusAdapter {
//  public void onStatus(Status s) {
//    Tweet tweet = new Tweet(s);
//  }
//}

//class Tweet{
//  long id;
//  String text;
//  String name;
//  String screenName;
//  String iconUrl;
  
//  public Tweet(Status status){
//    text       = status.getText();      //本文
//    User user  = status.getUser();
//    id         = user.getId();          //固有id
//    name       = user.getName();        //ユーザー名
//    screenName = user.getScreenName();  //@name
//    iconUrl    = user.getProphileImageURL();
    
//    println(name, screenName, id);
//    println("  " + text);
//    println();
    
//    if (phase==1){
//      if(!containJoinWord()){
//        pritnln("関係ないツイート\n");
//        return;
//      } else if( manageMap.alreadySaved(id) ){
        
//      }
//    }
//}