import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/second_list_image_model.dart';

final secondListImageProvider = Provider<Second>((ref) {
  return Second();
});

class Second {
  List<SecondLIModel> secondList = [];
  readJsondata() async {
    var jsonStr = await rootBundle.loadString('assets/second_list_image.json');

    List<dynamic> jsonData = jsonDecode(jsonStr);

    secondList = jsonData.map((json) => SecondLIModel.fromJson(json)).toList();
  }
}
