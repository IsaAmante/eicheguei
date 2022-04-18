import 'dart:convert';

import 'package:common/common.dart';

class Invitation {
  Condominium condominium;
  String? condRef;
  AccessType access;
  Invitation({
    required this.condominium,
    this.condRef,
    required this.access,
  });

  Map<String, dynamic> toMap() {
    return {
      'condominium': condominium.toMap(),
      'access': access,
    };
  }

  factory Invitation.fromMap(Map<String, dynamic> map) {
    return Invitation(
      condominium: Condominium.fromMap(map['condominium']),
      access: AccessType.user,
    );
  }

  String toJson() => json.encode(toMap());

  factory Invitation.fromJson(String source) =>
      Invitation.fromMap(json.decode(source));
}
