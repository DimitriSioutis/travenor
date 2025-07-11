import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../common_widgets/travenor_back_button.dart';
import '../../../../constants/colors.dart';
import '../../../places/domain/models/place.dart';
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
      lazy: false,
      child: Scaffold(
        backgroundColor: bgColor,
        body: BlocBuilder<SearchPlacesBloc, SearchPlacesState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 20 + MediaQuery.of(context).padding.top, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TravenorBackButton(),
                      Text(
                        'Search',
                        style: TextStyle(color: blackText, fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          _searchController.clear();
                          context.read<SearchPlacesBloc>().add(SearchPlacesRequested(''));
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: secondaryColor, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _searchController,
                    onChanged: (value) {
                      context.read<SearchPlacesBloc>().add(SearchPlacesRequested(value));
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/icons/search.svg',
                          color: grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Search Places',
                      hintStyle: const TextStyle(color: grey),

                      fillColor: lightGrey,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'All Popular Places',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: blackText),
                  ),
                  SizedBox(height: 20),
                  _buildSearchPlacesList(state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchPlacesList(SearchPlacesState state) {
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
      return Center(child: CircularProgressIndicator(color: mainColor));
    }
    return SizedBox();
  }
}
