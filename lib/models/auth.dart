class Auth {
  String idToken;
  int teamId;

  Auth({required this.idToken, required this.teamId});

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    idToken: json["token"],
    teamId: json["teamId"],
  );
}