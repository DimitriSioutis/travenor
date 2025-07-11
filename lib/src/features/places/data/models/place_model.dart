import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/place.dart';

class PlaceModel {
  final String id;
  final String name;
  final String location;
  final double rating;
  final String imageUrl;
  final String description;
  final int price;

  const PlaceModel({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.imageUrl,
    required this.description,
    required this.price,
  });

  factory PlaceModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PlaceModel(
      id: doc.id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] as num?)?.toInt() ?? 0,
    );
  }

  Place toDomain() {
    return Place(
      id: id,
      name: name,
      location: location,
      rating: rating,
      imageUrl: imageUrl,
      description: description,
      price: price,
    );
  }
}
