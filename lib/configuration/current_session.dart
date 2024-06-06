

import 'package:spotify/model/user_model.dart';

class CurrentSession {
  static final CurrentSession _shared = CurrentSession._private();

  factory CurrentSession() => _shared;

  CurrentSession._private();

  UserModel? _model;

  void setUser(UserModel model) {
    _model = model;
  }

  UserModel? getUser() {
    if (isAuth()) return _model;
    return null;
  }

  bool isAuth() => _model != null;
}
