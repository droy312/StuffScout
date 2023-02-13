import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            headline1: GoogleFonts.poppins(
              fontSize: 93,
              fontWeight: FontWeight.w300,
              letterSpacing: -1.5,
            ),
            headline2: GoogleFonts.poppins(
              fontSize: 58,
              fontWeight: FontWeight.w300,
              letterSpacing: -0.5,
            ),
            headline3: GoogleFonts.poppins(
              fontSize: 46,
              fontWeight: FontWeight.w400,
            ),
            headline4: GoogleFonts.poppins(
              fontSize: 33,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25,
            ),
            headline5: GoogleFonts.poppins(
              fontSize: 23,
              fontWeight: FontWeight.w400,
            ),
            headline6: GoogleFonts.poppins(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
            ),
            subtitle1: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.15,
            ),
            subtitle2: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
            bodyText1: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
            bodyText2: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25,
            ),
            button: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25,
            ),
            caption: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4,
            ),
            overline: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.5,
            ),
          ),
        ),
        onGenerateRoute: RouteGenerator.generateRoutes,
        initialRoute: HomePage.routeName,
      ),
    );
  }
}
