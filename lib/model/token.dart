class Token {
  String refreshToken;
  String accessToken;

  Token({required this.accessToken, required this.refreshToken});

  factory Token.fromJson(Map<String, dynamic> json){
    return Token(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }


  Map<String, dynamic> toJson() {
   return {
    'refreshToken': refreshToken,
    'accessToken': accessToken,
    };
  }
}
