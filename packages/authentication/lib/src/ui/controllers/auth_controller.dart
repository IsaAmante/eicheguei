import 'dart:developer';

import 'package:authentication/src/data/services/user_service.dart';
import 'package:common/common.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends Controller {
  final UserService userService;
  AuthController(this.userService);

  void signInSilently() async {
    var user = FirebaseAuth.instance.currentUser;
    await userService.getUserInfoByEmail(
      user?.email,
      user?.displayName,
    );
    _user = await googleSignIn.signInSilently();
    //if (_user == null) setStatus(Status.success);
  }

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  Future signInWithGoogle() async {
    setStatus(Status.loading);
    _user = await googleSignIn.signIn();

    if (_user != null) {
      final GoogleSignInAuthentication? googleAuth =
          await _user?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      AppUser? user = await userService.getUserInfoByEmail(
        _user?.email,
        _user?.displayName,
      );

      if (user != null) {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        await googleSignIn.disconnect();
        // TODO: mostra mensagem pedindo para falar com a empresa
        log('Falar com a empresa');
      }
    }
    setStatus(Status.success);
  }

  signOut() async {
    setStatus(Status.loading);
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    setStatus(Status.success);
  }
}
