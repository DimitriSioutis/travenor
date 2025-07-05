import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travenor/constants/constants.dart';
import 'package:travenor/data/models/place.dart';
import 'package:travenor/data/repositories/places_repository.dart';
import 'package:travenor/logic/blocs/popular_places/popular_places_bloc.dart';

import '../../../logic/blocs/auth/auth_bloc.dart';
import '../../../logic/blocs/auth/auth_state.dart';
import '../../../logic/blocs/favorites/favorites_bloc.dart';
import '../../../logic/blocs/favorites/favorites_event.dart';
import '../../../logic/blocs/favorites/favorites_state.dart';
import '../../../logic/blocs/popular_places/popular_places_event.dart';
import '../../../logic/blocs/popular_places/popular_places_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularPlacesBloc(placesRepository: context.read<PlacesRepository>())..add(FetchPopularPlaces()),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Explore the',
                        style: TextStyle(
                          fontSize: 38,
                          color: blackText,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: '\nBeautiful',
                        style: TextStyle(
                          fontSize: 38,
                          color: blackText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ' world!',
                        style: TextStyle(
                          fontSize: 38,
                          color: forgetPasswordColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Best Destination',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: blackText),
                    ),
                    InkWell(
                      onTap: () {
                        // TODO navigate to all popular destinations page
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: forgetPasswordColor),
                      ),
                    ),
                    // ListView.builder(itemBuilder: );
                  ],
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<PopularPlacesBloc, PopularPlacesState>(
                builder: (context, state) {
                  if (state is PopularPlacesLoading || state is PopularPlacesInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is PopularPlacesLoaded) {
                    return SizedBox(
                      height: 384,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        itemCount: state.places.length,
                        itemBuilder: (context, index) {
                          final place = state.places[index];
                          return Padding(
                            padding: EdgeInsets.only(left: index == 0 ? 20 : 10.0, right: index == (state.places.length - 1) ? 20 : 10.0),
                            child: PopularPlacesHomeCard(
                              place: place,
                              onTap: () {
                                Navigator.pushNamed(context, '/place_details', arguments: place.id);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                  if (state is PopularPlacesError) {
                    return Text(state.error);
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
            const SizedBox(height: 14),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0, 14.0, 14.0),
                child: Column(
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
                    const SizedBox(height: 8),
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
