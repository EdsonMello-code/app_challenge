import 'package:challenge/app/features/home/presenter/controllers/favorited_controller.dart';
import 'package:challenge/app/features/home/presenter/controllers/state/food_favorited_state.dart';
import 'package:challenge/app/features/home/presenter/pages/widgets/food_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritedPage extends StatefulWidget {
  const FavoritedPage({Key? key}) : super(key: key);

  @override
  State<FavoritedPage> createState() => _FavoritedPageState();
}

class _FavoritedPageState
    extends ModularState<FavoritedPage, FavoritedController> {
  static const _iconSize = 100.0;
  @override
  void initState() {
    super.initState();
    controller.fetchFoodOffline();
  }

  Future<void> _onTapFavorited(FoodFavoritedStateSuccess state, index) async {
    if (state.foods[index].isSelected) {
      state.foods[index].isSelected = false;
      await controller.removeFood(id: state.foods[index].id);
    } else {
      state.foods[index].isSelected = true;
      await controller.saveFood(
        food: state.foods[index],
      );
    }
    await controller.fetchFoodOffline();
  }

  Widget _handleSwitchFavoriteState({required FoodFavoritedState state}) {
    if (state is FoodFavoritedStateLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is FoodFavoritedStateFailure) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(state.message),
            const Icon(
              Icons.error,
              size: _iconSize,
            ),
          ],
        ),
      );
    } else if (state is FoodFavoritedStateSuccess) {
      if (state.foods.isEmpty) {
        return const Center(
          child: Icon(
            Icons.hourglass_empty,
            size: _iconSize,
          ),
        );
      }

      return ListView.builder(
        itemCount: state.foods.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return FoodTile(
            food: state.foods[index],
            onTap: () async => await _onTapFavorited(
              state,
              index,
            ),
          );
        },
      );
    } else if (state is FoodFavoritedStateFailure) {
      return Center(
        child: Column(
          children: [
            Text(state.message),
            const Icon(
              Icons.error_outline,
              size: 100,
            )
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Modular.to.navigate('/');
            },
          ),
          title: const Text('Favoritos'),
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: ValueListenableBuilder<FoodFavoritedState>(
            valueListenable: controller,
            builder: (context, state, child) {
              return _handleSwitchFavoriteState(state: state);
            },
          ),
        ),
      ),
    );
  }
}
