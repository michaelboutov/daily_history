import 'package:flutter/cupertino.dart';
import 'package:dailyhistory0/pages/archivePage.dart';
import 'package:dailyhistory0/pages/HomePage.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PageView(
      physics: ClampingScrollPhysics(),
      children: <Widget>[HomePage(), ArchivePage()],
    ));
  }
}
