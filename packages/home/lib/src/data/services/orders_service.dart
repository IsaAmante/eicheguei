import 'dart:async';
import 'package:common/common.dart';

class OrdersService {
  static OrdersService? _instance;
  late FirebaseFirestore _firestore;

  factory OrdersService() {
    _instance ??= OrdersService._internalConstructor();
    return _instance!;
  }

  OrdersService._internalConstructor() {
    _firestore = FirebaseFirestore.instance;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? subscribeToOrderChanges(
      String? userUid) {
    if (userUid != null) {
      return _firestore
          .collection('orders')
          .where('user', isEqualTo: userUid)
          .snapshots();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? subscribeToCondominiumChanges(
      String? condRef) {
    if (condRef != null) {
      return _firestore
          .collection('orders')
          .where('condominium', isEqualTo: _firestore.doc(condRef))
          .snapshots();
    }
  }

  Future<void> addOrder(Order order) async {
    await _firestore.collection('orders').add({
      'date': order.date,
      'description': order.description,
      'status': parseOrderStatusToString(order.status),
      'user': order.user,
      'condominium': _firestore.doc(order.condominiumRef),
    });
  }

  Future<void> deleteOrder(String? uid) async {
    if (uid != null) {
      await _firestore.collection('orders').doc(uid).delete();
    }
  }
}
