import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:dailyhistory0/services/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:dailyhistory0/services/ad_state.dart';
import 'package:dailyhistory0/services/likeButton.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

// ignore: must_be_immutable
class LikedArticlePage extends StatefulWidget {
  int articleID;
  LikedArticlePage({Key key, @required this.articleID});
  @override
  _LikedArticlePageState createState() => _LikedArticlePageState(articleID);
}

class _LikedArticlePageState extends State<LikedArticlePage> {
  int articleID;
  _LikedArticlePageState(this.articleID);
  @override
  Widget build(BuildContext context) {
    String _userId;
    var user = context.getSignedInUser();
    user.when(
      (user) => _userId = user.uid,
      empty: () {},
      initializing: () {},
    );
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('article').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            dynamic article = snapshot.data.docs[articleID];
            List image = article['image'];
            List text = article['text'];
            int articleId = article['id'];

            return Scaffold(
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
                        title: Text(
                          " DailyHistory",
                          style: GoogleFonts.notable(
                              fontSize: 25, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        background: Image.network('${image[0]}'),
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
                                    margin: EdgeInsets.all(20.0),
                                    child: Text(
                                      text[index],
                                      style: GoogleFonts.oswald(fontSize: 19),
                                    )),
                                Image.network('${image[index + 1]}'),
                                if (index.toDouble() % 5 == 0 && index != 0)
                                  SizedBox(
                                      height: 100,
                                      child: AdWidget(
                                        key: UniqueKey(),
                                        ad: AdState.createBannerAd()..load(),
                                      ))
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
                drawer: Menu());
          }
        });
  }
}
