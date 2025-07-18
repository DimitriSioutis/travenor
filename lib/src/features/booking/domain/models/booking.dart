import 'package:equatable/equatable.dart';

import '../../../places/domain/models/place.dart';

class Booking extends Equatable {
  final DateTime bookedAt;
  final Place place;

  const Booking({
    required this.bookedAt,
    required this.place,
  });

  @override
  List<Object?> get props => [bookedAt, place];
}
