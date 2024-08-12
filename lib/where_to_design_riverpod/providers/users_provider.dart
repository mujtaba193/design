import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../users_model/user_model.dart';

final uaersIdProvider = Provider<UserDataClass>(
  (ref) {
    return UserDataClass();
  },
);

class UserDataClass {
  Future getUsers() async {
    List<UsersModel>? usersId;
    var response = await rootBundle.loadString('asset/user_booking.json');
    List<dynamic> usersList = json.decode(response);

    usersId = usersList.map((e) => UsersModel.fromJson(e)).toList();

    // usersd = usersList.map((e) => UsersModel.fromJson(e)).toList();
    return usersId;
  }
}
