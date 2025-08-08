// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserStruct extends BaseStruct {
  UserStruct({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? displayName,
    String? token,
    String? wishlistKey,
    int? wishlistId,
  })  : _id = id,
        _email = email,
        _firstName = firstName,
        _lastName = lastName,
        _displayName = displayName,
        _token = token,
        _wishlistKey = wishlistKey,
        _wishlistId = wishlistId;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "firstName" field.
  String? _firstName;
  String get firstName => _firstName ?? '';
  set firstName(String? val) => _firstName = val;

  bool hasFirstName() => _firstName != null;

  // "lastName" field.
  String? _lastName;
  String get lastName => _lastName ?? '';
  set lastName(String? val) => _lastName = val;

  bool hasLastName() => _lastName != null;

  // "displayName" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  set displayName(String? val) => _displayName = val;

  bool hasDisplayName() => _displayName != null;

  // "token" field.
  String? _token;
  String get token => _token ?? '';
  set token(String? val) => _token = val;

  bool hasToken() => _token != null;

  // "wishlistKey" field.
  String? _wishlistKey;
  String get wishlistKey => _wishlistKey ?? '';
  set wishlistKey(String? val) => _wishlistKey = val;

  bool hasWishlistKey() => _wishlistKey != null;

  // "wishlistId" field.
  int? _wishlistId;
  int get wishlistId => _wishlistId ?? 0;
  set wishlistId(int? val) => _wishlistId = val;

  void incrementWishlistId(int amount) => wishlistId = wishlistId + amount;

  bool hasWishlistId() => _wishlistId != null;

  static UserStruct fromMap(Map<String, dynamic> data) => UserStruct(
        id: castToType<int>(data['id']),
        email: data['email'] as String?,
        firstName: data['firstName'] as String?,
        lastName: data['lastName'] as String?,
        displayName: data['displayName'] as String?,
        token: data['token'] as String?,
        wishlistKey: data['wishlistKey'] as String?,
        wishlistId: castToType<int>(data['wishlistId']),
      );

  static UserStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'email': _email,
        'firstName': _firstName,
        'lastName': _lastName,
        'displayName': _displayName,
        'token': _token,
        'wishlistKey': _wishlistKey,
        'wishlistId': _wishlistId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'firstName': serializeParam(
          _firstName,
          ParamType.String,
        ),
        'lastName': serializeParam(
          _lastName,
          ParamType.String,
        ),
        'displayName': serializeParam(
          _displayName,
          ParamType.String,
        ),
        'token': serializeParam(
          _token,
          ParamType.String,
        ),
        'wishlistKey': serializeParam(
          _wishlistKey,
          ParamType.String,
        ),
        'wishlistId': serializeParam(
          _wishlistId,
          ParamType.int,
        ),
      }.withoutNulls;

  static UserStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        firstName: deserializeParam(
          data['firstName'],
          ParamType.String,
          false,
        ),
        lastName: deserializeParam(
          data['lastName'],
          ParamType.String,
          false,
        ),
        displayName: deserializeParam(
          data['displayName'],
          ParamType.String,
          false,
        ),
        token: deserializeParam(
          data['token'],
          ParamType.String,
          false,
        ),
        wishlistKey: deserializeParam(
          data['wishlistKey'],
          ParamType.String,
          false,
        ),
        wishlistId: deserializeParam(
          data['wishlistId'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'UserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserStruct &&
        id == other.id &&
        email == other.email &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        displayName == other.displayName &&
        token == other.token &&
        wishlistKey == other.wishlistKey &&
        wishlistId == other.wishlistId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        email,
        firstName,
        lastName,
        displayName,
        token,
        wishlistKey,
        wishlistId
      ]);
}

UserStruct createUserStruct({
  int? id,
  String? email,
  String? firstName,
  String? lastName,
  String? displayName,
  String? token,
  String? wishlistKey,
  int? wishlistId,
}) =>
    UserStruct(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      displayName: displayName,
      token: token,
      wishlistKey: wishlistKey,
      wishlistId: wishlistId,
    );
