import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:dailyhistory0/pages/loginPage.dart';

Future<void> addFavorite({String userID, int articleID}) async {
  await FirebaseFirestore.instance
      .collection('favorite')
      .doc(userID)
      .get()
      .then((doc) {
    if (doc.exists) {
      FirebaseFirestore.instance.collection('favorite').doc(userID).update({
        "data": FieldValue.arrayUnion([articleID])
      });
    } else {
      return FirebaseFirestore.instance.collection('favorite').doc(userID).set({
        "data": [articleID]
      });
    }
  });
}

Future<void> deleteFavorite({String userID, int articleID}) async {
  await FirebaseFirestore.instance
      .collection("favorite")
      .doc('$userID')
      .update({
    "data": FieldValue.arrayRemove([articleID])
  });
}

Future<bool> likeState({String userID, int articleID, bool like}) async {
  if (like) {
    addFavorite(userID: userID, articleID: articleID);
    return !like;
  } else {
    deleteFavorite(userID: userID, articleID: articleID);
    return !like;
  }
}

Future<bool> wasLike({
  String userID,
  int articleID,
}) async {
  bool _isFavorite;
  //ignore: must_be_immutable
  await FirebaseFirestore.instance
      .collection('favorite')
      .doc(userID)
      .get()
      .then((value) {
    List<int> likedArticles = List.from(value['data']);
    if (likedArticles.contains(articleID)) {
      print('article is favorite for this user');
      _isFavorite = true;
    } else {
      print('article is NOT a favorite for this user');
      _isFavorite = false;
    }
  });
  return _isFavorite;
}

// ignore: missing_return
Future<List> favoriteList({
  String userID,
}) async {
  List likedArticles;
  await FirebaseFirestore.instance
      .collection('favorite')
      .doc(userID)
      .get()
      .then((value) {
    likedArticles = List.from(value['data']);
  });

  if (likedArticles.isNotEmpty) return likedArticles;
}

//ignore: must_be_immutable
class CustumLikeButton extends StatefulWidget {
  String userId;
  int articleId;
  CustumLikeButton({Key key, @required this.articleId, @required this.userId});
  @override
  _CustumLikeButtonState createState() =>
      _CustumLikeButtonState(articleId, userId);
}

class _CustumLikeButtonState extends State<CustumLikeButton> {
  String userId;
  int articleId;
  _CustumLikeButtonState(this.articleId, this.userId);
  @override
  Widget build(BuildContext context) {
    return LitAuthState(
        authenticated: FutureBuilder(
          future: wasLike(userID: userId, articleID: articleId),
          builder: (context, asyncSnapshot) {
            bool _isLiked = asyncSnapshot.data;
            if (asyncSnapshot.data != null)
              return FavoriteButton(
                  iconSize: 40.0,
                  isFavorite: _isLiked,
                  valueChanged: (_isFavorite) {
                    likeState(
                        userID: userId,
                        articleID: articleId,
                        like: _isFavorite);
                  });
            else
              return Container();
          },
        ),
        unauthenticated: FavoriteButton(
            iconSize: 40.0,
            isFavorite: false,
            valueChanged: (_isFavorite) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            }));
  }
}
