import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travenor/constants/constants.dart';

import '../../../data/repositories/places_repository.dart';
import '../../../logic/blocs/auth/auth_bloc.dart';
import '../../../logic/blocs/auth/auth_state.dart';
import '../../../logic/blocs/favorites/favorites_bloc.dart';
import '../../../logic/blocs/favorites/favorites_event.dart';
import '../../../logic/blocs/favorites/favorites_state.dart';
import '../../../logic/blocs/place_details/place_details_bloc.dart';
import '../../../logic/blocs/place_details/place_details_event.dart';
import '../../../logic/blocs/place_details/place_details_state.dart';

class PlaceScreen extends StatefulWidget {
  const PlaceScreen({super.key, required this.placeId});
  final String placeId;

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  double boxHeight = 70.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<PlaceDetailsBloc>(
        create: (context) => PlaceDetailsBloc(placesRepository: context.read<PlacesRepository>())..add(FetchPlaceDetails(widget.placeId)),
        child: BlocBuilder<PlaceDetailsBloc, PlaceDetailsState>(
          builder: (context, PlaceDetailsState state) {
            if (state is PlaceDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PlaceDetailsError) {
              return Text(state.error);
            }
            if (state is PlaceDetailsLoaded) {
              final place = state.place;
              return Stack(
                children: [
                  Container(
                    height: (MediaQuery.of(context).size.height / 2),
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(place.imageUrl), fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 20 + MediaQuery.of(context).padding.top, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                color: blackText.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset('assets/icons/back.svg'),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Details',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          BlocBuilder<FavoritesBloc, FavoritesState>(
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
                                  height: 44,
                                  width: 44,
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
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.55,
                      minChildSize: 0.55,
                      maxChildSize: 0.8,
                      snap: true,
                      builder: (BuildContext context, ScrollController scrollController) {
                        return Container(
                          height: (MediaQuery.of(context).size.height / 2) + boxHeight,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.elliptical(200, 30),
                              topRight: Radius.elliptical(200, 30),
                            ),
                          ),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/swipe.svg',
                                      height: 6,
                                      width: 35,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    place.name,
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: blackText),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    place.location,
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: grey),
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
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
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Color(0xffFFD336), size: 15),
                                          Text(
                                            '${place.rating}',
                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: blackText),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: '\$${place.price}',
                                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: mainColor),
                                              children: [
                                                TextSpan(
                                                  text: '/Person',
                                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    'About Destination',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: blackText),
                                  ),
                                  const SizedBox(height: 12),
                                  RichText(
                                    // maxLines: 4,
                                    // overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: place.description,
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: grey, height: 2),
                                      children: [
                                        TextSpan(
                                          text: 'Read More',
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: forgetPasswordColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: MediaQuery.of(context).padding.bottom + 10),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          height: 56,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Book Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
