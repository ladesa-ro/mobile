class Token {
  static String _token = "";
  static String _refreshToken = "";

  static String get token => _token;
  static String get refreshToken => _refreshToken;

  static String setToken(String value) => _token = value;
  static String setRefreshToken(String value) => _refreshToken = refreshToken;
}
