import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:home/src/data/services/orders_service.dart';
import 'package:home/src/ui/controllers/home_controller.dart';
import 'package:nested/nested.dart';

class HomeModule extends ModuleInterface {
  @override
  List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider(
        create: (context) => HomeController(
          UserService(),
          OrdersService(),
        ),
      ),
    ];
  }
}
