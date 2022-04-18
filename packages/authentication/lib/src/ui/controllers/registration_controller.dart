import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegistrationController extends Controller {
  final UserService userService;
  RegistrationController(this.userService) {
    nameController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
  }

  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController phoneController;

  initRegistration() {
    nameController.clear();
    addressController.clear();
    phoneController.clear();
  }

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  Future<bool> checkForExistingUser() async {
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
        return true;
      } else {
        return false;
      }
    }
    setStatus(Status.success);
    return false;
  }

  Future<void> cancelGoogleUser() async {
    await googleSignIn.disconnect();
  }

  Future<void> registerCondominium() async {
    setStatus(Status.loading);
    if (_user != null) {
      final GoogleSignInAuthentication? googleAuth =
          await _user?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      var condominium = Condominium(
        name: nameController.text,
        localization: GeoPoint(0, 0),
        responsible: _user!.email,
      );

      condominium.condRef = await userService.createCondominium(condominium);

      AppUser user = userService.user ??
          AppUser(
            uid: _user!.email,
            name: _user!.displayName ?? '',
            condominium: condominium,
          );
      user.access = AccessType.condominium;

      await userService.createUser(
        user,
        condominium.condRef!,
      );

      googleSignIn.disconnect();
    }
    setStatus(Status.success);
  }
}
