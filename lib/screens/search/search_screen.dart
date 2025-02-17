import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screens/provider/restaurant_list_provider.dart';
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
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      context.read<RestaurantListProvider>().clearSearchResults();
    } else {
      context.read<RestaurantListProvider>().searchRestaurants(query);
    }
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
                  final query = _searchController.text.trim();

                  if (query.isEmpty) {
                    return const Center(
                      child: Text(
                        'Cari restoran...',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  if (state is RestaurantListLoadingState) {
                    return const LottieLoading();
                  }

                  if (state is RestaurantListErrorState) {
                    return ErrorScreen(
                      onRetry: () => provider.searchRestaurants(query),
                      errorMessage: state.message,
                    );
                  }

                  if (state is RestaurantListLoadedState) {
                    return provider.searchResults.isEmpty
                        ? const Center(
                            child: Text(
                              'Tidak ada restoran yang ditemukan.',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        : SearchList(searchResults: provider.searchResults);
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
