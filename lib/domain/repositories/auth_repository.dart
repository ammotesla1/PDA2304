
import 'package:dartz/dartz.dart';
import 'package:pr2/domain/entity/role_entity.dart';

abstract class AuthRepository{

  String get tableName;

  Future<Either<String, RoleEnum>> signIn(String login, String password);
  Future<Either<String, bool>> signUp(String login, String password, String surname, String name, String middlename, String email);
}