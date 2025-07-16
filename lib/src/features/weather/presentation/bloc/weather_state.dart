import 'package:equatable/equatable.dart';
import 'package:travenor/src/features/weather/domain/models/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {
  final Weather? weather;
  const WeatherLoading(this.weather);
  @override
  List<Object> get props => [?weather];
}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  const WeatherLoaded(this.weather);
  @override
  List<Object> get props => [weather];
}

class WeatherError extends WeatherState {
  final String errorMessage;
  const WeatherError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
