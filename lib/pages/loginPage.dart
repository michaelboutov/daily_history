import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:dailyhistory0/services/menu.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:dailyhistory0/pages/landingPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          " DailyHistory",
          style: GoogleFonts.notable(fontSize: 25, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
              child: LitAuthState(
                  authenticated: Column(
                    children: [
                      Text("You are sign in",
                          style: GoogleFonts.notable(
                              fontSize: 25, color: Colors.black)),
                      Container(
                        height: 100,
                      ),
                      Container(
                        width: 180,
                        child: ListTile(
                          title: NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await new Future.delayed(
                                  const Duration(milliseconds: 260));
                              context.signOut();
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.assignment_ind_rounded,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                Text(
                                  '  sign out',
                                  style: GoogleFonts.oswald(
                                      fontSize: 20,
                                      color: Color.fromRGBO(44, 44, 44, 10)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(height: 40),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 145,
                          child: ListTile(
                            title: NeumorphicButton(
                              style: NeumorphicStyle(
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                await new Future.delayed(
                                    const Duration(milliseconds: 260));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LandingPage()),
                                );
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    '  back',
                                    style: GoogleFonts.oswald(
                                        fontSize: 20,
                                        color: Color.fromRGBO(44, 44, 44, 10)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  unauthenticated: LitAuth(
                    config: AuthConfig(
                      googleButton: GoogleButtonConfig.light(),
                      title: Column(
                        children: [
                          Center(
                            child: Text(
                              " if you want to save and see your favorite articles you need to sign in ",
                              style: GoogleFonts.oswald(fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                  )))),
      drawer: Menu(),
    );
  }
}
