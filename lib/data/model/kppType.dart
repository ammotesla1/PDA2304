import 'package:pr2/domain/entity/kppType_entity.dart';

class KPPType extends KPPTypeEntity{
  late int id;
  final String kpp_type;

  KPPType({required this.kpp_type}) : super(kpp_type: kpp_type);

  Map<String, dynamic> toMap() {
    return {'kpp_type': kpp_type};
  }

  factory KPPType.toFromMap(Map<String, dynamic> json){
    return KPPType(kpp_type: json['kpp_type']);
  }
}