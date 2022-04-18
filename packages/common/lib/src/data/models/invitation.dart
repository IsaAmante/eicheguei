import 'dart:convert';

import 'package:common/common.dart';

class Invitation {
  Condominium condominium;
  String? condRef;
  AccessType access;
  bool accepted;
  Invitation({
    required this.condominium,
    this.condRef,
    required this.access,
    required this.accepted,
  });

  Map<String, dynamic> toMap() {
    return {
      'condominium': condominium.condRef,
      'access': access.toString(),
      'accepted': accepted,
    };
  }

  factory Invitation.fromMap(Map<String, dynamic> map) {
    return Invitation(
      condominium: Condominium.fromMap(map['condominium']),
      access: AccessType.user,
      accepted: map['accepted'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Invitation.fromJson(String source) =>
      Invitation.fromMap(json.decode(source));
}
