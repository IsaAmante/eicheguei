import 'dart:convert';

import 'package:common/common.dart';

class AppUser {
  String uid;
  String name;
  Condominium? condominium;
  DateTime? birthday;
  AccessType? access;
  bool isComplete;

  AppUser({
    required this.uid,
    required this.name,
    this.condominium,
    this.birthday,
    this.access,
    this.isComplete = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'condominium': condominium?.toMap(),
      'birthday': birthday?.millisecondsSinceEpoch,
      'access': 'user',
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      condominium: map['condominium'] != null
          ? Condominium.fromMap(map['condominium'])
          : null,
      birthday: map['birthday'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthday'])
          : null,
      access: parseToAccessType(map['access']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));
}

enum AccessType { user, concierge, condominium }

AccessType parseToAccessType(String access) {
  switch (access) {
    case 'AccessType.concierge':
      return AccessType.concierge;
    case 'AccessType.condominium':
      return AccessType.condominium;
    case 'AccessType.user':
    default:
      return AccessType.user;
  }
}

class Condominium {
  String name;
  GeoPoint localization;
  String? responsible;
  String? condRef;
  Condominium({
    required this.name,
    required this.localization,
    this.responsible,
    this.condRef,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'localization': localization,
      'responsible': responsible,
    };
  }

  factory Condominium.fromMap(Map<String, dynamic> map) {
    return Condominium(
      name: map['name'] ?? '',
      localization: map['localization'],
      responsible: map['responsible'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Condominium.fromJson(String source) =>
      Condominium.fromMap(json.decode(source));
}

// class Localization {
//   double latitude;
//   double longitude;
//   Localization({
//     required this.latitude,
//     required this.longitude,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'latitude': latitude,
//       'longitude': longitude,
//     };
//   }

//   factory Localization.fromMap(Map<String, dynamic> map) {
//     return Localization(
//       latitude: map['latitude']?.toDouble() ?? 0.0,
//       longitude: map['longitude']?.toDouble() ?? 0.0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Localization.fromJson(String source) =>
//       Localization.fromMap(json.decode(source));
// }

class Order {
  String? uid;
  String? description;
  DateTime date;
  OrderStatus status;
  String user;
  String condominiumRef;
  bool selected;
  Order({
    this.uid,
    required this.description,
    required this.date,
    required this.status,
    required this.user,
    required this.condominiumRef,
    this.selected = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'date': Timestamp.fromDate(date),
      'user': user,
      'status': parseOrderStatusToString(status),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      description: map['description'] ?? '',
      date: map['date'].toDate(),
      status: parseToOrderStatus(map['status']),
      user: map['user'],
      condominiumRef: map['condominium'].path,
      selected: false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}

enum OrderStatus { waiting, pending, delivered }

OrderStatus parseToOrderStatus(String? status) {
  switch (status) {
    case 'pending':
      return OrderStatus.pending;
    case 'delivered':
      return OrderStatus.delivered;
    case 'waiting':
    default:
      return OrderStatus.waiting;
  }
}

String parseOrderStatusToString(OrderStatus status) {
  switch (status) {
    case OrderStatus.waiting:
      return 'waiting';
    case OrderStatus.pending:
      return 'pending';
    case OrderStatus.delivered:
      return 'delivered';
  }
}
