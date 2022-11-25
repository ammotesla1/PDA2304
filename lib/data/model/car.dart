import 'package:pr2/domain/entity/car_entity.dart';

class Car extends CarEntity{
  late int id;
  final String car_description;
  final double car_cost;
  final String car_year;
  final int car_mark_id;
  final int car_engine_id;
  final int car_color_id;
  final int car_KPPtype_id;
  final String car_photo;

  Car({required this.car_description, required this.car_cost, required this.car_year, required this.car_mark_id, required this.car_engine_id, required this.car_color_id, required this.car_KPPtype_id, required this.car_photo}) : super(car_description: car_description, car_cost: car_cost, car_year: car_year, car_mark_id: car_mark_id, car_engine_id: car_engine_id, car_color_id: car_color_id, car_KPPtype_id: car_KPPtype_id, car_photo: car_photo);

  Map<String, dynamic> toMap() {
    return {'car_description' : car_description,
            'car_cost' : car_cost,
            'car_year' : car_year,
            'car_mark_id' : car_mark_id,
            'car_engine_id' : car_engine_id,
            'car_color_id' : car_color_id,
            'car_KPPtype_id' : car_KPPtype_id,
            'car_photo' : car_photo};
  }

  factory Car.toFromMap(Map<String, dynamic> json){
    return Car(car_description: json['car_description'],
               car_cost: json['car_cost'],
               car_year: json['car_year'],
               car_mark_id: json['car_mark_id'],
               car_engine_id: json['car_engine_id'],
               car_color_id: json['car_color_id'],
               car_KPPtype_id: json['car_KPPtype_id'],
               car_photo: json['car_photo']);
  }
}