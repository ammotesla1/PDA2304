import 'package:pr2/domain/entity/userInfo_entity.dart';

class UserInfo extends UserInfoEntity{
  late int id;
  final String surname;
  final String name;
  final String middlename;
  final String email;
  final int id_user;

  UserInfo({required this.surname, required this.name, required this.middlename, required this.email, required this.id_user}) : super (surname: surname, name: name, middlename: middlename, email: email, id_user: id_user);

  Map<String, dynamic> toMap() {
    return {'surname': surname,
            'name': name,
            'middlename': middlename,
            'email': email,
            'id_user': id_user};
  }

  factory UserInfo.toFromMap(Map<String, dynamic> json){
    return UserInfo(surname: json['surname'],
                    name: json['name'],
                    middlename: json['middlename'],
                    email: json['email'],
                    id_user: json['id_user']);
  }
}