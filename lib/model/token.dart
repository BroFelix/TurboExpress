class Token {
  String token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) => Token(token: json["key"]);

  Map<String, dynamic> toJson() => {"key": token};
}
