class TwitterAPISettings {
  //自分のキーを入力　配布時参照不可　
  String[] lines;


  TwitterAPISettings() {
    lines = loadStrings("../twitterOathKey.txt");
    final String consumerKey       = lines[0];
    final String consumerSecret    = lines[1];
    final String accessToken       = lines[2];
    final String accessTokenSecret = lines[3];
    rest(consumerKey, consumerSecret, accessToken, accessTokenSecret);
    stream(consumerKey, consumerSecret, accessToken, accessTokenSecret);

    //イベントを受け取るリスナーオブジェクトを設定
    stream.addListener( new MyStatusListener() );

    //取得ツイートを自分のフォローする人のツイートに設定
    //stream.user();
    //取得ツイートをキーワードが含まれるツイートに設定
    stream.filter(filterTag);
  }


  void rest(String _consumerKey, String _consumerSecret, String _accessToken, String _accessTokenSecret) {
    //RestのConfigurationを生成するためのビルダーオブジェクトを生成
    ConfigurationBuilder cb_rest = new ConfigurationBuilder();

    //キー設定
    cb_rest.setOAuthConsumerKey      ( _consumerKey       );
    cb_rest.setOAuthConsumerSecret   ( _consumerSecret    );
    cb_rest.setOAuthAccessToken      ( _accessToken       );
    cb_rest.setOAuthAccessTokenSecret( _accessTokenSecret );

    //TwitterRestのインスタンスを生成
    rest = new TwitterFactory( cb_rest.build() ).getInstance();
  }

  void stream(String _consumerKey, String _consumerSecret, String _accessToken, String _accessTokenSecret) {
    //StreamのConfigurationを生成するためのビルダーオブジェクトを生成
    ConfigurationBuilder cb_stream = new ConfigurationBuilder();

    //キー設定
    cb_stream.setOAuthConsumerKey      ( _consumerKey       );
    cb_stream.setOAuthConsumerSecret   ( _consumerSecret    );
    cb_stream.setOAuthAccessToken      ( _accessToken       );
    cb_stream.setOAuthAccessTokenSecret( _accessTokenSecret );

    //TwitterStreamのインスタンスを生成
    TwitterStreamFactory streamFactory 
      = new TwitterStreamFactory( cb_stream.build() );

    stream = streamFactory.getInstance();
  }
}