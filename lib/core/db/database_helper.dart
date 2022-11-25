import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:pr2/data/model/car.dart';
import 'package:pr2/data/model/carColor.dart';
import 'package:pr2/data/model/engine.dart';
import 'package:pr2/data/model/favorite.dart';
import 'package:pr2/data/model/kppType.dart';
import 'package:pr2/data/model/mark.dart';
import 'package:pr2/data/model/user.dart';
import 'package:pr2/data/model/userInfo.dart';
import 'package:pr2/domain/entity/role_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../common/database_request.dart';
import '../../data/model/role.dart';
class DataBaseHelper{

  static final DataBaseHelper instance = DataBaseHelper._instance();
  DataBaseHelper._instance();

  late final Directory _appDocumentDirectory;
  late final String _pathDB;
  late final Database dataBase;
  final int _DBver = 1;


  Future<void> init() async {
    _appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    _pathDB = join(_appDocumentDirectory.path, 'auto.db');

    if(Platform.isLinux || Platform.isWindows || Platform.isMacOS){

      sqfliteFfiInit();
      dataBase = await databaseFactoryFfi.openDatabase(_pathDB, options: OpenDatabaseOptions(
        version: _DBver,
        onUpgrade: (db, oldVersion, newVersion) => onUpdateTable(db),

        onCreate: (db, version) async {
          await onCreateTable(db);
        },
      ));
    }
    else{
      dataBase = await openDatabase(
        _pathDB,
        version: _DBver,
        onCreate: (db, version) async {
          await onCreateTable(db);
        },
        onUpgrade: ((db, oldVersion, newVersion) => onUpdateTable(db))
      );
    }
  }

  Future<void> onCreateTable(Database db) async {
    for(var i = 0; i < DataBaseRequest.tableList.length; i++){
      await db.execute(DataBaseRequest.tableCreateList[i]);
    }
    db.execute('PRAGMA foreign_keys=on');
    await onInitTable(db);
  }

  Future<void> onInitTable(Database db) async {
    try{
      db.insert(DataBaseRequest.tableRole, Role(role: "Администратор").toMap());
      db.insert(DataBaseRequest.tableRole, Role(role: "Пользователь").toMap());

      db.insert(DataBaseRequest.tableUser, User(login: "Ammotesla", password: "123123Dd!", id_role: RoleEnum.admin).toMap());
      db.insert(DataBaseRequest.tableUser, User(login: "user", password: "123abC@111", id_role: RoleEnum.user).toMap());

      db.insert(DataBaseRequest.tableUserInfo, UserInfo(surname: 'Петров', name: 'Петр', middlename: 'Петрович', email: 'example@ex.com', id_user: 1).toMap());
      db.insert(DataBaseRequest .tableUserInfo, UserInfo(surname: 'Бивол', name: 'Данила', middlename: 'Сергеевич', email: 'ammo@gmail.com', id_user: 2).toMap());

      db.insert(DataBaseRequest.tableMark, Mark(mark_name: 'Hendai').toMap());
      db.insert(DataBaseRequest.tableMark, Mark(mark_name: 'Tayota').toMap());

      db.insert(DataBaseRequest.tableEngine, Engine(engine_type: 'Бензиновый').toMap());
      db.insert(DataBaseRequest.tableEngine, Engine(engine_type: 'Дизельный').toMap());

      db.insert(DataBaseRequest.tableCarColor, CarColor(car_color: 'Белый').toMap());
      db.insert(DataBaseRequest.tableCarColor, CarColor(car_color: 'Черный').toMap());

      db.insert(DataBaseRequest.tableKPPType, KPPType(kpp_type: 'Автомат').toMap());
      db.insert(DataBaseRequest.tableKPPType, KPPType(kpp_type: 'Механика').toMap());

      db.insert(DataBaseRequest.tableCar, Car(car_description: 'Hendai Solaris', car_cost: 35917300.00, car_year: '2000', car_mark_id: 2, car_engine_id: 1, car_color_id: 2, car_KPPtype_id: 1, car_photo: 'assets/images/3000GT.png').toMap());
      db.insert(DataBaseRequest.tableCar, Car(car_description: 'Tayota Camry', car_cost: 95095095.00, car_year: '2025', car_mark_id: 1, car_engine_id: 2, car_color_id: 1, car_KPPtype_id: 1, car_photo: 'assets/images/bmw.jpg').toMap());
    
      db.insert(DataBaseRequest.tableFavorite, Favorite(favorite_car_id: 1, favorite_user_id: 1).toMap());
      db.insert(DataBaseRequest.tableFavorite, Favorite(favorite_car_id: 2, favorite_user_id: 2).toMap());

    } on DatabaseException catch(e) {}
  }
  
  Future<void> onUpdateTable(Database db) async {
    var tables = await db.rawQuery('SELECT name FROM sqlite_master');

    for(var table in DataBaseRequest.tableCreateList){
      if(tables.contains(table)){
        await db.execute(DataBaseRequest.deleteTable(table));
      }
    }

    await onCreateTable(db);
  }

  Future<void> onDropDataBase() async {
    dataBase.close();
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      databaseFactoryFfi.deleteDatabase(_pathDB);
    } else {
      deleteDatabase(_pathDB);
    }
  }
}