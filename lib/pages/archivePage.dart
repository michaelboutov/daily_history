import 'package:dailyhistory0/services/articleNumber.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:dailyhistory0/services/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhistory0/services/ad_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:dailyhistory0/services/likeButton.dart';
import 'package:page_transition/page_transition.dart';

class ArchivePage extends StatefulWidget {
  @override
  _ArchivePage createState() => _ArchivePage();
}

class _ArchivePage extends State<ArchivePage> {
  @override
  Widget build(BuildContext context) {
    String _userId;
    var user = context.getSignedInUser();
    user.when(
      (user) => _userId = user.uid,
      empty: () {},
      initializing: () {},
    );
    int _currentSliderValue = context.read<ArticleNumber>().count;
    int _adCount = context.read<AdCounter>().count;
    //get the counter of articles was open
    if (_adCount % 4 == 0 && _adCount != 0) {
      context
          .read<AdCounter>()
          .increment(); //after showing ad incremit the  counter ,otherwise if you go back to privious article its allso show ad
      AdState.loadInterstitial();
    } // if was open 3 new articles its show ad
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('article')
            .orderBy(
              'timeStamp',
              descending: true,
            )
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            dynamic article = snapshot.data.docs[_currentSliderValue];
            List image = article.data()['image'];
            List text = article.data()['text'];
            String date = article.data()['date'];
            int articleId = article.data()['id'];

            return GestureDetector(
              onHorizontalDragUpdate: (details) {
                int sensitivity = 8;
                if (details.delta.dx > sensitivity && _currentSliderValue > 0) {
                  // Right Swipe
                  //

                  context.read<ArticleNumber>().decrement();
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          child: ArchivePage()));
                } else if (details.delta.dx < -sensitivity &&
                    _currentSliderValue < snapshot.data.docs.length - 1) {
                  //Left Swipe
                  //
                  context.read<ArticleNumber>().increment();
                  context.read<AdCounter>().increment();
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: ArchivePage()));
                }
              },
              child: Scaffold(
                drawer: Menu(),
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      actions: <Widget>[
                        SizedBox(
                            width: 25,
                            height: 25,
                            child: CustumLikeButton(
                                articleId: articleId, userId: _userId)),
                        Container(
                          width: 15,
                        ),
                      ],
                      backgroundColor: Colors.black,
                      expandedHeight: 520.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text("DailyHistory",
                            style: GoogleFonts.notable(
                                fontSize: 25, color: Colors.white)),
                        background: Image.network('${image[0]}'),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.black,
                        child: Column(
                          children: [
                            Container(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 100,
                                ),
                                Text("archive",
                                    style: GoogleFonts.notable(
                                        fontSize: 35, color: Colors.white)),
                              ],
                            ),
                            Container(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 85,
                                ),
                                IconButton(
                                  iconSize: 30,
                                  color: Colors.white,
                                  icon: Icon(Icons.arrow_back),
                                  tooltip: 'previos article',
                                  onPressed: () {
                                    if (_currentSliderValue > 0) {
                                      context.read<ArticleNumber>().decrement();
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .leftToRightWithFade,
                                              child: ArchivePage()));
                                    }
                                  },
                                ),
                                Container(
                                  width: 15,
                                ),
                                Text("$date",
                                    style: GoogleFonts.notable(
                                        fontSize: 19, color: Colors.white)),
                                Container(
                                  width: 15,
                                ),
                                IconButton(
                                  iconSize: 30,
                                  color: Colors.white,
                                  icon: Icon(Icons.arrow_forward),
                                  tooltip: 'next article',
                                  onPressed: () {
                                    if (_currentSliderValue <
                                        snapshot.data.docs.length - 1) {
                                      context.read<AdCounter>().increment();
                                      context.read<ArticleNumber>().increment();
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeftWithFade,
                                              child: ArchivePage()));
                                    }
                                  },
                                ),
                              ],
                            ),
                            Slider(
                                value: _currentSliderValue.toDouble(),
                                activeColor: Colors.white,
                                inactiveColor: Colors.grey[600],
                                min: 0,
                                max: snapshot.data.docs.length.toDouble() - 1,
                                divisions: snapshot.data.docs.length - 1,
                                label: _currentSliderValue.round().toString(),
                                onChanged: (double value) {
                                  context.read<AdCounter>().increment();
                                  context
                                      .read<ArticleNumber>()
                                      .setNumber(value);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ArchivePage()),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: text.length,
                          padding: const EdgeInsets.only(top: 5.0),
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.all(28.0),
                                    child: Text(
                                      text[index],
                                      style: GoogleFonts.oswald(fontSize: 19),
                                    )),
                                Image.network('${image[index + 1]}'),
                                if (index.toDouble() % 4 == 0 && index != 0)
                                  SizedBox(
                                      height: 100,
                                      child: AdWidget(
                                          key: UniqueKey(),
                                          ad: AdState.createBannerAd()..load()))
                              ],
                            );
                          }),
                      Container(
                        height: 30,
                      ),
                      Text(
                        'thank you for using this app if you enjoy it  you can help with rating us on the store',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.oswald(
                            fontSize: 25, color: Colors.black),
                      ),
                      Container(
                        height: 30,
                      ),
                      Text(
                        'all images and information from wikipedia and other open sources',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      Container(
                        height: 20,
                      )
                    ])),
                  ],
                ),
              ),
            );
          }
        });
  }
}
