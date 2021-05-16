import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumPage extends StatefulWidget {
  @override
  _PremiumPageState createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DaylyHistory',
          style: GoogleFonts.notable(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(" this function not available now",
            textAlign: TextAlign.center,
            style: GoogleFonts.notable(fontSize: 20, color: Colors.black)),
      ),
    );
  }
}
