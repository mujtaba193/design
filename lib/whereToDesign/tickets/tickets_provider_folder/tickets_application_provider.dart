import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../tickets_models/tickets_application_model.dart';

final ticketApplicationProvider = Provider<TicketsApplicationHolder>(
  (ref) {
    return TicketsApplicationHolder();
  },
);

class TicketsApplicationHolder {
  int time = DateTime.now().minute;
  List<TicketApplicationModel>? ticketList;
  readJsonDataApp() async {
    var jsonStr = await rootBundle.loadString('asset/ticket_application.json');

    List<dynamic> jsonData = jsonDecode(jsonStr);

    ticketList =
        jsonData.map((json) => TicketApplicationModel.fromJson(json)).toList();
    return ticketList;
  }

  timetFunction() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      time++;
    });
    return time;
  }
}
