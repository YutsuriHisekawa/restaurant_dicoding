import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/widgets/lottie/lottie_loading.dart';
import 'home_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantListProvider>(
        builder: (context, provider, child) {
          final state = provider.resultState;

          if (state is RestaurantListLoadingState) {
            return const LottieLoading();
          } else if (state is RestaurantListErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      provider.fetchRestaurantList();
                    },
                    child: const Text("Coba Lagi"),
                  ),
                ],
              ),
            );
          } else if (state is RestaurantListLoadedState) {
            final restaurants = state.restaurants;
            if (restaurants.isEmpty) {
              return const Center(child: Text('No restaurants available.'));
            }
            return HomeList(restaurants: restaurants);
          }
          return const Center(child: Text('Loading... Please wait.'));
        },
      ),
    );
  }
}
