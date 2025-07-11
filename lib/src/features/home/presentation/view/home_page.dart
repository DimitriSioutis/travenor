import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor/src/constants/colors.dart';
import 'package:travenor/src/features/places/domain/models/place.dart';
import '../../../places/presentation/bloc/popular_places/popular_places_bloc.dart';
import '../../../places/presentation/bloc/popular_places/popular_places_state.dart';
import '../widgets/popular_places_horizontal_list_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 40),
            _buildListHeader(context),
            const SizedBox(height: 20),
            BlocBuilder<PopularPlacesBloc, PopularPlacesState>(
              builder: (context, state) {
                if (state is PopularPlacesLoading || state is PopularPlacesInitial) {
                  return const Center(child: CircularProgressIndicator(color: mainColor));
                }
                if (state is PopularPlacesLoaded) {
                  return _buildBestDestinationsList(state.places);
                }
                if (state is PopularPlacesError) {
                  return Center(child: Text(state.error));
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBestDestinationsList(List<Place> places) {
    return SizedBox(
      height: 384,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: 2,
        itemBuilder: (context, index) {
          final place = places[index];
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 20 : 10.0, right: index == 1 ? 20 : 10.0),
            child: PopularPlacesHorizontalListCard(
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

  Widget _buildListHeader(BuildContext context) {
    return Padding(
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
              Navigator.pushNamed(context, '/popular_places');
            },
            child: Text(
              'View All',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: secondaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
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
                color: secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
