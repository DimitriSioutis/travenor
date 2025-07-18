import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common_widgets/travenor_back_button.dart';
import '../../../places/domain/models/place.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_state.dart';
import '../widgets/favorites_list.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20 + MediaQuery.of(context).padding.top, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TravenorBackButton(),
                    Text(
                      'Favorite Places',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(width: 44),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                return _buildFavoritesList(state, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(FavoritesState state, BuildContext context) {
    if (state is FavoritesLoading) Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
    if (state is FavoritesLoaded) {
      final List<Place> favoritePlaces = state.favoritePlaces.toList();
      if (favoritePlaces.isEmpty) {
        return Center(
          child: Text(
            'Add places to your favorites\n to see them here',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        );
      }
      return FavoritesList(places: favoritePlaces);
    }
    return Center(child: Text('Something went wrong', style: Theme.of(context).textTheme.titleLarge));
  }
}
