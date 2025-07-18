import 'dart:convert';
import 'package:grpc/grpc.dart';
import 'package:travenor/src/generated/location.pb.dart';
import 'package:travenor/src/generated/weather.pb.dart';
import 'package:travenor/src/services/location_service.dart';
import '../../../../generated/service.pbgrpc.dart';
import '../../domain/models/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../models/weather_model.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  late WeatherServiceClient _client;
  late ClientChannel _channel;
  final LocationService _locationService;

  WeatherRepositoryImpl({required LocationService locationService}) : _locationService = locationService {
    try {
      _channel = ClientChannel(
        'weather-server-222005924287.europe-west9.run.app',
        port: 443,
        options: const ChannelOptions(credentials: ChannelCredentials.secure()),
      );
      _client = WeatherServiceClient(_channel, options: CallOptions());
    } catch (e) {
      throw Exception('Error creating connection :$e');
    }
  }

  @override
  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final request = RequestCurrent(
        locationType: LocationType.LOCATION_TYPE_COORDS,
        location: OneOfLocation(
          coords: Coordinates(latitude: latitude, longitude: longitude),
        ),
      );
      final response = await _client.current(request);
      final decodedData = jsonDecode(response.payload);
      final Weather weather = WeatherModel.fromGRPCAPI(decodedData).toDomain();
      return weather;
    } catch (e) {
      throw Exception('Error getting weather: $e');
    }
  }

  @override
  Future<Weather> getWeatherForCurrentLocation() async {
    try {
      final position = await _locationService.getCurrentPosition();
      return getWeather(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      throw Exception('An error occurred while getting weather for your location: $e');
    }
  }
}
