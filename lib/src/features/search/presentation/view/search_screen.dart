import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travenor/src/extensions/color_scheme_extension.dart';
import '../../../../common_widgets/travenor_back_button.dart';
import '../../../places/domain/repositories/places_repository.dart';
import '../bloc/search_places/search_places_bloc.dart';
import '../bloc/search_places/search_places_event.dart';
import '../bloc/search_places/search_places_state.dart';
import '../widgets/place_grid_card_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchPlacesBloc>(
      create: (BuildContext context) => SearchPlacesBloc(placesRepository: context.read<PlacesRepository>())..add(SearchPlacesRequested('')),
      child: Scaffold(
        body: BlocBuilder<SearchPlacesBloc, SearchPlacesState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 20 + MediaQuery.of(context).padding.top, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(context),
                  SizedBox(height: 20),
                  _buildSearchTextField(context),
                  SizedBox(height: 20),
                  Text(
                    'All Popular Places',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(height: 20),
                  _buildSearchPlacesList(state, context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  TextFormField _buildSearchTextField(BuildContext context) {
    return TextFormField(
      controller: _searchController,
      onChanged: (value) {
        context.read<SearchPlacesBloc>().add(SearchPlacesRequested(value));
      },
      keyboardType: TextInputType.text,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            'assets/icons/search.svg',
            color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide.none,
        ),
        hintText: 'Search Places',
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
        ),

        fillColor: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceBlock,
        filled: true,
      ),
    );
  }

  Row _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TravenorBackButton(),
        Text(
          'Search',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        InkWell(
          onTap: () {
            _searchController.clear();
            context.read<SearchPlacesBloc>().add(SearchPlacesRequested(''));
          },
          child: Text(
            'Cancel',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchPlacesList(SearchPlacesState state, BuildContext context) {
    if (state is SearchPlacesLoaded) {
      return Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 161 / 216, crossAxisSpacing: 14, mainAxisSpacing: 14),
          clipBehavior: Clip.none,
          padding: EdgeInsets.zero,
          itemCount: state.places.length,
          itemBuilder: (context, index) {
            final place = state.places[index];
            return PlaceGridCardSearch(
              place: place,
              onTap: () {
                Navigator.pushNamed(context, '/place_details', arguments: place.id);
              },
            );
          },
        ),
      );
    }
    if (state is SearchPlacesLoading) {
      return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
    }
    return SizedBox();
  }
}
