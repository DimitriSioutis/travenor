import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travenor/src/features/places/domain/models/place.dart';
import '../../../../constants/colors.dart';
import '../../../favorites/presentation/widgets/favorite_icon_button.dart';

class PopularPlacesHorizontalListCard extends StatelessWidget {
  const PopularPlacesHorizontalListCard({super.key, required this.place, required this.onTap});

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
                      child: FavoriteIconButton(
                        place: place,
                        size: 34,
                        iconSize: 20,
                        favoriteIcon: Icons.bookmark,
                        unfavoriteIcon: Icons.bookmark_border,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
