import 'package:challenge/app/features/home/domain/entities/food_entity.dart';
import 'package:equatable/equatable.dart';

class FoodModel extends Equatable implements FoodEntity {
  @override
  final String id;

  @override
  final String imageUrl;

  @override
  bool isSelected;

  @override
  final String originUrl;

  @override
  final String publisher;

  @override
  final String title;

  FoodModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.originUrl,
    required this.publisher,
    this.isSelected = false,
  });

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['recipe_id'],
      title: map['title'],
      publisher: map['publisher'],
      imageUrl: map['image_url'],
      originUrl: map['source_url'],
    );
  }

  factory FoodModel.fromMapDatabase(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'],
      title: map['title'],
      publisher: map['publisher'],
      imageUrl: map['imageUrl'],
      originUrl: map['originUrl'],
      isSelected: map['isSelected'] == 1 ? true : false,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
        originUrl,
        publisher,
      ];
}
