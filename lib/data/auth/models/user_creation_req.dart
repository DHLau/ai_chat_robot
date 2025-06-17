class UserCreationReq {
  String? username;
  String email;
  String password;

  UserCreationReq({this.username, required this.email, required this.password});
}
