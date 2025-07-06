import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor/data/repositories/places_repository.dart';
import 'constants/constants.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/favorites_repository.dart';
import 'firebase_options.dart';
import 'logic/blocs/auth/auth_bloc.dart';
import 'logic/blocs/favorites/favorites_bloc.dart';
import 'logic/blocs/popular_places/popular_places_bloc.dart';
import 'logic/blocs/popular_places/popular_places_event.dart';
import 'logic/blocs/remote_config/remote_config_bloc.dart';
import 'logic/blocs/remote_config/remote_config_event.dart';
import 'logic/utility/app_bloc_observer.dart';
import 'presentation/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';

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
        RepositoryProvider<AuthRepository>(create: (context) => AuthRepository()),
        RepositoryProvider<PlacesRepository>(create: (context) => PlacesRepository()),
        RepositoryProvider<FavoritesRepository>(create: (context) => FavoritesRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepository: context.read<AuthRepository>())),
          BlocProvider<FavoritesBloc>(create: (context) => FavoritesBloc(favoritesRepository: context.read<FavoritesRepository>())),
          BlocProvider<PopularPlacesBloc>(create: (context) => PopularPlacesBloc(placesRepository: context.read<PlacesRepository>())..add(FetchPopularPlaces())),
        ],
        child: MaterialApp(
          title: 'Travenor',
          theme: ThemeData(
            // colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
            fontFamily: 'sf',
          ),
          onGenerateRoute: appRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
