import 'dart:convert';

import 'package:design/whereToDesign/tickets/tickets_models/tickets_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ticketProvider = Provider<TicketsFunctions>((ref) {
  return TicketsFunctions();
});

class TicketsFunctions {
  List<TicketModel>? ticketsList;
  readJsondataTickets() async {
    //   File file = await File('assets/images/boat.json');
    var jsonStr = await rootBundle.loadString('asset/ticket_booked.json');
    //   String contents = await file.readAsString();

    // Parse the JSON data
    //  List<dynamic> jsonData = jsonDecode(contents);
    List<dynamic> jsonData = jsonDecode(jsonStr);

    // Convert JSON data to List<BoatModel>
    ticketsList = jsonData.map((json) => TicketModel.fromJson(json)).toList();
    return ticketsList;
  }
}
