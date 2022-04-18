library common;

export 'package:provider/provider.dart';
export './src/module/module_interface.dart';

export 'package:firebase_core/firebase_core.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:firebase_auth/firebase_auth.dart';

export './src/components/components.dart';
export './src/consts/consts.dart';
export './src/utils/utils.dart';

export './src/base/base.dart';
export './src/data/models/models.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
