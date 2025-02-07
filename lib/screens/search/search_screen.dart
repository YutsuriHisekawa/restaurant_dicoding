import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/screens/error/error_screen.dart';
import 'package:restaurant_app/screens/search/search_field.dart';
import 'package:restaurant_app/screens/search/serach_list.dart';
import 'package:restaurant_app/widgets/lottie/lottie_loading.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    context.read<RestaurantListProvider>().searchRestaurants(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchField(controller: _searchController),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<RestaurantListProvider>(
                builder: (context, provider, child) {
                  final state = provider.resultState;

                  if (_searchController.text.isEmpty) {
                    return const Center(
                      child: Text(
                        'Search for a restaurant...',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  if (state is RestaurantListLoadingState) {
                    return const LottieLoading();
                  }

                  if (state is RestaurantListErrorState) {
                    return ErrorScreen(
                      onRetry: provider.fetchRestaurantList,
                    );
                  }

                  if (state is RestaurantListLoadedState) {
                    if (provider.searchResults.isEmpty) {
                      return const Center(
                        child: Text(
                          'No restaurants found.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    }
                    return SearchList(searchResults: provider.searchResults);
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
