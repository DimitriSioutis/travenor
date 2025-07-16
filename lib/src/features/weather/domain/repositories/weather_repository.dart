import 'package:travenor/src/features/weather/domain/models/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather({required double latitude, required double longitude});
}
