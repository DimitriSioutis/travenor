import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/color_scheme_extension.dart';
import '../../domain/models/weather.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => context.read<WeatherBloc>().add(WeatherRequested()),
          child: Container(
            width: 180,
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceBlock,
              borderRadius: BorderRadius.circular(22),
            ),

            child: buildWeatherContent(context, state),
          ),
        );
      },
    );
  }

  Widget buildWeatherContent(BuildContext context, WeatherState state) {
    if (state is WeatherError) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Text(
            'To see the weather, enable location services.',
            style: Theme.of(context).textTheme.labelLarge,
            maxLines: 2,
          ),
        ),
      );
    }
    if (state is WeatherLoading && state.weather == null) {
      return Center(
        child: SizedBox(
          height: 37,
          width: 37,
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.all(4.0),
          ),
        ),
      );
    }
    if (state is WeatherLoading) {
      Weather? weather = state.weather;

      return _buildWeatherContent(weather, context);
    }
    if (state is WeatherLoaded) {
      Weather weather = state.weather;
      return _buildWeatherContent(weather, context);
    }
    return SizedBox();
  }

  Row _buildWeatherContent(Weather? weather, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            '${weather?.getCelsiusTemperature().toStringAsFixed(0)}°',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${weather?.locationName}',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
                  ),
                ),
                Text(
                  '${weather?.description}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 18.5,
          child: Image.network(weather?.getIconUrl()),
        ),
      ],
    );
  }
}
