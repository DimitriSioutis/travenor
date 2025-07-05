import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/constants.dart';
import 'data/repositories/auth_repository.dart';
import 'firebase_options.dart';
import 'logic/blocs/auth/auth_bloc.dart';
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
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(authRepository: context.read<AuthRepository>()),
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
