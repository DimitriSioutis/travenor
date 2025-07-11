import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String id;
  final String name;
  final String location;
  final double rating;
  final String imageUrl;
  final String description;
  final int price;

  const Place({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.imageUrl,
    required this.description,
    required this.price,
  });

  @override
  List<Object> get props => [id, name, location, rating, imageUrl, description, price];
}
