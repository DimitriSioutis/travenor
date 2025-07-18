import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String locationName;
  final String description;
  final String _iconCode;
  final double _temperature;

  const Weather({
    required this.locationName,
    required this.description,
    required iconCode,
    required temperature,
  }) : _temperature = temperature,
       _iconCode = iconCode;

  getCelsiusTemperature() {
    return _temperature - 273.15;
  }

  getIconUrl() => 'https://openweathermap.org/img/wn/$_iconCode@2x.png';

  @override
  List<Object?> get props => [locationName, description, _iconCode, _temperature];
}
