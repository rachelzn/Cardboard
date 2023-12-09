import 'package:cardboard/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:cardboard/styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) {
          CookieRequest request = CookieRequest();
          return request;
        },
        child: MaterialApp(
          title: 'Cardboard',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colorz.black,
              // Adjust other color scheme properties if needed
            ),
            useMaterial3: true,
            // Set the cursor color for all text fields
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colorz.ashbrown,
            ),
          ),
          home: LoginPage(),
        ));
  }
}
