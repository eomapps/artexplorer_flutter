import 'package:artexplorer/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GoogleSignIn.instance.initialize(
    serverClientId:
        '317626111342-53vhmb7oor101gr6f9004pn3j70fep0f.apps.googleusercontent.com',
  );
  runApp(const MyApp());
}
