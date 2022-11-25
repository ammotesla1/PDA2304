
import 'package:dartz/dartz.dart';
import 'package:pr2/core/usecases/auth_usecases.dart';
import 'package:pr2/domain/entity/role_entity.dart';
import 'package:pr2/domain/repositories/auth_repository.dart';

class Auth implements AuthUserCases<String, AuthParams, RegParams>{

  final AuthRepository authRepository;
  Auth(this.authRepository);

  @override
  Future<Either<String, bool>> signUp(RegParams params) {
    
    return authRepository.signUp(params.login, params.password, params.surname, params.name, params.middlename, params.email);
  }

  @override
  Future<Either<String, RoleEnum>> singIn(AuthParams params) {
    
    return authRepository.signIn(params.login, params.password);
  }

  
}

class AuthParams{

  final String login;
  final String password;

  AuthParams({ required this.login, required this.password});
}

class RegParams{

  final String login;
  final String password;
  final String surname;
  final String name;
  final String middlename;
  final String email;

  RegParams({ required this.login, required this.password, required this.surname, required this.name, required this.middlename, required this.email});
}