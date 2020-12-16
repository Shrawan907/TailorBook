import 'package:TailorsBook/locale/localInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class Authenticate {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future handleSignIn(GoogleSignInAccount account, BuildContext context) async {
    var log = Provider.of<LocalInfo>(context, listen: false);
    if (account != null) {
      final GoogleSignInAuthentication googleAuth =
          await account.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;

      print("\nsigned in " + user.displayName + "\n");

      log.changeStatustoLogin();

      return user;
    }
  }

  login(BuildContext context) async {
    var log = Provider.of<LocalInfo>(context, listen: false);
    log.changeStatustoLogin();
    await googleSignIn.signIn();
  }

  logout(BuildContext context) async {
    var log = Provider.of<LocalInfo>(context, listen: false);
    log.changeStatustoLogout();
    googleSignIn.signOut();
  }
}
