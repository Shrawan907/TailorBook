import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class Authenticate {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future handleSignIn(GoogleSignInAccount account) async {
    if (account != null) {
      final GoogleSignInAuthentication googleAuth =
          await account.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;

      print("\nsigned in " + user.displayName + "\n");
      return user;
    }
  }

  login() async {
    await googleSignIn.signIn();
  }

  logout() async {
    googleSignIn.signOut();
  }
}
