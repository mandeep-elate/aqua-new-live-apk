import 'package:rxdart/rxdart.dart';

import '/backend/schema/structs/index.dart';
import 'custom_auth_manager.dart';

class AqaumaticAppAuthUser {
  AqaumaticAppAuthUser({
    required this.loggedIn,
    this.uid,
    this.userData,
  });

  bool loggedIn;
  String? uid;
  UserStruct? userData;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<AqaumaticAppAuthUser> aqaumaticAppAuthUserSubject =
    BehaviorSubject.seeded(AqaumaticAppAuthUser(loggedIn: false));
Stream<AqaumaticAppAuthUser> aqaumaticAppAuthUserStream() =>
    aqaumaticAppAuthUserSubject
        .asBroadcastStream()
        .map((user) => currentUser = user);
