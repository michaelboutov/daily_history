import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
import 'services/ad_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dailyhistory0/pages/welcomeScreen.dart';
import 'package:dailyhistory0/pages/landingPage.dart';
import 'package:provider/provider.dart';
import 'package:dailyhistory0/services/articleNumber.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  AdState.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool _seen = (prefs.getBool('seen') ?? false);

  if (_seen) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ArticleNumber()),
          ChangeNotifierProvider(create: (_) => AdCounter())
        ],
        child: MyApp(),
      ),
    );
  } else {
    await prefs.setBool('seen', true);
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ArticleNumber()),
          ChangeNotifierProvider(create: (_) => AdCounter())
        ],
        child: Wallcome(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LitAuthInit(
      authProviders: AuthProviders(
        apple: true,
        emailAndPassword: true,
        google: true,
      ),
      child: MaterialApp(
        title: 'DailyHistory',
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
  }
}

class Wallcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LitAuthInit(
      authProviders: AuthProviders(
        emailAndPassword: true,
        google: true,
      ),
      child: MaterialApp(
        title: 'DailyHistory',
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
      ),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
