import 'package:authentication/authentication.dart';
import 'package:authentication/src/ui/controllers/auth_controller.dart';
import 'package:authentication/src/ui/controllers/registration_controller.dart';
import 'package:common/common.dart';
import 'package:nested/nested.dart';

class AuthenticationModule extends ModuleInterface {
  @override
  List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider(
        create: (context) => AuthController(UserService()),
      ),
      ChangeNotifierProvider(
        create: (context) => RegistrationController(UserService()),
      ),
    ];
  }
}
