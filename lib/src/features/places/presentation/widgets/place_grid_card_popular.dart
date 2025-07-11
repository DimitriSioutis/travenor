import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/colors.dart';
import '../../../favorites/presentation/widgets/favorite_icon_button.dart';
import '../../domain/models/place.dart';

class PlaceGridCardPopular extends StatelessWidget {
  const PlaceGridCardPopular({super.key, required this.place, required this.onTap});

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
              child: Stack(
                children: [
                  Container(
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
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FavoriteIconButton(
                        place: place,
                        iconSize: 14,
                        favoriteIcon: Icons.favorite,
                        unfavoriteIcon: Icons.favorite_border,
                        size: 24,
                      ),
                    ),
                  ),
                ],
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
                        Icon(Icons.star, color: Color(0xffFFD336), size: 12),
                        Icon(Icons.star, color: Color(0xffFFD336), size: 12),
                        Icon(Icons.star, color: Color(0xffFFD336), size: 12),
                        const SizedBox(width: 4),
                        Text(
                          '${place.rating}',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: blackText),
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
