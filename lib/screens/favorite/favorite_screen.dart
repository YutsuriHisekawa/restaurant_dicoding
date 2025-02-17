import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screens/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/screens/error/error_screen.dart';
import 'package:restaurant_app/screens/favorite/body_empty.dart';
import 'package:restaurant_app/screens/favorite/body_favorite.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<LocalDatabaseProvider>().loadAllRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, provider, child) {
          final favoriteList = provider.favoriteList;
          if (favoriteList.isEmpty) {
            return const BodyEmpty();
          }
          final errorMessage = provider.message;
          if (errorMessage.isNotEmpty && favoriteList.isEmpty) {
            return ErrorScreen(
              errorMessage: errorMessage,
              onRetry: () =>
                  context.read<LocalDatabaseProvider>().loadAllRestaurants(),
            );
          }

          return BodyFavorite(favoriteList: favoriteList);
        },
      ),
    );
  }
}
