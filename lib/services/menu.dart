import 'package:dailyhistory0/pages/archivePage.dart';
import 'package:dailyhistory0/pages/premiumPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:dailyhistory0/pages/likesPage.dart';
import 'package:dailyhistory0/pages/loginPage.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,

          children: <Widget>[
            Container(
              height: 300,
              child: DrawerHeader(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(44, 44, 44, 10),
                    image: DecorationImage(
                        image: AssetImage("assets/logo.jpg"),
                        fit: BoxFit.cover)),
                child: null,
              ),
            ),
            ListTile(
              title: NeumorphicButton(
                style: NeumorphicStyle(
                  color: Colors.white,
                ),
                onPressed: () async {
                  await new Future.delayed(const Duration(milliseconds: 260));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LikesPage()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      size: 30,
                      color: Colors.red,
                    ),
                    Text(
                      '        likes',
                      style: GoogleFonts.oswald(
                          fontSize: 20, color: Color.fromRGBO(44, 44, 44, 10)),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            ListTile(
              title: NeumorphicButton(
                style: NeumorphicStyle(
                  color: Colors.white,
                ),
                onPressed: () async {
                  await new Future.delayed(const Duration(milliseconds: 260));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ArchivePage()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.access_time, size: 30, color: Colors.black),
                    Text(
                      '      Archive',
                      style: GoogleFonts.oswald(
                          fontSize: 20, color: Color.fromRGBO(44, 44, 44, 10)),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            ListTile(
              title: NeumorphicButton(
                style: NeumorphicStyle(
                  color: Colors.white,
                ),
                onPressed: () async {
                  await new Future.delayed(const Duration(milliseconds: 260));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.assignment_ind_rounded,
                      size: 30,
                      color: Colors.black,
                    ),
                    Text(
                      '     sign in/out',
                      style: GoogleFonts.oswald(
                          fontSize: 20, color: Color.fromRGBO(44, 44, 44, 10)),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            ListTile(
              title: NeumorphicButton(
                style: NeumorphicStyle(
                  color: Colors.white,
                ),
                onPressed: () async {
                  await new Future.delayed(const Duration(milliseconds: 260));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PremiumPage()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 30,
                      color: Colors.amberAccent,
                    ),
                    Text(
                      '     Premium',
                      style: GoogleFonts.oswald(
                          fontSize: 20, color: Color.fromRGBO(44, 44, 44, 10)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
