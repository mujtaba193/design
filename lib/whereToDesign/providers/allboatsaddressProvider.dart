import 'dart:convert';

import 'package:design/whereToDesign/models/boat_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allboataddressProvider = FutureProvider(
  (ref) async {
    late List<BoatModel> boatList;
    var jsonStr = await rootBundle.loadString('assets/images_list.json');

    List<dynamic> jsonData = jsonDecode(jsonStr);

    boatList = jsonData.map((json) => BoatModel.fromJson(json)).toList();

    return boatList;
  },
);
