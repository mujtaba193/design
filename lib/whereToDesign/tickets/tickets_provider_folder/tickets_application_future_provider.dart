import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../tickets_models/tickets_application_model.dart';

final ticketApplicationFutureProvider =
    FutureProvider<List<TicketApplicationModel>>(
  (ref) async {
    List<TicketApplicationModel>? ticketList;

    var jsonStr = await rootBundle.loadString('assets/ticket_application.json');

    List<dynamic> jsonData = jsonDecode(jsonStr);

    ticketList =
        jsonData.map((json) => TicketApplicationModel.fromJson(json)).toList();
    return ticketList;
  },
);
