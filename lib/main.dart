import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor/src/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:travenor/src/features/booking/domain/repositories/booking_repository.dart';
import 'package:travenor/src/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:travenor/src/features/onboarding/data/repositories/remote_config_repository_impl.dart';
import 'package:travenor/src/features/places/data/repositories/places_repository_impl.dart';
import 'package:travenor/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:travenor/src/features/places/domain/repositories/places_repository.dart';
import 'package:travenor/src/services/notification_service.dart';
import 'src/features/booking/data/repositories/booking_repository_impl.dart';
import 'src/features/booking/presentation/bloc/booking_bloc.dart';
import 'src/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'src/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'firebase_options.dart';
import 'src/features/favorites/presentation/bloc/favorites/favorites_bloc.dart';
import 'src/features/onboarding/domain/repositories/remote_config_repository.dart';
import 'src/features/places/presentation/bloc/popular_places/popular_places_bloc.dart';
import 'src/features/places/presentation/bloc/popular_places/popular_places_event.dart';
import 'src/features/profile/data/repositories/settings_repository_impl.dart';
import 'src/features/profile/domain/repositories/settings_repository.dart';
import 'src/features/profile/presentation/bloc/theme/theme_bloc.dart';
import 'src/features/profile/presentation/bloc/theme/theme_state.dart';
import 'src/features/weather/data/repositories/weather_repository_impl.dart';
import 'src/features/weather/domain/repositories/weather_repository.dart';
import 'src/features/weather/presentation/bloc/weather_bloc.dart';
import 'src/features/weather/presentation/bloc/weather_event.dart';
import 'src/utils/app_bloc_observer.dart';
import 'src/routing/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/features/auth/domain/repositories/auth_repository.dart';
import 'src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'src/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final settingsRepository = SettingsRepositoryImpl();
  final initialThemeMode = await settingsRepository.loadThemeMode();
  final notificationService = NotificationService();
  await notificationService.init();
  runApp(
    MyApp(
      appRouter: AppRouter(),
      notificationService: notificationService,
      settingsRepository: settingsRepository,
      initialThemeMode: initialThemeMode,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.appRouter,
    required this.notificationService,
    required this.settingsRepository,
    required this.initialThemeMode,
  });
  final AppRouter appRouter;
  final NotificationService notificationService;
  final SettingsRepository settingsRepository;
  final ThemeMode initialThemeMode;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) => AuthRepositoryImpl()),
        RepositoryProvider<PlacesRepository>(create: (context) => PlacesRepositoryImpl()),
        RepositoryProvider<FavoritesRepository>(create: (context) => FavoritesRepositoryImpl()),
        RepositoryProvider<RemoteConfigRepository>(create: (context) => RemoteConfigRepositoryImpl()),
        RepositoryProvider<WeatherRepository>(create: (context) => WeatherRepositoryImpl()),
        RepositoryProvider<BookingRepository>(create: (context) => BookingRepositoryImpl()),
        RepositoryProvider<NotificationService>.value(value: notificationService),
        RepositoryProvider<SettingsRepository>.value(value: settingsRepository),
      ],

      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepository: context.read<AuthRepository>())..add(CheckAuthStatus())),
          BlocProvider<FavoritesBloc>(create: (context) => FavoritesBloc(favoritesRepository: context.read<FavoritesRepository>())),
          BlocProvider<PopularPlacesBloc>(create: (context) => PopularPlacesBloc(placesRepository: context.read<PlacesRepository>())..add(FetchPopularPlaces())),
          BlocProvider<WeatherBloc>(create: (context) => WeatherBloc(weatherRepository: context.read<WeatherRepository>())..add(WeatherRequested())),
          BlocProvider<BookingBloc>(create: (context) => BookingBloc(bookingRepository: context.read<BookingRepository>())),
          BlocProvider<CalendarBloc>(create: (context) => CalendarBloc()),
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(settingsRepository: settingsRepository, initialThemeMode: initialThemeMode),
          ),
        ],

        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Travenor',
              themeMode: state.themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              onGenerateRoute: appRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
