import 'package:flutter/material.dart';
import 'package:konter_gps/page/homepage.dart';

class KonterGps extends StatelessWidget {
  const KonterGps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(),
    );
  }
}
