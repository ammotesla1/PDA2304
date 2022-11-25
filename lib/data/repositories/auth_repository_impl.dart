
import 'package:dartz/dartz.dart';
import 'package:pr2/common/database_request.dart';
import 'package:pr2/core/crypto/crypto.dart';
import 'package:pr2/core/db/database_helper.dart';
import 'package:pr2/data/model/userInfo.dart';
import 'package:pr2/domain/entity/role_entity.dart';
import 'package:pr2/domain/repositories/auth_repository.dart';
import 'package:sqflite/sqlite_api.dart';

import '../model/user.dart';

class AuthRepositoryImpl implements AuthRepository{

  final db_ = DataBaseHelper.instance.dataBase;

  @override
  Future<Either<String, RoleEnum>> signIn(String login, String password) async {
    
    try{
      
      final user = (await db_.query(
        tableName,
        columns: ['login', 'password', 'id_role'],
        where: 'login = ?',
        whereArgs: [login])).map((e) => User.toFromMap(e));

        if(user.isEmpty)
          return Left('Этого пользователя не существует!');

        if(user.first.password != Crypto.encode(password))
          return Left('Неверный пароль!');

        return Right(user.first.id_role);
    } on DatabaseException catch(error){
      print(error.result);
      return Left('Ошибка проверки данных!');
    }
  }

  @override
  Future<Either<String, bool>> signUp(String login, String password, String surname, String name, String middlename, String email) async {
    
    try{

      await db_.insert(tableName, User(login: login, password: password, id_role: RoleEnum.user).toMap());

      int userID = await db_.execute('''SELECT LAST_INSERT_ID()''') as int;
      await db_.insert(DataBaseRequest.tableUserInfo, UserInfo(surname: surname, name: name, middlename: middlename, email: email, id_user: userID).toMap());
      return const Right(true);
    } on DatabaseException catch(error){

      print(error.result);
      return const Left('error');
    }
  }

  @override
  String get tableName => DataBaseRequest.tableUser;
}