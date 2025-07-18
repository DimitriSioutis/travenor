import 'package:flutter/material.dart';
import '../../../places/domain/models/place.dart';
import 'favorites_list_card.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({super.key, required this.places});
  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0 + MediaQuery.of(context).padding.bottom),
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places.elementAt(index);
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: FavoritesListCard(
            place: place,
            onTap: () {
              Navigator.pushNamed(context, '/place_details', arguments: place.id);
            },
          ),
        );
      },
    );
  }
}
