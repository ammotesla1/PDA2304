import 'dart:developer';
import 'package:pr2/core/crypto/crypto.dart';
import 'package:pr2/domain/entity/user_entity.dart';
import '../../domain/entity/role_entity.dart';

class User extends UserEntity{
  late int id;
  final String login;
  final String password;
  final RoleEnum id_role;

  User({required this.login, required this.password, required this.id_role}) : super(login: login, password: password, id_role: id_role);

  Map<String, dynamic> toMap() {
    return {'login': login,
            'password' : Crypto.encode(password),
            'id_role' : id_role.id};
  }

  factory User.toFromMap(Map<String, dynamic> json){
    return User(login: json['login'],
                password: json['password'],
                id_role: RoleEnum.values.firstWhere((element) => element.id == (json['id_role'] as int))
    );
  }
}