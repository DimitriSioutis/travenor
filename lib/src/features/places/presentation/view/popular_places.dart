import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common_widgets/travenor_back_button.dart';
import '../bloc/popular_places/popular_places_bloc.dart';
import '../bloc/popular_places/popular_places_state.dart';
import '../widgets/place_grid_card_popular.dart';

class PopularPlacesScreen extends StatelessWidget {
  const PopularPlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20 + MediaQuery.of(context).padding.top, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TravenorBackButton(),
                Text(
                  'Popular Places',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(width: 44),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              'All Popular Places',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<PopularPlacesBloc, PopularPlacesState>(
                builder: (context, state) {
                  if (state is PopularPlacesLoading || state is PopularPlacesInitial) {
                    return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
                  }
                  if (state is PopularPlacesLoaded) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 161 / 238, crossAxisSpacing: 14, mainAxisSpacing: 14),
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.zero,
                      itemCount: state.places.length,
                      itemBuilder: (context, index) {
                        final place = state.places[index];
                        return PlaceGridCardPopular(
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
