# Art Explorer

A Flutter mobile app for browsing the Art Institute of Chicago's public collection. Users can create an account, browse and search thousands of artworks, and save favourites to a personal collection that syncs across devices.

<!-- TODO: add screenshots or demo gif -->

## Features

- Browse and search the AIC public collection (CC0, no API key required)
- Filter artworks by style
- Save favourites to a personal collection synced via Firestore
- Email/password and Google Sign-In authentication

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (iOS, Android, Web) |
| State management | BLoC |
| Auth | Firebase Auth |
| Database | Firestore |
| Image caching | cached_network_image |
| Data source | AIC Public API |

## Architecture

Follows a strict BLoC + Repository pattern:

```
UI (screens / widgets)
  ↓
BLoC — events in, states out, no UI references
  ↓
Repository — API and Firestore calls
  ↓
Models — plain Dart data classes
```

Each BLoC owns one domain: `AuthBloc`, `ArtworkBloc`, `CollectionBloc`. Screens dispatch events and rebuild from states — no business logic in the UI layer.

## Firebase Setup

Firebase config files are not committed to this repo. To run the project locally:

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Enable **Email/Password** and **Google Sign-In** under Authentication
3. Enable **Firestore** in your project
4. Run `flutterfire configure` to generate the platform config files
5. Add the SHA-1 fingerprint to your Android app in the Firebase console (required for Google Sign-In on Android)
6. For iOS: open `GoogleService-Info.plist`, copy the `REVERSED_CLIENT_ID` value, and add it as a URL scheme in Xcode under Runner → Info → URL Types

## Running the App

```bash
git clone https://github.com/eomapps/artexplorer_flutter.git
cd artexplorer_flutter
flutter pub get
flutter run
```
