import 'package:flutter/material.dart';
import 'package:travenor/src/features/onboarding/presentation/view/boarding_screen.dart';
import 'package:travenor/src/features/home/presentation/view/main_screen.dart';
import 'package:travenor/src/features/places/presentation/view/popular_places.dart';
import 'package:travenor/src/features/search/presentation/view/search_screen.dart';
import '../features/home/presentation/view/home_page.dart';
import '../features/places/presentation/view/place_screen.dart';
import '../utils/error_screen.dart';
import '../features/auth/presentation/view/forget_password_screen.dart';
import '../features/auth/presentation/view/login_screen.dart';
import '../features/auth/presentation/view/signup_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const BoardingScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case '/forget_password':
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/main':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case '/popular_places':
        return MaterialPageRoute(builder: (_) => const PopularPlaces());
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      case '/place_details':
        return MaterialPageRoute(
          builder: (_) {
            String? placeId = settings.arguments as String?;
            if (placeId != null) {
              return PlaceScreen(placeId: placeId);
            }
            return ErrorScreen();
          },
        );
      default:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
    }
  }
}
