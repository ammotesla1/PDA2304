import 'package:pr2/domain/entity/mark_entity.dart';

class Mark extends MarkEntity{
   late int id;
   final String mark_name;

  Mark ({required this.mark_name}) : super(mark_name: mark_name);

  Map<String, dynamic> toMap() {
    return {'mark_name': mark_name};
  }

  factory Mark.toFromMap(Map<String, dynamic> json){
    return Mark(mark_name: json['mark_name']);
  }
}