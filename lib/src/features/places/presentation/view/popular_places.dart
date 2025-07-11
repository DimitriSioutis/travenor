import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../constants/colors.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth/auth_state.dart';
import '../../../favorites/presentation/bloc/favorites/favorites_bloc.dart';
import '../../../favorites/presentation/bloc/favorites/favorites_event.dart';
import '../../../favorites/presentation/bloc/favorites/favorites_state.dart';
import '../../domain/models/place.dart';
import '../bloc/popular_places/popular_places_bloc.dart';
import '../bloc/popular_places/popular_places_state.dart';

class PopularPlaces extends StatelessWidget {
  const PopularPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20 + MediaQuery.of(context).padding.top, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: grey.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          'assets/icons/back.svg',
                          color: blackText,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Popular Places',
                  style: TextStyle(color: blackText, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              'All Popular Places',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: blackText),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<PopularPlacesBloc, PopularPlacesState>(
                builder: (context, state) {
                  if (state is PopularPlacesLoading || state is PopularPlacesInitial) {
                    return const Center(child: CircularProgressIndicator(color: mainColor));
                  }
                  if (state is PopularPlacesLoaded) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 161 / 238, crossAxisSpacing: 14, mainAxisSpacing: 14),
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.zero,
                      itemCount: state.places.length,
                      itemBuilder: (context, index) {
                        final place = state.places[index];
                        return PopularPlacesGridCard(
                          place: place,
                          onTap: () {
                            Navigator.pushNamed(context, '/place_details', arguments: place.id);
                          },
                        );
                      },
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopularPlacesGridCard extends StatelessWidget {
  const PopularPlacesGridCard({super.key, required this.place, required this.onTap});

  final Place place;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
              child: Stack(
                children: [
                  Container(
                    height: 124,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
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
                      padding: const EdgeInsets.all(10.0),
                      child: BlocBuilder<FavoritesBloc, FavoritesState>(
                        builder: (context, favoritesState) {
                          bool isFavorite = false;
                          if (favoritesState is FavoritesLoaded) {
                            isFavorite = favoritesState.favoritePlaces.contains(place.id);
                          }

                          final authState = context.read<AuthBloc>().state;
                          final userId = (authState is Authenticated) ? authState.user.uid : null;
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
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                color: blackText.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.white,
                                  size: 14,
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: blackText, overflow: TextOverflow.ellipsis),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/location.svg'),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            place.location,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: grey, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Color(0xffFFD336), size: 12),
                        Icon(Icons.star, color: Color(0xffFFD336), size: 12),
                        Icon(Icons.star, color: Color(0xffFFD336), size: 12),
                        const SizedBox(width: 4),
                        Text(
                          '${place.rating}',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: blackText),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '\$${place.price}',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: mainColor),
                            children: [
                              TextSpan(
                                text: '/Person',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: grey),
                              ),
                            ],
                          ),
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
