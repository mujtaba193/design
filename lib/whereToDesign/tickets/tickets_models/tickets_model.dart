class TicketModel {
  final int guests_number;
  final int pets_number;
  final int price;
  final DateTime date_time;
  final DateTime boarding_time;
  final String flight_number;
  TicketModel(
      {required this.guests_number,
      required this.pets_number,
      required this.price,
      required this.date_time,
      required this.boarding_time,
      required this.flight_number});

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
        guests_number: json['guests_number'],
        pets_number: json['pets_number'],
        price: json['price'],
        date_time: DateTime.parse(json['date_time']),
        boarding_time: DateTime.parse(json['boarding_time']),
        flight_number: json['flight_number']);
  }
  Map<String, dynamic> toJson() {
    return {
      ' guests_number': guests_number,
      'pets_number': pets_number,
      'price': price,
      'date_time': date_time.toIso8601String(),
      'boarding_time': boarding_time.toIso8601String(),
      'flight_number': flight_number
    };
  }
}
