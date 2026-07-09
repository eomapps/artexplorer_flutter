import 'package:artexplorer/blocs/artwork/artwork_bloc.dart';
import 'package:artexplorer/blocs/auth/auth_bloc.dart';
import 'package:artexplorer/blocs/auth/auth_event.dart';
import 'package:artexplorer/blocs/auth/auth_state.dart';
import 'package:artexplorer/blocs/collection/collection_bloc.dart';
import 'package:artexplorer/repositories/art_repository.dart';
import 'package:artexplorer/repositories/auth_repository.dart';
import 'package:artexplorer/repositories/collection_repository.dart';
import 'package:artexplorer/screens/auth_screen.dart';
import 'package:artexplorer/screens/browse_screen.dart';
import 'package:artexplorer/theme/app_theme.dart';
import 'package:artexplorer/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArtworkBloc>(
          create: (BuildContext context) => ArtworkBloc(ArtRepository()),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              AuthBloc(AuthRepository())..add(CheckAuth()),
        ),
        BlocProvider<CollectionBloc>(
          create: (BuildContext context) =>
              CollectionBloc(context.read<AuthBloc>(), CollectionRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appTitle,
        theme: AppTheme.theme,
        home: const AppBase(),
      ),
    );
  }
}

class AppBase extends StatelessWidget {
  const AppBase({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return switch (state) {
          AuthAuthenticated() => BrowseScreen(),
          AuthLoading() => Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          AuthUnauthenticated() => AuthScreen(),
          AuthError() => AuthScreen(),
        };
      },
    );
  }
}
