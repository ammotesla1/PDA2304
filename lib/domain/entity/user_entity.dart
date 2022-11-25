import 'package:pr2/domain/entity/role_entity.dart';

class UserEntity{
  late int id;
  final String login;
  final String password;
  final RoleEnum id_role;

  UserEntity({required this.login, required this.password, required this.id_role});
}

//enum UserEnum{user_admin, user_user}