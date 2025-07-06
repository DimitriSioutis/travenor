import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travenor/data/models/place.dart';
import '../../../../../logic/blocs/auth/auth_bloc.dart';
import '../../../../../logic/blocs/auth/auth_state.dart';
import '../../../../../logic/blocs/favorites/favorites_bloc.dart';
import '../../../../../logic/blocs/favorites/favorites_event.dart';
import '../../../../../logic/blocs/favorites/favorites_state.dart';
import '../../../../../constants/constants.dart';

class PopularPlacesHomeCard extends StatelessWidget {
  const PopularPlacesHomeCard({super.key, required this.place, required this.onTap});

  final Place place;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: 384,
        width: 268,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 16,
              spreadRadius: 0,
              color: Color(0xFFB4BCC9).withValues(alpha: 0.12),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 0),
              child: Stack(
                children: [
                  Container(
                    height: 286,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(place.imageUrl),
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: BlocBuilder<FavoritesBloc, FavoritesState>(
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
                              height: 34,
                              width: 34,
                              decoration: BoxDecoration(
                                color: blackText.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset(isFavorite ? 'assets/icons/bookmark_filled.svg' : 'assets/icons/bookmark.svg'),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            place.name,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: blackText, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Row(
                          children: [
                            Icon(Icons.star, color: Color(0xffFFD336), size: 15),
                            Text(
                              '${place.rating}',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: blackText),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/location.svg'),
                        const SizedBox(width: 4),
                        Text(
                          place.location,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
