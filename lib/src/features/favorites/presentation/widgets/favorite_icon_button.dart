import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/colors.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth/auth_state.dart';
import '../../../places/domain/models/place.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';
import '../bloc/favorites/favorites_state.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    super.key,
    required this.place,
    this.size = 24,
    this.iconSize = 14,
    this.favoriteIcon = Icons.bookmark,
    this.unfavoriteIcon = Icons.bookmark_border,
  });

  final Place place;
  final double size;
  final double iconSize;
  final IconData favoriteIcon;
  final IconData unfavoriteIcon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, favoritesState) {
        final authState = context.read<AuthBloc>().state;
        final userId = (authState is Authenticated) ? authState.user.uid : null;
        bool isFavorite = false;

        if (favoritesState is FavoritesLoaded) {
          isFavorite = favoritesState.favoritePlaces.contains(place.id);
        }

        return InkWell(
          onTap: () {
            if (userId == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please log in to add favorites')),
              );
              return;
            }
            if (isFavorite) {
              context.read<FavoritesBloc>().add(
                RemoveFavorite(userId: userId, placeId: place.id),
              );
            } else {
              context.read<FavoritesBloc>().add(
                AddFavorite(userId: userId, placeId: place.id),
              );
            }
          },
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: grey.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(size / 2),
            ),
            child: Center(
              child: Icon(
                isFavorite ? favoriteIcon : unfavoriteIcon,
                color: Colors.white,
                size: iconSize,
              ),
            ),
          ),
        );
      },
    );
  }
}
