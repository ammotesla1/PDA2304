class UserEntity{
  late int id;
  final String login;
  final String password;
  final int id_role;

  UserEntity({required this.login, required this.password, required this.id_role});
}

//enum UserEnum{user_admin, user_user}