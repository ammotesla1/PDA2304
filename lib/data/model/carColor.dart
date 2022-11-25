import 'package:pr2/domain/entity/carColor_entity.dart';

class CarColor extends CarColorEntity{
  late int id;
  final String car_color;

  CarColor({required this.car_color}) : super(car_color: car_color);

  Map<String, dynamic> toMap() {
    return {'car_color': car_color};
  }

  factory CarColor.toFromMap(Map<String, dynamic> json){
    return CarColor(car_color: json['car_color']);
  }
}