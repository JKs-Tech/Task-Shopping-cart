import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_cart/bloc/login_bloc/login_bloc.dart';

import 'package:shoping_cart/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBlock(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping Cart',
        home: SplashScreen(),
      ),
    );
  }
}
