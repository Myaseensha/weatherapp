import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignUp extends GetxController {
  final googleSignIn = GoogleSignIn();
  final Rxn<GoogleSignInAccount> _user = Rxn<GoogleSignInAccount>();
  GoogleSignInAccount get user => _user.value!;

  Future<void> googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user.value = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    update();
  }

  Future<void> googleLogout() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    _user.value = null;
    update();
  }
}
