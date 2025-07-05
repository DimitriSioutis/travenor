import 'package:flutter/material.dart';
import 'package:travenor/presentation/screens/authentication/signup_screen.dart';
import 'package:travenor/presentation/screens/main_screen.dart';
import '../screens/authentication/login_screen.dart';
import '../screens/bottom_bar_pages/home_page.dart';
import '../screens/place_screen/place_screen.dart';
import '../utils/error_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/main':
        return MaterialPageRoute(builder: (_) => const MainScreen());
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
