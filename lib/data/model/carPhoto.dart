import 'package:pr2/domain/entity/carPhoto_entity.dart';

class CarPhoto extends CarPhotoEntity{
  late int id;
  final String photo;

  CarPhoto({required this.photo}) : super(photo: photo);

  Map<String, dynamic> toMap() {
    return {'photo': photo};
  }

  factory CarPhoto.toFromMap(Map<String, dynamic> json){
    return CarPhoto(photo: json['photo']);
  }
}