import 'package:dailyhistory0/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:dailyhistory0/services/menu.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhistory0/services/likeButton.dart';
import 'package:dailyhistory0/pages/likedArticlePage.dart';

class LikesPage extends StatefulWidget {
  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  @override
  Widget build(BuildContext context) {
    List likedList;
    String _userId;

    var user = context.getSignedInUser();
    user.when(
      (user) => _userId = user.uid,
      empty: () {},
      initializing: () {},
    );

    return Container(
        child: LitAuthState(
            authenticated: FutureBuilder(
                future: favoriteList(userID: _userId),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.data != null) {
                    likedList = asyncSnapshot.data;

                    return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('article')
                            .orderBy('id')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
                            return CircularProgressIndicator();
                          } else {
                            return Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Colors.black,
                                  title: Text("  DailyHistory",
                                      style: GoogleFonts.notable(
                                          fontSize: 25, color: Colors.white)),
                                ),
                                body: CustomScrollView(
                                  slivers: <Widget>[
                                    SliverList(
                                        delegate: SliverChildListDelegate([
                                      Container(
                                          width: 120,
                                          color: Colors.black,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 135,
                                              ),
                                              Text(" your ",
                                                  style: GoogleFonts.notable(
                                                      fontSize: 30,
                                                      color: Colors.white)),
                                              Icon(
                                                Icons.favorite,
                                                size: 30,
                                                color: Colors.red,
                                              ),
                                            ],
                                          )),
                                      ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: likedList.length,
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          itemBuilder: (context, index) {
                                            dynamic article = snapshot
                                                .data.docs[likedList[index]];
                                            int articleID = article['id'];
                                            List image = article['image'];
                                            return GestureDetector(
                                              child: Card(
                                                semanticContainer: true,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                child: Image.network(
                                                  '${image[0]}',
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          35.0),
                                                ),
                                                elevation: 5,
                                                margin: EdgeInsets.all(20),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LikedArticlePage(
                                                              articleID:
                                                                  articleID),
                                                    ));
                                              },
                                            );
                                          }),
                                    ])),
                                  ],
                                ),
                                drawer: Menu());
                          }
                        });
                  } else
                    return Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.black,
                        title: Text(
                          " DailyHistory",
                          style: GoogleFonts.notable(
                              fontSize: 25, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      body: Center(
                        child: Text(
                          'you are dont have any likes ',
                          style: GoogleFonts.notable(
                              fontSize: 20, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                }),
            unauthenticated: LoginPage()));
  }
}
