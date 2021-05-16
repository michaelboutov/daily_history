import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:dailyhistory0/services/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:dailyhistory0/services/ad_state.dart';
import 'package:dailyhistory0/services/likeButton.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            dynamic article = snapshot.data.docs[0];
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
                        title: Text(" DailyHistory",
                            style: GoogleFonts.notable(
                                fontSize: 25, color: Colors.white)),
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
                                if (index.toDouble() % 3 == 0)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 25,
                                      color: Colors.grey[500],
                                    ),
                                  ),
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
