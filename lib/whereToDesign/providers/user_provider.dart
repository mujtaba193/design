import 'dart:convert';
import 'dart:js';

import 'package:design/whereToDesign/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<UsersModel>? usersd;
final userBookingInfoProvider = FutureProvider<List<UsersModel>>((ref) {
  Future<List<UsersModel>> getUsers() async {
    List<UsersModel> usersd;
    var response = await DefaultAssetBundle.of(context as BuildContext)
        .loadString('assets/user_booking.json');
    List<dynamic> usersList = json.decode(response);

    usersd = usersList.map((e) => UsersModel.fromJson(e)).toList();
    return usersd;
  }

  return getUsers();
});

class UserProvider {
  List<UsersModel>? usersd;
  Future<void> getUsers() async {
    var response = await DefaultAssetBundle.of(context as BuildContext)
        .loadString('assets/user_booking.json');
    List<dynamic> usersList = json.decode(response);

    usersd = usersList.map((e) => UsersModel.fromJson(e)).toList();
  }
}
