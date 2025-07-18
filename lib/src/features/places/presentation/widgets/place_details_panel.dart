import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';
import 'package:travenor/src/extensions/color_scheme_extension.dart';
import '../../domain/models/place.dart';
import 'images_gallery_dialog.dart';

class PlaceDetailsPanel extends StatelessWidget {
  const PlaceDetailsPanel({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: (MediaQuery.of(context).size.height / 2) + 70,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(200, 30),
            topRight: Radius.elliptical(200, 30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: SvgPicture.asset(
                  'assets/icons/swipe.svg',
                  height: 6,
                  width: 35,
                ),
              ),
              const SizedBox(height: 20),
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildStatsRow(context),
              if (place.images.isNotEmpty) _buildImagesRow(context),
              const SizedBox(height: 24),
              _buildDescription(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          place.name,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 4),
        Text(
          place.location,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/icons/location.svg'),
            const SizedBox(width: 4),
            Text(
              place.location,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.star, color: Color(0xffFFD336), size: 15),
            Text(
              '${place.rating}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        RichText(
          text: TextSpan(
            text: '\$${place.price}',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
            children: [
              TextSpan(
                text: '/Person',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImagesRow(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        _buildImagesRowWidget(context),
      ],
    );
  }

  Widget _buildImagesRowWidget(BuildContext context) {
    final int imagesPreviewCount = place.images.length > 5 ? 5 : place.images.length;

    return Row(
      children: List.generate(imagesPreviewCount, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 26.0),
          child: GestureDetector(
            onTap: () => _showImageGalleryDialog(context, place.images, index),
            child: (index == 4 && place.images.length > 5) ? _buildImagePreviewWithCount(context) : _buildImagePreview(index),
          ),
        );
      }),
    );
  }

  Widget _buildImagePreview(int index) {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        image: DecorationImage(
          image: NetworkImage(place.images[index]),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildImagePreviewWithCount(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildImagePreview(4),
        Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.2),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Center(
            child: Text(
              '+${place.images.length - 5}',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About Destination', style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: SingleChildScrollView(
            child: ReadMoreText(
              place.description,
              trimMode: TrimMode.Line,
              trimLines: 1,
              trimCollapsedText: 'Read more',
              trimExpandedText: 'Read less',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                height: 1.7,
                color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
              ),
              moreStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
              lessStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _showImageGalleryDialog(BuildContext context, List<String> images, int initialIndex) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Image Gallery',
      barrierColor: Colors.black.withValues(alpha: 0.8),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return ImageGalleryDialog(
          images: images,
          initialIndex: initialIndex,
        );
      },
    );
  }
}
