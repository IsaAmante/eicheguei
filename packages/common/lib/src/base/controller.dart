import 'package:flutter/material.dart';

enum Status { initial, loading, success, error, batatinha }

abstract class Controller with ChangeNotifier {
  Status _status = Status.initial;
  setStatus(Status status) {
    if (status != _status) {
      _status = status;
      notifyListeners();
    }
  }

  bool get isInitial => _status == Status.initial;
  bool get isLoading => _status == Status.loading;
  bool get hasError => _status == Status.error;
  bool get hasSuccess => _status == Status.success;
  bool get isBatatinha => _status == Status.batatinha;
}
