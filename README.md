# Travenor - Travel & Booking App

Travenor is a modern, feature-rich travel application built with Flutter, designed to provide a seamless booking and travel exploration experience. The app leverages the full power of the Firebase ecosystem for its backend and implements a clean, scalable architecture using `flutter_bloc` for state management.

## Features
-   **Firebase Authentication**: Full user authentication suite including Sign Up, Sign In (Email & Google), and Forgot Password functionality.
-   **Persistent Login**: Users remain logged in across app restarts for a smooth user experience.
-   **Feature-Based Architecture**: Codebase is cleanly organized into features (Auth, Home, Calendar, etc.), each following a strict Data, Domain, and Presentation layer separation.
-   **BLoC State Management**: Predictable and scalable state management using `flutter_bloc`.

-   **Place Booking & Management**: Users can book places directly from the details screen by selecting a date. An overview of all booked places is available, with the option to cancel a booking.
-   **Interactive Calendar View**: A dedicated calendar screen allows users to view their booked places filtered by a specific date, providing a clear visual schedule of their trips.
-   **Favorites/Wishlist**: Users can add places to a personal list of favorites. The list is easily accessible from the user's profile screen.
-   **Place Search**: A robust search functionality allows users to quickly find places by name.

-   **Real-time Weather Widget**: Displays the current weather by consuming a custom gRPC API deployed on Google Cloud Run.
-   **Push Notifications**: Integrated with Firebase Cloud Messaging (FCM). Notifications received while the app is in the background or terminated are handled natively by the Firebase SDK.
-   **Dynamic Onboarding**: The onboarding flow can be dynamically controlled via Firebase Remote Config.
-   **Theming**: Users can switch between Light and Dark mode, with their preference saved locally.
-   **Location Services**: Utilizes the device's GPS to fetch the user's current location.
-   **Custom Animated Navigation**: Smooth, custom page transitions for a polished UI.

## Architecture & Tech Stack

This project was built with scalability and maintainability in mind.

-   **State Management**: `flutter_bloc`
-   **Dependency Injection**: `MultiRepositoryProvider` and `MultiBlocProvider` for clean dependency management.
-   **Backend-as-a-Service**: Firebase (Auth, Cloud Firestore, Firebase Storage, FCM, Remote Config).
-   **Networking**:
    -   **gRPC**: For real-time, high-performance communication with the custom weather service.
-   **Local Storage**: `shared_preferences` for user preferences.
-   **Routing**: Custom routing solution using `onGenerateRoute` to enable animated page transitions.
-   **Models & Equality**: `equatable` for value equality in models and BLoC states.

### Custom gRPC Weather Service

A key feature of this project is the integration with a weather service via gRPC. To ensure stability, scalability, and control over the API, the open-source [OpenWeather-gRPC-API](https://codeberg.org/andyscott/OpenWeather-gRPC-API) was deployed as a containerized service on **Google Cloud Run**. The Flutter app communicates directly with this secure and scalable endpoint, not the original open-source server.

## Getting Started

To run this project locally, follow these steps:

1.  **Prerequisites**:
    -   Ensure you have Flutter installed.
    -   You have set up a Firebase project and have the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files.

2.  **Clone the repository**:
    ```bash
    git clone https://github.com/DimitriSioutis/travenor.git
    cd travenor
    ```

3.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

4.  **Firebase Setup**:
    -   Run the FlutterFire CLI to generate your `firebase_options.dart` file: `flutterfire configure`.
    -   **For Google Sign-In on Android**: Make sure you have added your `SHA-1` debug key to the Firebase project settings.

5.  **Run the app**:
    ```bash
    flutter run
    ```

---
*This project was developed as part of an assignment.*
*Designed by Mood*