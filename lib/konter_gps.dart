import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konter_gps/intro_page.dart';

class KonterGps extends StatelessWidget {
  const KonterGps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          scaffoldBackgroundColor: Colors.white),
      home: const IntroPage(),
    );
  }
}
