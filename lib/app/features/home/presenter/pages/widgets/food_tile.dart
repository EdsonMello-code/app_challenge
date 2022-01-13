import 'package:challenge/app/features/home/domain/entities/food_entity.dart';
import 'package:challenge/app/features/home/presenter/controllers/favorited_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FoodTile extends StatefulWidget {
  final FoodEntity food;
  final Future<void> Function()? onTap;

  const FoodTile({
    Key? key,
    required this.food,
    this.onTap,
  }) : super(key: key);

  @override
  State<FoodTile> createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> {
  final FavoritedController favoriteController = Modular.get();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 400),
          tween: Tween(begin: 0, end: 1),
          builder: (context, value, _) {
            return Opacity(
              opacity: value,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 1,
                    color: widget.food.isSelected
                        ? Colors.black26
                        : Colors.transparent,
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onDoubleTap: widget.onTap ??
                      () async {
                        if (widget.food.isSelected) {
                          widget.food.isSelected = false;
                          await favoriteController.removeFood(
                            id: widget.food.id,
                          );
                        } else {
                          widget.food.isSelected = true;
                          await favoriteController.saveFood(food: widget.food);
                        }
                        setState(() {});
                      },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              widget.food.imageUrl,
                              fit: BoxFit.cover,
                              height: size.height * .1,
                              width: size.width * .2,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width * .4,
                                child: Text(
                                  widget.food.title,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(widget.food.publisher),
                            ],
                          ),
                          widget.food.isSelected
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(Icons.favorite_border),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
