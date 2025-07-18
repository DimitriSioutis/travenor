import 'package:equatable/equatable.dart';
import '../../domain/models/weather.dart';

class WeatherModel extends Equatable {
  final String locationName;
  final String description;
  final String iconCode;
  final double temperature;

  const WeatherModel({
    required this.locationName,
    required this.description,
    required this.iconCode,
    required this.temperature,
  });

  @override
  List<Object?> get props => [locationName, description, iconCode, temperature];
  factory WeatherModel.fromGRPCAPI(Map<String, dynamic> data) {
    return WeatherModel(
      locationName: data['name'] ?? 'Unknown',
      description: data['weather'][0]['description'] ?? '',
      iconCode: data['weather'][0]['icon'] ?? '',
      temperature: (data['main']['temp'] ?? 0.0).toDouble(),
    );
  }
  Weather toDomain() {
    return Weather(
      locationName: locationName,
      description: description,
      iconCode: iconCode,
      temperature: temperature,
    );
  }
}
