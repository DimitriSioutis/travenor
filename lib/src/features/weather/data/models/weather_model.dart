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
  factory WeatherModel.fromGRPCAPI(Map<String, dynamic> rowWeather) {
    return WeatherModel(
      locationName: rowWeather['name'] ?? 'Unknown',
      description: rowWeather['weather'][0]['description'] ?? '',
      iconCode: rowWeather['weather'][0]['icon'] ?? '',
      temperature: (rowWeather['main']['temp'] ?? 0.0).toDouble(),
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
