import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';
import '../../../../constants/colors.dart';
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
          color: Colors.white,
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
              _buildHeader(),
              const SizedBox(height: 24),
              _buildStatsRow(),
              if (place.images.isNotEmpty) _buildImagesRow(context),
              const SizedBox(height: 24),
              _buildDescription(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          place.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: blackText),
        ),
        const SizedBox(height: 4),
        Text(
          place.location,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: grey),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
        Row(
          children: [
            Icon(Icons.star, color: Color(0xffFFD336), size: 15),
            Text(
              '${place.rating}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: blackText),
            ),
          ],
        ),
        RichText(
          text: TextSpan(
            text: '\$${place.price}',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: mainColor),
            children: [
              TextSpan(
                text: '/Person',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: grey),
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
            child: (index == 4 && place.images.length > 5) ? _buildImagePreviewWithCount() : _buildImagePreview(index),
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

  Widget _buildImagePreviewWithCount() {
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
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Destination',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: blackText),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: SingleChildScrollView(
            child: ReadMoreText(
              place.description,
              trimMode: TrimMode.Line,
              trimLines: 1,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              colorClickableText: secondaryColor,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: grey, height: 2),
              moreStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: secondaryColor),
              // colorClickableText: secondaryColor,
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
