import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:home/src/data/services/orders_service.dart';

class HomeController extends Controller {
  final UserService userService;
  final OrdersService ordersService;
  HomeController(
    this.userService,
    this.ordersService,
  );

  bool _editingMode = false;
  bool get isEditing => _editingMode;

  List<Order> orders = [];

  bool get isProfileComplete => userService.user?.condominium != null;

  Stream<QuerySnapshot<Map<String, dynamic>>>? orderStream;

  iniltializeOrders() async {
    orderStream = null;
    orders.clear();
    if (userService.user != null) {
      if (userService.user!.access == AccessType.user ||
          userService.user!.access == AccessType.condominium) {
        orderStream =
            ordersService.subscribeToOrderChanges(userService.user!.uid);
        notifyListeners();
        // TODO: caso o cadastro esteja incompleto, exibir pedido para completar (não obrigatório)
      } else if (userService.user!.access == AccessType.concierge) {
        orderStream = ordersService.subscribeToCondominiumChanges(
          userService.user!.condominium!.condRef,
        );
        notifyListeners();
      }
    }
  }

  List<Order> snapshotToOrdersList(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    orders.clear();
    snapshot.docs.forEach((docSnapshot) {
      if (docSnapshot.exists) {
        var order = Order.fromMap(docSnapshot.data());
        order.uid = docSnapshot.id;

        orders.add(order);
      }
    });
    return orders;
  }

  Future<void> addOrder(String description) async {
    ordersService.addOrder(Order(
      description: description,
      date: DateTime.now(),
      user: userService.user!.uid,
      condominiumRef: userService.user!.condominium!.condRef!,
      status: OrderStatus.waiting,
    ));
  }

  void toogleEditingMode() {
    _editingMode = !_editingMode;
    notifyListeners();
  }

  void selectOrder(int index, bool? value) {
    if (value != null && index >= 0 && index < orders.length) {
      orders[index].selected = value;
      notifyListeners();
    }
  }

  Future<void> deleteOrder(int index) async {
    if (index >= 0 && index < orders.length) {
      await ordersService.deleteOrder(orders[index].uid ?? '');
    }
  }

  Future<void> sendInvitation() async {}
}
