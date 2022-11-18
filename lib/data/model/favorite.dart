import 'package:pr2/domain/entity/favorite_entity.dart';

class Favorite extends FavoriteEntity{
  late int id;
  final int favorite_car_id;
  final int favorite_user_id;

  Favorite({required this.favorite_car_id, required this.favorite_user_id}) : super(favorite_car_id: favorite_car_id, favorite_user_id: favorite_user_id);

  Map<String, dynamic> toMap() {
    return {'favorite_car_id': favorite_car_id,
            'favorite_user_id' : favorite_user_id};
  }

  factory Favorite.toFromMap(Map<String, dynamic> json){
    return Favorite(favorite_car_id: json['favorite_car_id'],
                    favorite_user_id: json['favorite_user_id']);
  }
}