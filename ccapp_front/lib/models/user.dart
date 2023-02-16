class User {
  final String email;
  final String nickname;
  final AccessToken? token;

  const User({
    required this.email,
    required this.nickname,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        nickname: json['nickname'],
        token: json['token'][''],
      );
}

class AccessToken {
  final String accessToken;
  final String refreshToken;

  const AccessToken({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
      );
}
