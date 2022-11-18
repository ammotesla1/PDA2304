abstract class DataBaseRequest{
  static const String tableRole = 'Role';
  static const String tableUser = 'User';
  static const String tableUserInfo = 'UsersInfo';
  static const String tableFavorite = 'Favorite';
  static const String tableCar = 'Car';
  static const String tableMark = 'Mark';
  static const String tableEngine = 'Engine';
  static const String tableCarColor = 'CarColor';
  static const String tableKPPType = 'KPPType';
  static const String tableCarPhoto = 'CarPhoto';

  static const List<String> tableList = [
    tableRole,
    tableUser,
    tableUserInfo,
    tableFavorite,
    tableCar,
    tableMark,
    tableEngine,
    tableCarColor,
    tableKPPType,
    tableCarPhoto
  ];
  static const List<String> tableCreateList = [
    _createTableRole,
    _createTableUser,
    _createTableUserInfo,
    _createTableMark,
    _createTableEngine,
    _createTableCarColor,
    _createTableKPPType,
    _createTableCarPhoto,
    _createTableCar,
    _createTableFavorite
  ];

  static const String _createTableRole =
      'CREATE TABLE "$tableRole" ("id" INTEGER,"role" TEXT NOT NULL UNIQUE, PRIMARY KEY("id" AUTOINCREMENT))';

  static const String _createTableUser =
      'CREATE TABLE "$tableUser" ("id" INTEGER,"login" TEXT NOT NULL UNIQUE,"password" TEXT NOT NULL, "id_role" INTEGER NOT NULL, PRIMARY KEY("id" AUTOINCREMENT), FOREIGN KEY("id_role") REFERENCES "Role"("id"))';

  static const String _createTableUserInfo =
      'CREATE TABLE "$tableUserInfo" ("id" INTEGER, "surname" TEXT NOT NULL, "name" TEXT NOT NULL, "middlename" TEXT NOT NULL, "email" TEXT NOT NULL, "id_user" INTEGER NOT NULL, PRIMARY KEY("id" AUTOINCREMENT), FOREIGN KEY("id_user") REFERENCES "User"("id"))';

  static const String _createTableMark =
      'CREATE TABLE "$tableMark" ("id" INTEGER,"mark_name" TEXT NOT NULL UNIQUE, PRIMARY KEY("id" AUTOINCREMENT))';

  static const String _createTableEngine =
      'CREATE TABLE "$tableEngine" ("id" INTEGER,"engine_type" TEXT NOT NULL UNIQUE, PRIMARY KEY("id" AUTOINCREMENT))';

  static const String _createTableCarColor =
      'CREATE TABLE "$tableCarColor" ("id" INTEGER,"car_color" TEXT NOT NULL UNIQUE, PRIMARY KEY("id" AUTOINCREMENT))';

  static const String _createTableKPPType =
      'CREATE TABLE "$tableKPPType" ("id" INTEGER,"kpp_type" TEXT NOT NULL UNIQUE, PRIMARY KEY("id" AUTOINCREMENT))';

  static const String _createTableCarPhoto =
      'CREATE TABLE "$tableCarPhoto" ("id" INTEGER,"photo" BLOB NOT NULL, "photo_description", PRIMARY KEY("id" AUTOINCREMENT))';

  static const String _createTableCar =
      'CREATE TABLE "$tableCar" ("id" INTEGER, "car_description" TEXT NOT NULL, "car_cost" DECIMAL NOT NULL, "car_year" TEXT NOT NULL, "car_mark_id" INTEGER NOT NULL, "car_engine_id" INTEGER NOT NULL, "car_color_id" INTEGER NOT NULL, "car_KPPtype_id" INTEGER NOT NULL, "car_photo_id" INTEGER NOT NULL, PRIMARY KEY("id" AUTOINCREMENT), FOREIGN KEY("car_mark_id") REFERENCES "$tableMark"("id"), FOREIGN KEY("car_engine_id") REFERENCES "$tableEngine"("id"), FOREIGN KEY("car_color_id") REFERENCES "$tableCarColor"("id"), FOREIGN KEY("car_KPPtype_id") REFERENCES "$tableKPPType"("id"), FOREIGN KEY("car_photo_id") REFERENCES "$tableCarPhoto"("id"))';
  
  static const String _createTableFavorite =
      'CREATE TABLE "$tableFavorite" ("id" INTEGER, "favorite_car_id" INTEGER NOT NULL, "favorite_user_id" INTEGER NOT NULL, PRIMARY KEY("id" AUTOINCREMENT), FOREIGN KEY("favorite_car_id") REFERENCES "$tableCar"("id"), FOREIGN KEY("favorite_user_id") REFERENCES "$tableUser"("id"))';

  static String deleteTable(String table) => 'DROP TABLE IF EXISTS $table';
}