import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/constants.dart';
import '../../../data/models/place.dart';
import '../../../data/repositories/places_repository.dart';
import '../../../logic/blocs/search_places/search_places_bloc.dart';
import '../../../logic/blocs/search_places/search_places_event.dart';
import '../../../logic/blocs/search_places/search_places_state.dart';

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
                  getSearchPlacesList(state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getSearchPlacesList(SearchPlacesState state) {
    if (state is SearchPlacesLoaded) {
      return Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 161 / 216, crossAxisSpacing: 14, mainAxisSpacing: 14),
          clipBehavior: Clip.none,
          padding: EdgeInsets.zero,
          itemCount: state.places.length,
          itemBuilder: (context, index) {
            final place = state.places[index];
            return SearchPlacesGridCard(
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
      return Center(child: CircularProgressIndicator());
    }
    return SizedBox();
  }
}

class SearchPlacesGridCard extends StatelessWidget {
  const SearchPlacesGridCard({super.key, required this.place, required this.onTap});

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
              child: Container(
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
