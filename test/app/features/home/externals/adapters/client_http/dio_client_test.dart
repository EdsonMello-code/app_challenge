import 'package:challenge/app/features/home/externals/adapters/http_client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late DioMock dio;

  late DioClient httpClient;
  setUp(() {
    dio = dio = DioMock(BaseOptions());
    httpClient = DioClient(client: dio);
  });
  group('Dio client | get', () {
    test(
        'Should return response with data not null then this method is called.',
        () async {
      when(
        () => dio.get(
          any(),
        ),
      ).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/search'),
            data: recipe,
          ));

      final response = await httpClient.get(endPoint: '/search');
      expect(response.data, isNotNull);
      expect(response.data, isNotEmpty);
    });

    test('Should return error then this method is called.', () async {
      when(
        () => dio.get(
          any(),
        ),
      ).thenThrow(
        DioError(
          requestOptions: RequestOptions(
            path: '/search',
          ),
        ),
      );

      try {
        final response = await httpClient.get(endPoint: '/search');
        expect(response.data, isNull);
      } catch (e) {
        expect(e, isException);
      }
    });
  });
}

class DioMock extends Mock implements Dio {
  @override
  final BaseOptions options;

  DioMock(this.options);
}

const recipe = {
  "count": 28,
  "recipes": [
    {
      "publisher": "The Pioneer Woman",
      "title": "The Best Chocolate Sheet Cake. Ever.",
      "source_url":
          "http://thepioneerwoman.com/cooking/2007/06/the_best_chocol/",
      "recipe_id": "fbc7af",
      "image_url":
          "http://forkify-api.herokuapp.com/images/388604527_5e6812454fc6f7.jpg",
      "social_rank": 100,
      "publisher_url": "http://thepioneerwoman.com"
    },
    {
      "publisher": "Two Peas and Their Pod",
      "title": "Red Velvet Cheesecake Cookies",
      "source_url":
          "http://www.twopeasandtheirpod.com/red-velvet-cheesecake-cookies/",
      "recipe_id": "54439",
      "image_url":
          "http://forkify-api.herokuapp.com/images/redvelvetcheesecakecookiesace1.jpg",
      "social_rank": 100,
      "publisher_url": "http://www.twopeasandtheirpod.com"
    },
    {
      "publisher": "Two Peas and Their Pod",
      "title": "Chocolate Sheet Cake with Peanut Butter Frosting",
      "source_url":
          "http://www.twopeasandtheirpod.com/chocolate-sheet-cake-with-peanut-butter-frosting/",
      "recipe_id": "54363",
      "image_url":
          "http://forkify-api.herokuapp.com/images/chocolatesheetcakewithpeanutbutterfrosting3a2ac.jpg",
      "social_rank": 99.99999999999997,
      "publisher_url": "http://www.twopeasandtheirpod.com"
    },
    {
      "publisher": "My Baking Addiction",
      "title": "Cadbury Creme Egg Cupcakes",
      "source_url":
          "http://www.mybakingaddiction.com/cadbury-creme-egg-cupcakes/",
      "recipe_id": "b66bb2",
      "image_url":
          "http://forkify-api.herokuapp.com/images/CadburyEgg1of1adf2.jpg",
      "social_rank": 99.99999999999957,
      "publisher_url": "http://www.mybakingaddiction.com"
    },
    {
      "publisher": "The Pioneer Woman",
      "title": "Knock You Naked Brownies",
      "source_url":
          "http://thepioneerwoman.com/cooking/2011/05/knock-you-naked-brownies/",
      "recipe_id": "47030",
      "image_url": "http://forkify-api.herokuapp.com/images/browniesf86b.jpg",
      "social_rank": 99.99999999999861,
      "publisher_url": "http://thepioneerwoman.com"
    },
    {
      "publisher": "Two Peas and Their Pod",
      "title": "Red Velvet Crinkle Cookies",
      "source_url":
          "http://www.twopeasandtheirpod.com/red-velvet-crinkle-cookies/",
      "recipe_id": "54416",
      "image_url":
          "http://forkify-api.herokuapp.com/images/redvelvetcrinklecookies6b61.jpg",
      "social_rank": 99.99999999999416,
      "publisher_url": "http://www.twopeasandtheirpod.com"
    },
    {
      "publisher": "The Pioneer Woman",
      "title": "Chocolate Strawberry Nutella Cake",
      "source_url":
          "http://thepioneerwoman.com/cooking/2013/05/chocolate-strawberry-nutella-cake/",
      "recipe_id": "ddf639",
      "image_url": "http://forkify-api.herokuapp.com/images/cake21c897.jpg",
      "social_rank": 99.99999999999709,
      "publisher_url": "http://thepioneerwoman.com"
    },
    {
      "publisher": "The Pioneer Woman",
      "title": "The Best Coffee Cake. Ever.",
      "source_url":
          "http://thepioneerwoman.com/cooking/2010/06/the-best-coffee-cake-ever/",
      "recipe_id": "47128",
      "image_url":
          "http://forkify-api.herokuapp.com/images/4706096854_ed734b479d_bbc66.jpg",
      "social_rank": 99.9999999999645,
      "publisher_url": "http://thepioneerwoman.com"
    },
    {
      "publisher": "All Recipes",
      "title": "St. Patrick's Chocolate & Mint Cheesecake Bars",
      "source_url":
          "http://allrecipes.com/Recipe/St-Patricks-Chocolate--Mint-Cheesecake-Bars/Detail.aspx",
      "recipe_id": "30501",
      "image_url": "http://forkify-api.herokuapp.com/images/79484833e4.jpg",
      "social_rank": 99.999999999957,
      "publisher_url": "http://allrecipes.com"
    },
    {
      "publisher": "All Recipes",
      "title": "Too Much Chocolate Cake",
      "source_url":
          "http://allrecipes.com/Recipe/Too-Much-Chocolate-Cake/Detail.aspx",
      "recipe_id": "32997",
      "image_url": "http://forkify-api.herokuapp.com/images/518798fb0d.jpg",
      "social_rank": 99.99999999994877,
      "publisher_url": "http://allrecipes.com"
    },
    {
      "publisher": "The Pioneer Woman",
      "title": "Red Velvet Sheet Cake",
      "source_url":
          "http://thepioneerwoman.com/cooking/2011/04/red-velvet-sheet-cake/",
      "recipe_id": "47038",
      "image_url":
          "http://forkify-api.herokuapp.com/images/5587851660_5c7cdce3c0_ob1fa.jpg",
      "social_rank": 99.99999999994454,
      "publisher_url": "http://thepioneerwoman.com"
    },
    {
      "publisher": "The Pioneer Woman",
      "title": "Strawberry Sparkle Cake",
      "source_url":
          "http://thepioneerwoman.com/cooking/2012/07/strawberry-sparkle-cake/",
      "recipe_id": "46914",
      "image_url": "http://forkify-api.herokuapp.com/images/sparkle7fbe.jpg",
      "social_rank": 99.99999999970025,
      "publisher_url": "http://thepioneerwoman.com"
    },
    {
      "publisher": "The Pioneer Woman",
      "title": "Devil Dogs",
      "source_url": "http://thepioneerwoman.com/cooking/2011/02/devil-dogs/",
      "recipe_id": "47051",
      "image_url":
          "http://forkify-api.herokuapp.com/images/5471010984_60c9544d59_o24c7.jpg",
      "social_rank": 99.9999999992133,
      "publisher_url": "http://thepioneerwoman.com"
    },
    {
      "publisher": "Pastry Affair",
      "title":
          "Black Tea Cake with Honey&nbsp;Buttercream - Home - Pastry Affair",
      "source_url":
          "http://www.pastryaffair.com/blog/black-tea-cake-with-honey-buttercream.html",
      "recipe_id": "9a4dbe",
      "image_url":
          "http://forkify-api.herokuapp.com/images/8490340733_91c07b6f0c_b149f.jpg",
      "social_rank": 99.99999999789654,
      "publisher_url": "http://www.pastryaffair.com"
    },
    {
      "publisher": "The Pioneer Woman",
      "title": "PW’s Mother-in-Law’s Christmas Rum Cake",
      "source_url":
          "http://thepioneerwoman.com/cooking/2008/12/christmas-rum-cake/",
      "recipe_id": "47276",
      "image_url":
          "http://forkify-api.herokuapp.com/images/3091271500_7c54a3064f_o11819.jpg",
      "social_rank": 99.99999999713246,
      "publisher_url": "http://thepioneerwoman.com"
    },
    {
      "publisher": "My Baking Addiction",
      "title": "Rolo Brownies",
      "source_url": "http://www.mybakingaddiction.com/rolo-brownies-recipe/",
      "recipe_id": "de0320",
      "image_url":
          "http://forkify-api.herokuapp.com/images/rolobrownies9765.jpg",
      "social_rank": 99.99999999472064,
      "publisher_url": "http://www.mybakingaddiction.com"
    },
    {
      "publisher": "The Pioneer Woman",
      "title": "Coffee Cake (Literally!)",
      "source_url":
          "http://thepioneerwoman.com/cooking/2009/08/coffee-cake-literally/",
      "recipe_id": "47206",
      "image_url":
          "http://forkify-api.herokuapp.com/images/3851565629_02499b845fc565.jpg",
      "social_rank": 99.99999999396194,
      "publisher_url": "http://thepioneerwoman.com"
    },
    {
      "publisher": "101 Cookbooks",
      "title": "Chocolate Bundt Cake",
      "source_url":
          "http://www.101cookbooks.com/archives/chocolate-bundt-cake-recipe.html",
      "recipe_id": "47647",
      "image_url":
          "http://forkify-api.herokuapp.com/images/chocolate_bundt_cake_recipeec22.jpg",
      "social_rank": 99.99999997558612,
      "publisher_url": "http://www.101cookbooks.com"
    },
    {
      "publisher": "All Recipes",
      "title": "Tiramisu Layer Cake",
      "source_url":
          "http://allrecipes.com/Recipe/Tiramisu-Layer-Cake/Detail.aspx",
      "recipe_id": "32738",
      "image_url": "http://forkify-api.herokuapp.com/images/988275fbb0.jpg",
      "social_rank": 99.99999995969893,
      "publisher_url": "http://allrecipes.com"
    },
    {
      "publisher": "Two Peas and Their Pod",
      "title": "Chocolate Sour Cream Bundt Cake",
      "source_url":
          "http://www.twopeasandtheirpod.com/chocolate-sour-cream-bundt-cake/",
      "recipe_id": "54282",
      "image_url":
          "http://forkify-api.herokuapp.com/images/ChocolateSourCreamBundtCake46887.jpg",
      "social_rank": 99.99999982322893,
      "publisher_url": "http://www.twopeasandtheirpod.com"
    },
    {
      "publisher": "Epicurious",
      "title": "Banana-Chocolate Chip Cake with Peanut Butter Frosting",
      "source_url":
          "http://www.epicurious.com/recipes/food/views/Banana-Chocolate-Chip-Cake-with-Peanut-Butter-Frosting-51117350",
      "recipe_id": "09a215",
      "image_url": "http://forkify-api.herokuapp.com/images/51117350b449.jpg",
      "social_rank": 99.9999997017097,
      "publisher_url": "http://www.epicurious.com"
    },
    {
      "publisher": "All Recipes",
      "title": "Sweetheart Cupcakes",
      "source_url":
          "http://allrecipes.com/Recipe/Sweetheart-Cupcakes/Detail.aspx",
      "recipe_id": "31822",
      "image_url": "http://forkify-api.herokuapp.com/images/344753482e.jpg",
      "social_rank": 99.99999969780252,
      "publisher_url": "http://allrecipes.com"
    },
    {
      "publisher": "Epicurious",
      "title": "Glorious Red, White, and Blue Cake",
      "source_url":
          "http://www.epicurious.com/recipes/food/views/Glorious-Red-White-and-Blue-Cake-366289",
      "recipe_id": "3b6458",
      "image_url": "http://forkify-api.herokuapp.com/images/36628964e5.jpg",
      "social_rank": 99.99999945530882,
      "publisher_url": "http://www.epicurious.com"
    },
    {
      "publisher": "My Baking Addiction",
      "title": "My Favorite Chocolate Chip Cookies",
      "source_url":
          "http://www.mybakingaddiction.com/new-york-times-chocolate-chip-cookies-recipe/",
      "recipe_id": "701db5",
      "image_url":
          "http://forkify-api.herokuapp.com/images/NYCookies1of1b391.jpgedit.jpg",
      "social_rank": 99.9999991866989,
      "publisher_url": "http://www.mybakingaddiction.com"
    },
    {
      "publisher": "The Pioneer Woman",
      "title": "Silver Dollar Pumpkin Pancakes",
      "source_url":
          "http://thepioneerwoman.com/cooking/2012/10/silver-dollar-pumpkin-pancakes/",
      "recipe_id": "46888",
      "image_url":
          "http://forkify-api.herokuapp.com/images/pumpkinpancakes32a8.jpg",
      "social_rank": 99.99999876992015,
      "publisher_url": "http://thepioneerwoman.com"
    },
    {
      "publisher": "The Pioneer Woman",
      "title": "Dump Cake",
      "source_url":
          "http://thepioneerwoman.com/cooking/2008/04/dump-cake-a-potluckers-paradise/",
      "recipe_id": "47328",
      "image_url": "http://forkify-api.herokuapp.com/images/DumpCakeab83.jpg",
      "social_rank": 99.9999984616751,
      "publisher_url": "http://thepioneerwoman.com"
    },
    {
      "publisher": "The Pioneer Woman",
      "title": "Halloween Cake Balls",
      "source_url":
          "http://thepioneerwoman.com/cooking/2008/10/cake-balls-halloween-style/",
      "recipe_id": "47284",
      "image_url":
          "http://forkify-api.herokuapp.com/images/CakeBallsHalloweenStylef7a9.jpg",
      "social_rank": 99.99999817152062,
      "publisher_url": "http://thepioneerwoman.com"
    },
    {
      "publisher": "Simply Recipes",
      "title": "Chicken and Dumplings",
      "source_url":
          "http://www.simplyrecipes.com/recipes/chicken_and_dumplings/",
      "recipe_id": "35929",
      "image_url":
          "http://forkify-api.herokuapp.com/images/chickendumplingsa300x20099af82d6.jpg",
      "social_rank": 99.99999321389255,
      "publisher_url": "http://simplyrecipes.com"
    }
  ]
};
