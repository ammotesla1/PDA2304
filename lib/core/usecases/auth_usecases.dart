import 'package:flutter/widgets.dart';
import 'package:pr2/domain/entity/role_entity.dart';

import 'package:dartz/dartz.dart';

abstract class AuthUserCases<String, Params, Params2>{

  Future<Either<String, RoleEnum>> singIn(Params params);
  Future<Either<String, bool>> signUp(Params2 params);
}