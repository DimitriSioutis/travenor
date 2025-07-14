import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor/src/common_widgets/general_button.dart';
import '../../../../common_widgets/travenor_back_button.dart';
import '../../../favorites/presentation/widgets/favorite_icon_button.dart';
import '../../domain/repositories/places_repository.dart';
import '../bloc/place_details/place_details_bloc.dart';
import '../bloc/place_details/place_details_event.dart';
import '../bloc/place_details/place_details_state.dart';
import 'package:travenor/src/features/places/domain/models/place.dart';

import '../widgets/place_details_panel.dart';

class PlaceScreen extends StatefulWidget {
  const PlaceScreen({super.key, required this.placeId});
  final String placeId;

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<PlaceDetailsBloc>(
        create: (context) => PlaceDetailsBloc(placesRepository: context.read<PlacesRepository>())..add(FetchPlaceDetails(widget.placeId)),
        child: BlocBuilder<PlaceDetailsBloc, PlaceDetailsState>(
          builder: (context, PlaceDetailsState state) {
            if (state is PlaceDetailsLoading) {
              return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
            }
            if (state is PlaceDetailsError) {
              return Text(state.error);
            }
            if (state is PlaceDetailsLoaded) {
              final place = state.place;
              return Stack(
                children: [
                  _buildBackgroundImage(context, place),
                  _buildTopBar(context, place),
                  PlaceDetailsPanel(place: place),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: MediaQuery.of(context).padding.bottom + 10),
                      child: GeneralButton(onTap: () {}, buttonText: 'Book Now'),
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

  Align _buildTopBar(BuildContext context, Place place) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 20 + MediaQuery.of(context).padding.top, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TravenorBackButton(iconColor: Colors.white),
            Text(
              'Details',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white),
            ),
            FavoriteIconButton(
              place: place,
              size: 44,
              iconSize: 24,
              favoriteIcon: Icons.bookmark,
              unfavoriteIcon: Icons.bookmark_border,
            ),
          ],
        ),
      ),
    );
  }

  Container _buildBackgroundImage(BuildContext context, Place place) {
    return Container(
      height: (MediaQuery.of(context).size.height / 2),
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(place.imageUrl), fit: BoxFit.cover),
      ),
    );
  }
}
