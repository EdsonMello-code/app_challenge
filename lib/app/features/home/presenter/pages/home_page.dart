import 'package:challenge/app/features/home/presenter/controllers/state/food_state.dart';
import 'package:challenge/app/features/home/presenter/controllers/home_controller.dart';
import 'package:challenge/app/features/home/presenter/pages/widgets/food_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  late final TextEditingController _textFieldController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    _textFieldController = TextEditingController();
    _focusNode = FocusNode();

    controller.fetchFoods(foodName: 'Pizza');
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  bool _isStateLoaded(FoodState state) {
    if (state is FoodStateSuccess || state is! FoodStateLoading) {
      return true;
    }
    return false;
  }

  void _goToFavoritedPage(FoodState state) {
    if (_isStateLoaded(state)) {
      Modular.to.pushReplacementNamed('/favorited');
    }
  }

  Future<void> _handleSearchFood() async {
    final food = _textFieldController.text;
    await controller.fetchFoods(foodName: food);
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      focusNode: _focusNode,
                      onEditingComplete: _handleSearchFood,
                      controller: _textFieldController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.search,
                            size: 24,
                          ),
                          onPressed: _handleSearchFood,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ValueListenableBuilder<FoodState>(
                      valueListenable: controller,
                      builder: (context, state, __) {
                        if (state is FoodStateLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is FoodStateFailures) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.no_food,
                                  size: 100,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  state.message,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (state is FoodStateSuccess) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: state.foods.length,
                            itemBuilder: (_, index) {
                              return FoodTile(
                                food: state.foods[index],
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: ValueListenableBuilder<FoodState>(
                  valueListenable: controller,
                  builder: (context, state, _) {
                    return GestureDetector(
                      onTap: () => _goToFavoritedPage(state),
                      child: Container(
                        width: size.width,
                        height: 100,
                        color: Colors.black,
                        child: const Center(
                          child: Icon(
                            Icons.favorite,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
