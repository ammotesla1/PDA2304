

import 'package:pr2/domain/entity/engine_entity.dart';

class Engine extends EngineEntity{
  late int id;
  final String engine_type;

  Engine({required this.engine_type}) : super(engine_type: engine_type);

  Map<String, dynamic> toMap() {
    return {'engine_type': engine_type};
  }

  factory Engine.toFromMap(Map<String, dynamic> json){
    return Engine(engine_type: json['engine_type']);
  }
}