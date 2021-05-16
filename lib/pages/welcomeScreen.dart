import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dailyhistory0/services/backGroundVideo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dailyhistory0/pages/landingPage.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Size _size;
  double _appbarSize;
  int _nOfpages = 3;
  int _currentPage = 0;
  PageController _controller = PageController(initialPage: 0);

  List<Widget> _buildIndicators() {
    List<Widget> wlist = [];
    for (int i = 0; i < _nOfpages; i++) {
      wlist.add((i == _currentPage) ? _indicator(true) : _indicator(false));
    }

    return wlist;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      height: 8.0,
      width: 8.0,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white54,
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
    );
  }

  void _setPageState(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _moveToNextPage() {
    _controller.jumpToPage(_currentPage + 1);
  }

  void _sysTemUIConfig() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void initState() {
    super.initState();
    _sysTemUIConfig(); //now we will hard reset
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    _appbarSize = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Background(
        childWidget: _body(),
      ),
    );
  }

  Widget _body() {
    return SizedBox.expand(
      child: Container(
        height: _size.height,
        width: _size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: _appbarSize),
                child: TextButton(
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                    )
                  },
                ),
              ),
              Container(
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (value) => _setPageState(value),
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.account_balance_outlined,
                            size: 95,
                            color: Colors.white,
                          ),
                          Container(
                            height: 200,
                          ),
                          Text(
                            'DailyHistory',
                            style: GoogleFonts.notable(
                                fontSize: 35, color: Colors.white),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Text(
                            'help you learn something new about our history everyday ',
                            style: GoogleFonts.notable(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.auto_stories,
                            size: 95,
                            color: Colors.white,
                          ),
                          Container(
                            height: 190,
                          ),
                          Text(
                            'Long history short',
                            style: GoogleFonts.notable(
                                fontSize: 35, color: Colors.white),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'short articles about      5 - 10 minutes of read ',
                            style: GoogleFonts.notable(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.emoji_objects_outlined,
                            size: 95,
                            color: Colors.white,
                          ),
                          Container(
                            height: 270,
                          ),
                          Text(
                            '"Those that fail to learn from history, are doomed to repeat it."',
                            style: GoogleFonts.notable(
                                fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Winston Churchill',
                            style: GoogleFonts.notable(
                                fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicators(),
                ),
              ),
              Container(
                child: Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 100,
                          height: 45,
                          child: (_currentPage != _nOfpages - 1)
                              ? OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                            width: 2,
                                            color: Colors.white,
                                          ))),
                                  child: Text('Continue',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                  onPressed: () => _moveToNextPage(),
                                )
                              : TextButton(
                                  style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      primary: Colors.white,
                                      backgroundColor: Colors.green),
                                  child: Text(
                                    '  Start  ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LandingPage()),
                                    )
                                  },
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
