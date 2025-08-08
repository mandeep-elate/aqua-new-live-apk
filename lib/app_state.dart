import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();
  List<String> isFavorite = [];
  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _userId = prefs.getInt('ff_userId') ?? _userId;
    });

    _safeInit(() {
      _firstName = prefs.getString('ff_firstName') ?? _firstName;
    });
    _safeInit(() {
      _lastName = prefs.getString('ff_lastName') ?? _lastName;
    });
    _safeInit(() {
      _telephone = prefs.getString('ff_telephone') ?? _telephone;
    });
    _safeInit(() {
      _email = prefs.getString('ff_email') ?? _email;
    });
    _safeInit(() {
      _wishlistKey = prefs.getString('ff_wishlistKey') ?? _wishlistKey;
    });
    _safeInit(() {
      _wishlistId = prefs.getInt('ff_wishlistId') ?? _wishlistId;
    });
    _safeInit(() {
      _firstName = prefs.getString('ff_firstName') ?? _firstName;
    });
    _safeInit(() {
      _token = prefs.getString('ff_token') ?? _token;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  int _userId = 0;
  int get userId => _userId;
  set userId(int value) {
    _userId = value;
    prefs.setInt('ff_userId', value);
  }



  int _cartCount = 1; // Default value of 1

  int get cartCount => _cartCount;

  set cartCount(int value) {
    _cartCount = value;
   // notifyListeners();  // Notify listeners when the cart count changes
  }

 /* int _cartCount = 1;
  int get cartCount => _cartCount;
  set cartCount(int value) {
    _cartCount = value;
  }
*/
  String _firstName = '';
  String get firstName => _firstName;
  set firstName(String value) {
    _firstName = value;
    prefs.setString('ff_firstName', value);
  }

  String _lastName = '';
  String get lastName => _lastName;
  set lastName(String value) {
    _lastName = value;
    prefs.setString('ff_lastName', value);
  }

  String _telephone = '';
  String get telephone => _telephone;
  set telephone(String value) {
    _telephone = value;
    prefs.setString('ff_telephone', value);
  }

  String _email = '';
  String get email => _email;
  set email(String value) {
    _email = value;
    prefs.setString('ff_email', value);
  }

  String _token = '';
  String get token => _token;
  set token(String value) {
    _token = value;
    prefs.setString('ff_token', value);
  }

  String _wishlistKey = '';
  String get wishlistKey => _wishlistKey;
  set wishlistKey(String value) {
    _wishlistKey = value;
    prefs.setString('ff_wishlistKey', value);
  }

  int _wishlistId = 0;
  int get wishlistId => _wishlistId;
  set wishlistId(int value) {
    _wishlistId = value;
    prefs.setInt('ff_wishlistId', value);
  }



}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
