class Auth {
  String idToken;

  Auth({required this.idToken});

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    idToken: json["token"],
  );

}