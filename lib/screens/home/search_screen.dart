import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/screens/home/widgets/restaurant_search_card_widget.dart';
import '../../provider/response_state.dart';
import '../../provider/restaurant_search_provaider.dart';
import '../../routes/routes.dart';

class SearchScreen extends StatefulWidget {
  final String query;

  const SearchScreen({
    super.key,
    required this.query,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchText = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchText = TextEditingController(text: widget.query);
  }

  @override
  void dispose() {
    super.dispose();
    _searchText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (context) => RestaurantSearchProvider(widget.query),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Consumer<RestaurantSearchProvider>(
              builder: (context, restaurantSearchProvider, _) {
                return TextField(
                  controller: _searchText,
                  decoration: const InputDecoration(
                    hintText: 'Find for Food or Restaurant...',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  cursorColor: Colors.black,
                  onChanged: (value) {
                    restaurantSearchProvider.queryValue = value;
                  },
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: _getSearchData()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Consumer<RestaurantSearchProvider> _getSearchData() {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, restaurantSearchProvider, _) {
        if (restaurantSearchProvider.state == ResponseState.loading) {
          return const Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ));
        } else if (restaurantSearchProvider.state == ResponseState.error) {
          return NotFoundDataWidget(
            message: restaurantSearchProvider.message.toString(),
          );
        } else if (restaurantSearchProvider.state == ResponseState.noData) {
          return NotFoundDataWidget(
            message: restaurantSearchProvider.message.toString(),
          );
        } else if (restaurantSearchProvider.state == ResponseState.hasData) {
          var restaurants =
              restaurantSearchProvider.restaurantList!.restaurants;

          return ListView.builder(
            itemCount: restaurants.length,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    _,
                    Routes.restaurantDetailScreen,
                    arguments: restaurants[index].id,
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: RestaurantSearchCardWidget(
                  name: restaurants[index].name,
                  pictureId: restaurants[index].photo,
                  city: restaurants[index].city,
                  // rating: restaurants[index].rating,
                ),
              );
            },
          );
        } else {
          return NotFoundDataWidget(
            message: restaurantSearchProvider.message.toString(),
          );
        }
      },
    );
  }
}

class NotFoundDataWidget extends StatelessWidget {
  final String message;

  const NotFoundDataWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: size.height / 8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/notfound.png',
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              message != '' ? message : 'Empty Data',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
