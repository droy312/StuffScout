import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/palette.dart';
import 'package:stuff_scout/features/home/presenter/pages/home.dart';
import 'package:stuff_scout/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Palette _palette = Palette();

  @override
  void initState() {
    super.initState();

    _palette.getColors();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _palette),
      ],
      child: MaterialApp(
        title: 'StuffScout',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        onGenerateRoute: RouteGenerator.generateRoutes,
        initialRoute: HomePage.routeName,
      ),
    );
  }
}
