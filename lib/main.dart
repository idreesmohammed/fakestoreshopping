import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.white),
        primaryColor: Colors.grey,
        accentColor: Colors.grey,
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
