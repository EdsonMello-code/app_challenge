class FoodEntity {
  final String publisher;
  bool isSelected;
  final String imageUrl;
  final String originUrl;
  final String title;
  final String id;

  FoodEntity({
    required this.id,
    required this.publisher,
    required this.title,
    required this.imageUrl,
    required this.originUrl,
    this.isSelected = false,
  });
}
