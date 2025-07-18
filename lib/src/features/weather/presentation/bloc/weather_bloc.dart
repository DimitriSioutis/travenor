import 'package:bloc/bloc.dart';
import '../../domain/models/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;
  Weather? _weather;

  WeatherBloc({required WeatherRepository weatherRepository}) : _weatherRepository = weatherRepository, super(WeatherInitial()) {
    on<WeatherRequested>((event, emit) async {
      emit(WeatherLoading(_weather));
      try {
        _weather = await _weatherRepository.getWeatherForCurrentLocation();
        emit(WeatherLoaded(_weather!));
      } catch (e) {
        emit(WeatherError(e.toString()));
      }
    });
  }
}
