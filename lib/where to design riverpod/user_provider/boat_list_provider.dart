import 'package:design/where%20to%20design%20riverpod/users_model/boat_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final boatProvider = FutureProvider<List<BoatModelRiverPod>>((ref) async {
  var jsonStr = await rootBundle.loadString('asset/images_list.json');

  return boatListFromJson(jsonStr);
});
