import 'dart:convert';

import 'package:design/whereToDesign/tickets/tickets_models/tickets_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ticketProvider = Provider<TicketsFunctions>((ref) {
  return TicketsFunctions();
});

class TicketsFunctions {
  DateTime today = DateTime.now();
  List<TicketModel>? allTicketsList;
  List<TicketModel>? ticketsAfter;
  List<TicketModel>? ticketsArchieved;
  List<TicketModel>? ticketsToday;
  // all tickets///////////////
  readJsondataTickets() async {
    //   File file = await File('assets/images/boat.json');
    var jsonStr = await rootBundle.loadString('asset/ticket_booked.json');
    //   String contents = await file.readAsString();

    // Parse the JSON data
    //  List<dynamic> jsonData = jsonDecode(contents);
    List<dynamic> jsonData = jsonDecode(jsonStr);

    // Convert JSON data to List<BoatModel>
    allTicketsList =
        jsonData.map((json) => TicketModel.fromJson(json)).toList();
    return allTicketsList;
  }

  // tickets for day after today
  ticketAfterToday() async {
    await readJsondataTickets();
    ticketsAfter = allTicketsList!
        .where((element) => element.date_time.isAfter(DateTime.now()))
        .toList();
    return ticketsAfter!.sort((a, b) => b.date_time.compareTo(a.date_time));
  }

  ticketArchieved() async {
    await readJsondataTickets();
    ticketsArchieved = allTicketsList!
        .where((element) => element.date_time.isBefore(DateTime.now()))
        .toList();
    return ticketsArchieved!.sort((a, b) => b.date_time.compareTo(a.date_time));
  }

  // tickets for today
  functionTicketToday() async {
    await readJsondataTickets();
    DateTime now = DateTime.now();
    ticketsToday = allTicketsList!
        .where((element) =>
            element.date_time.year == now.year &&
            element.date_time.month == now.month &&
            element.date_time.day == now.day)
        .toList();
    // Sorting

    return ticketsToday!.sort((a, b) => b.date_time.compareTo(a.date_time));
  }
}
