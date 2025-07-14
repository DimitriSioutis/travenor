import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor/src/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:travenor/src/features/onboarding/data/repositories/remote_config_repository_impl.dart';
import 'package:travenor/src/features/places/data/repositories/places_repository_impl.dart';
import 'package:travenor/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:travenor/src/features/places/domain/repositories/places_repository.dart';
import 'src/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'firebase_options.dart';
import 'src/features/favorites/presentation/bloc/favorites/favorites_bloc.dart';
import 'src/features/onboarding/domain/repositories/remote_config_repository.dart';
import 'src/features/places/presentation/bloc/popular_places/popular_places_bloc.dart';
import 'src/features/places/presentation/bloc/popular_places/popular_places_event.dart';
import 'src/utils/app_bloc_observer.dart';
import 'src/routing/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/features/auth/domain/repositories/auth_repository.dart';
import 'src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'src/utils/theme/theme.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) => AuthRepositoryImpl()),
        RepositoryProvider<PlacesRepository>(create: (context) => PlacesRepositoryImpl()),
        RepositoryProvider<FavoritesRepository>(create: (context) => FavoritesRepositoryImpl()),
        RepositoryProvider<RemoteConfigRepository>(create: (context) => RemoteConfigRepositoryImpl()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepository: context.read<AuthRepository>())),
          BlocProvider<FavoritesBloc>(create: (context) => FavoritesBloc(favoritesRepository: context.read<FavoritesRepository>())),
          BlocProvider<PopularPlacesBloc>(create: (context) => PopularPlacesBloc(placesRepository: context.read<PlacesRepository>())..add(FetchPopularPlaces())),
        ],
        child: MaterialApp(
          title: 'Travenor',
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,

          onGenerateRoute: appRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
