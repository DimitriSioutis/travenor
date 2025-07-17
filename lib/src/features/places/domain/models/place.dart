import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String id;
  final String name;
  final String location;
  final double rating;
  final String imageUrl;
  final String description;
  final int price;
  final List<String> images;

  const Place({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'rating': rating,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'images': images,
    };
  }

  @override
  List<Object> get props => [id, name, location, rating, imageUrl, description, price, images];
}
