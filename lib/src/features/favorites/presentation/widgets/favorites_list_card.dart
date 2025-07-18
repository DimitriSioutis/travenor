import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../extensions/color_scheme_extension.dart';
import '../../../places/domain/models/place.dart';
import 'favorite_icon_button.dart';

class FavoritesListCard extends StatelessWidget {
  const FavoritesListCard({super.key, required this.place, required this.onTap});
  final Place place;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      onTap: () => onTap(),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 16,
              spreadRadius: 0,
              color: Theme.of(context).colorScheme.shadow,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Container(
                  width: 80,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        _buildStarRating(context),
                        Text(
                          '${place.rating}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/location.svg'),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            place.location,
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FavoriteIconButton(
                place: place,
                size: 40,
                iconSize: 25,
                unfavoriteIcon: Icons.favorite_border,
                favoriteIcon: Icons.favorite,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildStarRating(BuildContext context) {
    return Row(children: [for (int i = 0; i < place.rating.floor(); i++) Icon(Icons.star, color: Color(0xffFFD336), size: 15)]);
  }
}
