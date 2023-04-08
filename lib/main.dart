import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stuff_scout/color_scheme.dart';
import 'package:stuff_scout/features/container/presenter/cubits/container_cubit.dart';
import 'package:stuff_scout/features/search/presenter/cubits/search_cubit.dart';
import 'package:stuff_scout/service_locator.dart';
import 'package:stuff_scout/route_generator.dart';

void main() async {
  await setUpServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static TextStyle _textStyle(double size,
      [FontWeight weight = FontWeight.w400]) {
    return GoogleFonts.poppins(
      fontSize: size,
      fontWeight: weight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(create: (_) => ContainerCubit()),
      ],
      child: MaterialApp(
        title: 'StuffScout',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          textTheme: TextTheme(
            displayLarge: _textStyle(57),
            displayMedium: _textStyle(45),
            displaySmall: _textStyle(36),
            headlineLarge: _textStyle(32),
            headlineMedium: _textStyle(28),
            headlineSmall: _textStyle(24),
            titleLarge: _textStyle(22),
            titleMedium: _textStyle(16, FontWeight.w500),
            titleSmall: _textStyle(14, FontWeight.w500),
            labelLarge: _textStyle(14, FontWeight.w500),
            labelMedium: _textStyle(12, FontWeight.w500),
            labelSmall: _textStyle(11, FontWeight.w500),
            bodyLarge: _textStyle(16),
            bodyMedium: _textStyle(14),
            bodySmall: _textStyle(12),
          ),
        ),
        onGenerateRoute: RouteGenerator.generateRoutes,
        onGenerateInitialRoutes: RouteGenerator.generateInitialRoutes,
      ),
    );
  }
}
